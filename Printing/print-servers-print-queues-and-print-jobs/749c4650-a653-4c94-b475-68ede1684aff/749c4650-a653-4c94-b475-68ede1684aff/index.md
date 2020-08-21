# Modify Printer Priority

## Original Links

- [x] Original Technet URL [Modify Printer Priority](https://gallery.technet.microsoft.com/749c4650-a653-4c94-b475-68ede1684aff)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/749c4650-a653-4c94-b475-68ede1684aff/description)
- [x] Download: Not available.

## Output from Technet Gallery

Sets the priority for a printer to 2.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrinters = objWMIService.ExecQuery _
    ("Select * From Win32_Printer where DeviceID = 'ArtDepartmentPrinter' ")

For Each objPrinter in colPrinters
    objPrinter.Priority = 2
    objPrinter.Put_
Next
```

