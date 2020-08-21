# Create a Printer Port and Install a Printer

## Original Links

- [x] Original Technet URL [Create a Printer Port and Install a Printer](https://gallery.technet.microsoft.com/b9a9f45a-eba7-4df5-9cbb-16b301274678)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/b9a9f45a-eba7-4df5-9cbb-16b301274678/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **mbk5us

Creates a TCP/IP printer port and installs a network printer.

Visual Basic

```
'For Windows XP only
'Creates LAN Printer and Print device in one step
'It assumes a LAN printer with IP address 10.72.36.208
'
'Begin defining printer parameters/info
strComputer = "."
PrinterIP   = "10.72.36.208"
DeviceName  = "Lexmark Optra L Plus Series"
PortName    = "IP_" & PrinterIP
ShareName   = "Lexmark Optra L Plus Series - LSQ1"
Location    = "HeadQuarter/Building # 2/Suite 310"
Comment     = "LSQ1 - Tech support only"
'End Parameters

Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objNewPort = objWMIService.Get _
    ("Win32_TCPIPPrinterPort").SpawnInstance_

objNewPort.Name = PortName
objNewPort.Protocol = 1
objNewPort.HostAddress = PrinterIP
objNewPort.PortNumber = "9100"
objNewPort.SNMPEnabled = False
objNewPort.Put_

Set objDriver = objWMIService.Get("Win32_PrinterDriver")
objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True
objDriver.Name = DeviceName
objDriver.SupportedPlatform = "Windows NT x86"
objDriver.Version = "3"
errResult = objDriver.AddPrinterDriver(objDriver)


Set objPrinter = objWMIService.Get("Win32_Printer").SpawnInstance_

objPrinter.DriverName = DeviceName
objPrinter.PortName   = PortName
objPrinter.DeviceID   = DeviceName & " LanPrinter"
objPrinter.Location   = Location
ObjPrinter.Comment    = Comment
objPrinter.Network = False
objPrinter.Shared = False      'does not share the printer
objPrinter.ShareName = ShareName
objPrinter.Put_

Wscript.Echo "Done."
```

