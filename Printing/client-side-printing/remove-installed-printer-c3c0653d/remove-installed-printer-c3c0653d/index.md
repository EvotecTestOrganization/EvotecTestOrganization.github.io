# Remove Installed Printer from remote computers

## Original Links

- [x] Original Technet URL [Remove Installed Printer from remote computers](https://gallery.technet.microsoft.com/Remove-Installed-Printer-c3c0653d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Remove-Installed-Printer-c3c0653d/description)
- [x] Download: [Download Link](Download\Remove-InstalledPrinter.ps1)

## Output from Technet Gallery

Remove Installed Printer from remote computers.  Uses Get-WMIObject Win32\_Printer to remove the installed printer.  Accepts input for one or more remote computer names.  EXAMPLE1: Remove-InstalledPrinter -ComputerName computername1 -PrinterName  Ricoh 4504    EXAMPLE2: "computername1" | Remove-InstalledPrinter -PrinterName Ricoh 4504

```
Function Remove-InstalledPrinter
{
<#
.SYNOPSIS
Uses Get-WMIObject Win32_Printer to remove installed printer.
.DESCRIPTION
Uses Get-WMIObject Win32_Printer to remove installed printer.
.PARAMETER ComputerName
Accepts input for one or more computer names.
.EXAMPLE
Remove-InstalledPrinter -ComputerName computername1 -PrinterName Ricoh 4504
.EXAMPLE
"computername1" | Remove-InstalledPrinter -PrinterName Ricoh 4504
.EXAMPLE
Run on a local computer
Remove-InstalledPrinter
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
                    ValueFromPipeline=$True,
                    ValueFromPipelinebyPropertyName=$True)]
        [string[]]$ComputerName = $env:ComputerName,
        [Parameter(Mandatory=$True)]
        [string]$PrinterName
    )
    BEGIN
    {
        Write-Output "`nRemoving installed printer ...`n"
    }
    PROCESS
    {
        foreach ($Computer in $ComputerName)
        {
            if ( Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue )
            {
                Write-Output "$Computer is online ..."
                #Get-WMIObject Win32_Printer -ComputerName $Computer | Where-Object {$Computer.Name -like $PrinterName} | foreach{$Computer.delete()}
                #(get-wmiobject -q "select * from win32_printer where name='$PrinterName'").psbase.delete()
                $t = get-wmiobject -computername $Computer -query "SELECT * FROM win32_printer WHERE name = '$PrinterName'"; $t.delete()
            }
            else
            {
                Write-Output "$Computer is offline ..."
            }
        }
    }
    END
    {
        Write-Output "Script complete!  Check over output for any warnings."
    }
}
```

