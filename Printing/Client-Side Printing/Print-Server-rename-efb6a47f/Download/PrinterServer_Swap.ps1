#set-executionpolicy unrestricted

#Find the default Printer
$getDefaultPrinter =  (Get-WMIObject -class Win32_Printer -Filter Default=True | Select Name).Name

#Parse default printer name up to after Servername
$replacedDefault = $getDefaultPrinter.Split('\')[0..2] -join '\'

#Add backslash - lazy join...
$replacedDefault = $replacedDefault +"\"

#Text manipualtion to create default printer
$default = $getdefaultprinter.replace($replacedDefault,"\\QAV-Bacsrv\")


#Hostname
$hname = $env:computername

#Old printers to be removed - add as many
$gordons = "\\QAV-SS1\Gordon's Printer"
$events = "\\QAV-SS1\Events"
$events2 = "\\qav-sccm-demo\Events2"


#New printers to be installed
$GordonsNew = "\\QAVBACSRV\testPrinter"
$eventsNew = "\\QAV-BACSRV\Events"
$events2New = "\\QAVBACSRV\Events2"

#Array to hold installed printer.name
$refinedPrinters = @()

#WMI query to find installed printers
$printers = Get-WmiObject -Class Win32_Printer -ComputerName $hname

#Build the $refinedPrinters array
Foreach ($p in $printers){$refinedPrinters +=($p.name)}


#'If statements' to find printers that require deleting - add as many as required

#\\QAV-SS1\Gordon's Printer
If($refinedPrinters -contains $gordons){(New-Object -ComObject WScript.Network).RemovePrinterConnection($gordons);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($GordonsNew)}

#\\QAV-SS1\events
If($refinedPrinters -contains $events){(New-Object -ComObject WScript.Network).RemovePrinterConnection($events);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($eventsNew)}

#\\QAV-qav-sccm-demo\events2
If($refinedPrinters -contains $events2){(New-Object -ComObject WScript.Network).RemovePrinterConnection($events2);(New-Object -ComObject WScript.Network).AddWindowsPrinterConnection($events2New)}


#Set default printer
(New-Object -ComObject WScript.Network).SetDefaultPrinter($default)

#Echo the array for error handling
$refinedPrinters


