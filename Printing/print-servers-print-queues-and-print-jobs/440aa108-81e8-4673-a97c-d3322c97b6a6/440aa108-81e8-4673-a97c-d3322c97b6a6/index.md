# Install Multiple Printers for One Print Devi

## Original Links

- [x] Original Technet URL [Install Multiple Printers for One Print Devi](https://gallery.technet.microsoft.com/440aa108-81e8-4673-a97c-d3322c97b6a6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/440aa108-81e8-4673-a97c-d3322c97b6a6/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs two logical network printers (with different printer priorities) for the same physical print device.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set objPrinter = objWMIService.Get("Win32_Printer").SpawnInstance_

objPrinter.DriverName = "HP LaserJet 4000 Series PS"
objPrinter.PortName   = "IP_169.254.110.160"
objPrinter.DeviceID   = "PublicPrinter"
objPrinter.Location = "USA/Redmond/Building 37/Room 114"
objPrinter.Network = True
objPrinter.Shared = True
objPrinter.ShareName = "PublicPrinter"
objPrinter.Put_
 
objPrinter.DriverName = "HP LaserJet 4000 Series PS"
objPrinter.PortName   = "IP_169.254.110.160"
objPrinter.DeviceID   = "PrivatePrinter"
objPrinter.Location = "USA/Redmond/Building 37/Room 114"
objPrinter.Priority = 2
objPrinter.Network = True
objPrinter.Shared = True
objPrinter.Hidden = True
objPrinter.ShareName = "PrivatePrinter"
objPrinter.Put_
```

