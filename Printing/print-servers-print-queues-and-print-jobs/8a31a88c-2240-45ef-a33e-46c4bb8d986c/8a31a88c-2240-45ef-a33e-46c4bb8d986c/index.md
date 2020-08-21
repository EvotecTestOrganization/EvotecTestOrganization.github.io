# Pause a Printer

## Original Links

- [x] Original Technet URL [Pause a Printer](https://gallery.technet.microsoft.com/8a31a88c-2240-45ef-a33e-46c4bb8d986c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/8a31a88c-2240-45ef-a33e-46c4bb8d986c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Pauses a printer named ArtDepartmentPrinter.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Name = 'ArtDepartmentPrinter'")

For Each objPrinter in colInstalledPrinters 
    ObjPrinter.Pause()
Next
```

