# Get installed printers from local or remote computers

## Original Links

- [x] Original Technet URL [Get installed printers from local or remote computers](https://gallery.technet.microsoft.com/Get-installed-printers-8937f77b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Get-installed-printers-8937f77b/description)
- [x] Download: [Download Link](Download\Get-InstalledPrinter.ps1)

## Output from Technet Gallery

This function uses the Get-WMIObject Win32\_Printer class to get all installed printers on a local or remote computer.  The input will accept a single or multiple computer names.  If you like my PowerShell Tool please give it some stars under Ratings.   If you have any tips for improvement or any general comments please feel free to leave them on the Q and A tab.

Examples of usage:

Example 1:

Type the function name 'Get-InstalledPrinter' and hit enter.  The function will prompt you for any required input.

Example 2:

Get-InstalledPrinter -ComputerName 'computername1'

Example 3:

'computername1' | Get-InstalledPrinter

```
function Get-InstalledPrinter
{
<#
.SYNOPSIS
Uses Get-WMIObject Win32_Printer to list all printers installed.
.DESCRIPTION
Uses Get-WMIObject Win32_Printer to list all printers installed.
.PARAMETER ComputerName
Accepts input for one or more computer names.
.EXAMPLE
Get-InstalledPrinter -ComputerName computername1
.EXAMPLE
"computername1" | Get-InstalledPrinter
.EXAMPLE
Run on a local computer
Get-InstalledPrinter
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,
                    ValueFromPipeline=$True,
                    ValueFromPipelinebyPropertyName=$True)]
        [string[]]$ComputerName
    )
    BEGIN
    {
        Write-Output "`nGetting all installed printers ...`n"
    }
    PROCESS
    {
        foreach ($Computer in $ComputerName)
        {
            if ( Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue )
            {
                Write-Output "$Computer"
                $printer = Get-WMIObject Win32_Printer -ComputerName $Computer | Select-Object Name,Location,PortName #Try Caption instead of Name
                $printer
            }
            else
            {
                Write-Warning "$Computer is not pingable ..."
            }
        }
    }
    END
    {
        Write-Output "The script is complete!  Check over output for any warnings."
    }
}
```

