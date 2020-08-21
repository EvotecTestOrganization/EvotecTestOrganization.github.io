# Set the Printer Default Paper Sour

## Original Links

- [x] Original Technet URL [Set the Printer Default Paper Sour](https://gallery.technet.microsoft.com/Set-the-Printer-Default-2fd46a4b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Set-the-Printer-Default-2fd46a4b/description)
- [x] Download: [Download Link](Download\PrinterDefaultPaperSourceV1.1.ps1)

## Output from Technet Gallery

```
.\setprinter $PrinterName 8 "pDevMode=dmDefaultSource=$PaperTray"
```

This script uses the Microsoft "SetPrinter.exe" utility to set the default paper source for the printer defined in the $PrinterName variable.  The value of the paper source is defined in the $PaperTray variable.

To run the script:

1.  Download the setprinter.exe file from Microsoft.  It is part of the Windows Server 2003 Resource Kit Tools.

A suggestion is to install the Resource Kit on a workstation, and to then copy the SetPrinter.exe file to the print server.

Download URL:  http://www.microsoft.com/en-us/download/details.aspx?id=17657

If the print server is running Windows Server 2012 or Windows 8.X, then do not use this utility.  Instead, use the PrintManagement PowerShell module.

http://technet.microsoft.com/en-us/library/hh918357.aspx

2.  Modify the $SetPrinter variable to point to the location of the setprinter.exe file.

3.  Modify the $PrinterName variable to be the name of the printer.

4.  Modify the $PaperTray variable to set the default source paper tray.  The acceptable values are 15, 259, 260, 261, and 262.

Here is the corresponding value per paper tray.

15 = Automatically Select

262 = Printer Auto Select

259 = Tray 1

260 = Tray 2

261 = Tray 3

5.  Run the script.

