# Disable Advanced Printing Features

## Original Links

- [x] Original Technet URL [Disable Advanced Printing Features](https://gallery.technet.microsoft.com/Disable-Advanced-Printing-d014f75b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Disable-Advanced-Printing-d014f75b/description)
- [x] Download: [Download Link](Download\PrintServerDisableAPF.ps1)

## Output from Technet Gallery

This powershell script will let you specify a print server and export a list of printers to a csv file. Then it will import that same list of printers loop through each printer and disable the advanced printing features for each queue. It does this by creating  a foreach loop and taking the name field of the csv file and converting each printer to a local variable to be called in the native vbscript prnnfg.vbs

```
New-Item -ItemType directory -Path C:\Printer_Exports -ErrorAction SilentlyContinue
$PrintServer = Read-host "Enter Print Server Name"
$SavePath = "c:\Printer_Exports\$PrintServer.csv"
Get-WMIObject -Class Win32_Printer -Computer $Printserver | Select Name | Export-CSV -Path $SavePath
Write-Host "File saved to:" $SavePath
$PrinterCSV = Import-CSV $SavePath
foreach($Printer in $PrinterCSV)
{
    Write-Host "Disabling Advanced Printing Features: $Printer"
    $CurrentPrinter = $Printer.Name
    cscript c:\windows\system32\printing_admin_scripts\en-us\prncnfg.vbs -t -p $CurrentPrinter +rawonly
}
```

