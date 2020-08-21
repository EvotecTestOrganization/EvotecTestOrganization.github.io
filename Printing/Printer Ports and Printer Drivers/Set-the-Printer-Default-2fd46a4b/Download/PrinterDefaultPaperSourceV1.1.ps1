<#
Created:  January 23, 2014
Version:  1.1
Notes:

This script uses the Microsoft "SetPrinter.exe" utility to set the 
default paper source for the printer defined in the $PrinterName 
variable.  The value of the paper source is defined in the 
$PaperTray variable.

To run the script:

1.  Download the setprinter.exe file from Microsoft.  It is part of the Windows 
Server 2003 Resource Kit Tools.

A suggestion is to install it on a workstation, and to then copy the 
SetPrinter.exe file to the print server.

Download URL:  http://www.microsoft.com/en-us/download/details.aspx?id=17657

If the print server is running Windows Server 2012 or Windows 8.X, then do not use this 
utility.  Instead, use the PrintManagement PowerShell module.

http://technet.microsoft.com/en-us/library/hh918357.aspx

2.  Modify the $SetPrinter variable to point to the location of the 
setprinter.exe file, see STEP TWO below.

3.  Modify the $PrinterName variable to be the name of the printer, see 
STEP THREE below.

4.  Modify the $PaperTray variable to set the default source paper tray, see 
STEP FOUR below.  The acceptable values are 15, 259, 260, 261, and 262.

Here is the corresponding value per paper tray.

15 = Automatically Select
262 = Printer Auto Select
259 = Tray 1
260 = Tray 2
261 = Tray 3

5.  Run the script.

#>

# STEP TWO - Set the location of setprinter.exe
$SetPrinter = "C:\Program Files\Windows Resource Kits\Tools"

# STEP THREE - Set the name of the printer
$PrinterName = "PrinterName"

# STEP FOUR - Set the default source paper tray.
$PaperTray = "261"

# Change directories to the location of the setprinter.exe file.
Set-Location $SetPrinter

# Modify the default paper source.
.\setprinter $PrinterName 8 "pDevMode=dmDefaultSource=$PaperTray"

# This is an option step to display the current value of the defalt paper source.
# .\setprinter -show $PrinterName 8

