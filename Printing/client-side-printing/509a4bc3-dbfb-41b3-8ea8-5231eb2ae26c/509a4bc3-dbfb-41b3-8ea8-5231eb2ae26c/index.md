# Delete a Printer

## Original Links

- [x] Original Technet URL [Delete a Printer](https://gallery.technet.microsoft.com/509a4bc3-dbfb-41b3-8ea8-5231eb2ae26c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/509a4bc3-dbfb-41b3-8ea8-5231eb2ae26c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes a printer named ScriptedPrinter.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer where DeviceID = 'ScriptedPrinter'")

For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next
```

