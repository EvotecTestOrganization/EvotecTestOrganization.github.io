# ransfer Print Jobs to a Different Print Queu

## Original Links

- [x] Original Technet URL [ransfer Print Jobs to a Different Print Queu](https://gallery.technet.microsoft.com/a0f68ae3-3a9b-4098-95f7-6f8d21a0b623)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/a0f68ae3-3a9b-4098-95f7-6f8d21a0b623/description)
- [x] Download: Not available.

## Output from Technet Gallery

Changes the TCP/IP printer port for a logical printer, which has the net effect of transferring existing print jobs to the new printer port, and thus to a different printer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set objPrinter = objWMIService.Get _
    ("Win32_Printer.DeviceID='ArtDepartmentPrinter'")

objPrinter.PortName = "IP_192.168.1.10"
objPrinter.Put_
```

