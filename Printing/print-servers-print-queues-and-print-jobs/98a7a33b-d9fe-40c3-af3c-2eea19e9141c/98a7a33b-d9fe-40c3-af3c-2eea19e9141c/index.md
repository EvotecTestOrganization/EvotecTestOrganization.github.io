# Delete All Printers on a Print Server

## Original Links

- [x] Original Technet URL [Delete All Printers on a Print Server](https://gallery.technet.microsoft.com/98a7a33b-d9fe-40c3-af3c-2eea19e9141c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/98a7a33b-d9fe-40c3-af3c-2eea19e9141c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes all the printers from a print server.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next
```

