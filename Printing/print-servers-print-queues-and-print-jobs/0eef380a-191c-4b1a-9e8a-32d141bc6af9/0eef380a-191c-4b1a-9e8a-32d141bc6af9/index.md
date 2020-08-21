# Modify Printer Availability

## Original Links

- [x] Original Technet URL [Modify Printer Availability](https://gallery.technet.microsoft.com/0eef380a-191c-4b1a-9e8a-32d141bc6af9)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/0eef380a-191c-4b1a-9e8a-32d141bc6af9/description)
- [x] Download: Not available.

## Output from Technet Gallery

Configures a printer so that documents can only be printed between 8:00 AM and 6:00 PM.

Visual Basic

```
dtmStartTime= "********080000.000000+000"
dtmEndTime= "********180000.000000+000"

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrinters = objWMIService.ExecQuery _
    ("Select * From Win32_Printer Where DeviceID = 'ArtDepartmentPrinter' ")

For Each objPrinter in colPrinters
    objPrinter.StartTime = dtmStartTime
    objPrinter.UntilTime = dtmEndTime
    objPrinter.Put_
Next
```

