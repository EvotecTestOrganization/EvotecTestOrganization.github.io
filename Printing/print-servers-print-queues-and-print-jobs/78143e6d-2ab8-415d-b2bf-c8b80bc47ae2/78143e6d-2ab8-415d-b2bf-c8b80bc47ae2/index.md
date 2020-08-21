# Resume All Paused Printers

## Original Links

- [x] Original Technet URL [Resume All Paused Printers](https://gallery.technet.microsoft.com/78143e6d-2ab8-415d-b2bf-c8b80bc47ae2)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/78143e6d-2ab8-415d-b2bf-c8b80bc47ae2/description)
- [x] Download: Not available.

## Output from Technet Gallery

Resumes all the paused printers on a print server.

Visual Basic

```
Const PRINTER_IS_PAUSED = 8

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer where ExtendedPrinterStatus = 8")

For Each objPrinter in colInstalledPrinters 
    ObjPrinter.Resume()
Next
```

