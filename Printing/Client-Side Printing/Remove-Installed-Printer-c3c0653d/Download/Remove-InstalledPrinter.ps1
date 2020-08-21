Function Remove-InstalledPrinter
{
<#
.SYNOPSIS
Uses Get-WMIObject Win32_Printer to remove installed printer.
 
.DESCRIPTION
Uses Get-WMIObject Win32_Printer to remove installed printer.

.PARAMETER ComputerName
Accepts input for one or more computer names.

.EXAMPLE
Remove-InstalledPrinter -ComputerName computername1 -PrinterName Ricoh 4504

.EXAMPLE
"computername1" | Remove-InstalledPrinter -PrinterName Ricoh 4504

.EXAMPLE
Run on a local computer
Remove-InstalledPrinter
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
                    ValueFromPipeline=$True,
                    ValueFromPipelinebyPropertyName=$True)]
        [string[]]$ComputerName = $env:ComputerName,

        [Parameter(Mandatory=$True)]
        [string]$PrinterName
    )

    BEGIN
    {
		Write-Output "`nRemoving installed printer ...`n"
    }

    PROCESS
    {
        foreach ($Computer in $ComputerName)
        {
            if ( Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue )
            {
                Write-Output "$Computer is online ..."
                
                #Get-WMIObject Win32_Printer -ComputerName $Computer | Where-Object {$Computer.Name -like $PrinterName} | foreach{$Computer.delete()}
                
                #(get-wmiobject -q "select * from win32_printer where name='$PrinterName'").psbase.delete()
                
                $t = get-wmiobject -computername $Computer -query "SELECT * FROM win32_printer WHERE name = '$PrinterName'"; $t.delete()
            }
            else
            {
                Write-Output "$Computer is offline ..."
            }
        }
    }

    END
    {
        Write-Output "Script complete!  Check over output for any warnings."
    }

}