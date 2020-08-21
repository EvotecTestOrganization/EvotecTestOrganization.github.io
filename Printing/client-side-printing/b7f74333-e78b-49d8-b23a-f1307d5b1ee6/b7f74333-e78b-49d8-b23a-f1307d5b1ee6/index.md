# ListSharedPrintersAddPrintConnection.ps1

## Original Links

- [x] Original Technet URL [ListSharedPrintersAddPrintConnection.ps1](https://gallery.technet.microsoft.com/b7f74333-e78b-49d8-b23a-f1307d5b1ee6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/b7f74333-e78b-49d8-b23a-f1307d5b1ee6/description)
- [x] Download: Not available.

## Output from Technet Gallery

## Description

This script allows you to list all shared printers on a remote computer. In addition, it gives you the ability to add a printer connection from the remote computer to your local computer. Example of usage: Add printer connection: -printerpath "[\\berlin\testprinter](\\berlin\testprinter)" OR list printers: -computer  berlin -list This script was discussed in the[Hey Scripting Guy article from 5/19/2009](http://blogs.technet.com/b/heyscriptingguy/archive/2009/05/19/how-can-i-use-wmi-to-add-a-printer-connection-by-using-windows-powershell.aspx).

## Script

PowerShell

```
# ------------------------------------------------------------------------ # NAME: ListSharedPrintersAddPrintConnection.ps1 # AUTHOR: ed wilson, Microsoft # DATE: 5/17/2009 # # KEYWORDS: Win32_Printer, AddPrinterConnection # List shared Printers, function, evaluate return value # COMMENTS: This script will list shared printers on a # remote comptuer. It also gives you the ability to add a # printer connection from the remote computer to your # computer.  # Add printer connection: -printerpath "\\berlin\testprinter" # list printers: -computer  berlin -list # HSG-5/19/2009 # ------------------------------------------------------------------------ Param($computer, $printerPath, [switch]$list)  Function Add-PrinterConnection([string]$printerPath) {  Write-Host -foregroundcolor cyan "Adding printer $printerpath"   $printClass = [wmiclass]"win32_printer"   $printClass.AddPrinterConnection($printerPath) } #end Add-PrinterConnection  Function Get-Printer($computer) {  Get-WmiObject -class Win32_Printer -computer $computer } #end Get-Printer  Function Format-Printer($printObject) {  Write-Host -foregroundcolor cyan "Shared printers on $computer"  $printObject |   Where-Object { $_.sharename } |  Format-Table -property sharename, location, comment -autosize -wrap } #end Format-Printer  Function Get-SuccessCode($code) {  if($code.ReturnValue -eq 0)   { Write-Host -foregroundcolor green "Add Printer connection suceeded!" }  Else   { Write-Host -foregroundcolor red "Add Printer connection failed with $($code.returnvalue)" } } #end get-successcode  # *** Entry Point to Script *** if($list) { Format-Printer(Get-Printer($computer)) ; exit } if($printerPath)    { Get-SuccessCode -code (Add-PrinterConnection($printerPath))  ; exit }
```

***Click here** to add your script.*

