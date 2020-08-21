# Rename a Printer

## Original Links

- [x] Original Technet URL [Rename a Printer](https://gallery.technet.microsoft.com/82f70368-7f82-4f4e-8117-024ed215405b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/82f70368-7f82-4f4e-8117-024ed215405b/description)
- [x] Download: Not available.

## Output from Technet Gallery

Renames both a printer and its printer share name.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where DeviceID = 'HP LaserJet 4Si M'")

For Each objPrinter in colPrinters
    objPrinter.RenamePrinter("ArtDepartmentPrinter")
Next

Set colPrinters = objWMIService.ExecQuery _
    ("Select * From Win32_Printer Where DeviceID = 'ArtDepartmentPrinter' ")

For Each objPrinter in colPrinters
    objPrinter.ShareName = "ArtDepartmentPrinter"
    objPrinter.Put_
Next
```

