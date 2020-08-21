# Delete Specific Printers

## Original Links

- [x] Original Technet URL [Delete Specific Printers](https://gallery.technet.microsoft.com/67382d47-85dc-4a18-98f2-96486de98189)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/67382d47-85dc-4a18-98f2-96486de98189/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes all HP QuietJet printers installed on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where DriverName = 'HP QuietJet'")

For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next
```

