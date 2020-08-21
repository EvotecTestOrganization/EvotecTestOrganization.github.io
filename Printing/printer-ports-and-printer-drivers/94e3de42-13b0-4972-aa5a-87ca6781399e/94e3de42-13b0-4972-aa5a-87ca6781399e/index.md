# Add a TCP/IP Printer Port and Printer

## Original Links

- [x] Original Technet URL [Add a TCP/IP Printer Port and Printer](https://gallery.technet.microsoft.com/94e3de42-13b0-4972-aa5a-87ca6781399e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/94e3de42-13b0-4972-aa5a-87ca6781399e/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Kiran Kumar

Adds a TCP/IP printer port and printer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set objNewPort = objWMIService.Get _
    ("Win32_TCPIPPrinterPort").SpawnInstance_

objNewPort.Name = "IP_10.10.10.113"
objNewPort.Protocol = 1
objNewPort.HostAddress = "10.10.10.113"
objNewPort.PortNumber = "9100"
objNewPort.SNMPEnabled = False
objNewPort.Put_

Set objPrinter = objWMIService.Get("Win32_Printer").SpawnInstance_

objPrinter.DriverName = "HP LaserJet 4000 Series PS"
objPrinter.PortName   = "IP_10.10.10.113"
objPrinter.DeviceID   = "FrontOffice"
objPrinter.Network = True
objPrinter.Put_
```

