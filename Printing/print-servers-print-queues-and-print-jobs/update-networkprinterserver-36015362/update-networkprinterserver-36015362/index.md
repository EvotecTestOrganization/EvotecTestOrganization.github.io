# Update-NetworkPrinterServerConnection

## Original Links

- [x] Original Technet URL [Update-NetworkPrinterServerConnection](https://gallery.technet.microsoft.com/Update-NetworkPrinterServer-36015362)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Update-NetworkPrinterServer-36015362/description)
- [x] Download: [Download Link](Download\Update-NetworkPrinterServerConnection.ps1)

## Output from Technet Gallery

```
<#
.SYNOPSIS
    Migrates network printers from one print server to another.
.DESCRIPTION
    Migrates all networked printers from one specified print server to another print server.
.INPUTS
    System.StringArray.
.OUTPUTS
    None.
.EXAMPLE
    Update-NetworkPrintersServerConnection -OldPrintServer "\\MyOldPS" -NewPrintServer "\\MyNewPS"
.NOTES
    This is done with a ComObject allowing for use in PowerShell V2, before the Get-Printer, Add-Printer and Remove-Printer Cmdlets where introduced.
    The default printer, if migrated, will be reset as the default printer with the updated connection.
.LINK
    http://dotps1.github.io
.LINK
    http://technet.microsoft.com/en-us/library/dd347648.aspx
#>
Function Update-NetworkPrintersServerConnection
{
    [CmdletBinding()]
    [OutputType([Void])]
    Param
    (
        # ComputerName, Type String, The name(s) of the systems to migrate printers on.
        [Parameter(Position = 0,
                   ValueFromPipeLine = $true)]
        [ValidateScript({ if (Test-Connection -ComputerName $_ -Quiet -Count 2) { return $true } else { throw "Failed to connect to $_.  Please ensure the system is available." } })]
        [String[]]
        $ComputerName = $env:COMPUTERNAME,
        # OldPrintServer, Type String, Name of current Print Server to update from.  String must start with '\\'.
        [Parameter(Mandatory = $true,
                   Position = 1)]
        [ValidateScript({ if ($_.StartsWith("\\")){ return $true } else { throw "Parameter $_ does not start with '\\'." } })]
        [String]
        $OldPrintServer,
        # NewPrintServer, Type String, Name of new Print Server to update to.  String must start with '\\'.
        [Parameter(Mandatory = $true,
                   Position = 2)]
        [ValidateScript({ if ($_.StartsWith("\\")){ return $true } else { throw "Parameter $_ does not start with '\\'." } })]
        [ValidateScript({ if (Test-Connection -ComputerName $_.TrimStart("\\") -Quiet -Count 2) { return $true } else { throw "Failed to ping $_.  Please ensure the system is available." } })]
        [String]
        $NewPrintServer
    )
    Begin
    {
        $comObject = New-Object -ComObject WScript.Network
    }
    Process
    {
        try
        {
            $printers = Get-WMIObject -Class Win32_Printer -Namespace root\CIMV2 -Property ServerName,Default,ShareName,Name,network -ComputerName $ComputerName -ErrorAction Stop
        }
        catch
        {
            throw "Unable to connect to thw Win32_Printer Class on $ComputerName."
        }
        if ($printers -ne $null)
        {
            $defaultPrinter = $printers | ?{ $_.Default -eq $true }
            $oldPrinters = $printers | ?{ $_.ServerName -eq $OldPrintServer }
            foreach ($printer in $oldPrinters)
            {
                $comObject.RemovePrinterConnection("$($printer.Name)")
                $comObject.AddWindowsPrinterConnection("$($NewPrintServer + "\" + $printer.ShareName)")
            }
        }
        if ($oldPrinters.ShareName -contains $defaultPrinter.ShareName)
        {
            $comObject.SetDefaultPrinter("$($NewPrintServer + "\" + $defaultPrinter.ShareName)")
        }
    }
    End
    {
        [Void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($comObject)
        Remove-Variable comObject
    }
}
```

This function is used to migrate existing network printer connections from one print server to another.  Just specify the old print server name and the new print server name, and all existing connections that are from that server will be deleted, and  then recreated with the new server name.  This function used a ComObject rather then the \*-Printer Cmdlets, so it can be used in PowerShell V2.  Use at your own risk, and please rate this script if it works for you!  enjoy.

