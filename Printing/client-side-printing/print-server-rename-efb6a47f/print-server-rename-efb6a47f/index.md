# Rename a print server or replace a printer

## Original Links

- [x] Original Technet URL [Rename a print server or replace a printer](https://gallery.technet.microsoft.com/Print-Server-rename-efb6a47f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Print-Server-rename-efb6a47f/description)
- [x] Download: [Download Link](Download\PrinterServer_Swap.ps1)

## Output from Technet Gallery

I'm sharing a script which can be used in many ways, firstly when you are replacing physical printers that use different drivers, secondly when replacing the print server that the printer shares reside. . The printer share doesn't  need to be called  the same name and the server which it resides can be different. It's not massively complex, but useful.  I used it to swap out hardware printers of a different make and model, running on a different server.  With some simple editing you can swap  out the print server, or the print server, you can even rename the share name,  just make sure they correspond in the script.  You get the picture...

I've used this to replace printers without anyone knowing, just to free me up some time.  It parses the default printer, and sets the default printer to match the share name (or corresponding share name) so that the swap is seamless, what ever the share  name is called.

```
#set-executionpolicy unrestricted
#Find the default Printer
$getDefaultPrinter =  (Get-WMIObject -class Win32_Printer -Filter Default=True | Select Name).Name
#Parse default printer name up to after Servername
$replacedDefault = $getDefaultPrinter.Split('\')[0..2] -join '\'
#Add backslash - lazy join...
$replacedDefault = $replacedDefault +"\"
#Text manipualtion to create default printer
$default = $getdefaultprinter.replace($replacedDefault,"\\QAV-Bacsrv\")
#Hostname
$hname = $env:computername
#Old printers to be removed - add as many
$gordons = "\\QAV-SS1\GPrinter"
$events = "\\QAV-SS1\Events"
$events2 = "\\qav-sccm-demo\Events2"
#New printers to be installed
$GordonsNew = "\\QAVBACSRV\testPrinter"
$eventsNew = "\\QAV-BACSRV\Events"
$events2New = "\\QAVBACSRV\Events2"
#Array to hold installed printer.name
$refinedPrinters = @()
#WMI query to find installed printers
$printers = Get-WmiObject -Class Win32_Printer -ComputerName $hname
#Build the $refinedPrinters array
Foreach ($p in $printers){$refinedPrinters +=($p.name)}
#'If statements' to find printers that require deleting - add as many as required
#\\QAV-SS1\Gordon's Printer
If($refinedPrinters -contains $gordons){(New-Object -ComObject WScript.Network).RemovePrinterConnection($gordons);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($GordonsNew)}
#\\QAV-SS1\events
If($refinedPrinters -contains $events){(New-Object -ComObject WScript.Network).RemovePrinterConnection($events);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($eventsNew)}
#\\QAV-qav-sccm-demo\events2
If($refinedPrinters -contains $events2){(New-Object -ComObject WScript.Network).RemovePrinterConnection($events2);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($events2New)}
#Set default printer
(New-Object -ComObject WScript.Network).SetDefaultPrinter($default)
#Echo the array for error handling
$refinedPrinters
```

