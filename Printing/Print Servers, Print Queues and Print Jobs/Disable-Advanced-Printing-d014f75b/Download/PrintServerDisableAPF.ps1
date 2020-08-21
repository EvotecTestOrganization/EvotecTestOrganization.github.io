<#
Programmer:      Phillip James Mengel
Company:         SiiDSofT.net
Date:            03/28/14
Function:        Export all the printers on a print server and disable advanced printing features.
Name:            GetPrinters.ps1
#>

New-Item -ItemType directory -Path C:\Printer_Exports -ErrorAction SilentlyContinue

$PrintServer = Read-host "Enter Print Server Name"

$SavePath = "c:\Printer_Exports\$PrintServer.csv"

Get-WMIObject -Class Win32_Printer -Computer $Printserver | Select Name | Export-CSV -Path $SavePath

Write-Host "File saved to:" $SavePath

$PrinterCSV = Import-CSV $SavePath

foreach($Printer in $PrinterCSV)
{
   
    Write-Host "Disabling Advanced Printing Features: $Printer"

    $CurrentPrinter = $Printer.Name

    cscript c:\windows\system32\printing_admin_scripts\en-us\prncnfg.vbs -t -p $CurrentPrinter +rawonly

}


