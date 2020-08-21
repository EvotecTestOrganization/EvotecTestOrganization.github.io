# Manage Printers and Printer Drivers

## Original Links

- [x] Original Technet URL [Manage Printers and Printer Drivers](https://gallery.technet.microsoft.com/710bb2ad-9a8d-42cb-b142-cda2c1452548)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/710bb2ad-9a8d-42cb-b142-cda2c1452548/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Aldo Cabrera

Manages printer drivers and printer ports.

Visual Basic

```
'This Script will add a Printer Drivers for a printer that is not in the Cab folder, 
'Add or Adjust a port Ip Address or name, 
'or Add or Adjust a printer and printer driver
'You can choose what you want to do by adjusting the triggers at the top of the script.
'
'This script was a compliation of other scripts on the script repository with the added switches
'
'Love Aldo C., 20060329
 
updateDriverCab = 0   'Set to 1 to install driver to driver.cab or 0 to do nothing!
updatePort = 1   'Set to 1 to install or update a port or 0 to do nothing!
updateDriver = 0  'Set to 1 to install or update a printer or 0 to do nothing!
 

'SETS 'LOAD DRIVER' PRIVILEGE.
 
strComputer = "."
 
 Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
 
    objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True
 
'INSTALLS DRIVER NOT LOCATED IN Driver.cab
 If updateDriverCab = 1 then
  Set objDriver = objWMIService.Get("Win32_PrinterDriver")
  objDriver.Name = "NewPrinter Model 2900"
  objDriver.SupportedPlatform = "Windows NT x86"
  objDriver.Version = "3"
  objDriver.DriverPath = "C:\Scripts\NewPrinter.dll"
  objDriver.Infname = "C:\Scripts\NewPrinter.inf"
  intResult = objDriver.AddPrinterDriver(objDriver)
  
  WScript.Echo "Added Driver " & objDriver.Name
  
 End if
 
 
 
'SETS PRINTER PORT.
 
 If updatePort = 1 then
     Set objNewPort = objWMIService.Get _
         ("Win32_TCPIPPrinterPort").SpawnInstance_
  objNewPort.Name = "It_Installed"
     objNewPort.Protocol = 1
     objNewPort.HostAddress = "192.168.100.89"
     objNewPort.PortNumber = "9100"
     objNewPort.SNMPEnabled = False
     objNewPort.Put_
     
     WScript.Echo "Changed Port " & objNewPort.Name
     
 End if
 

'SETS PRINTER TO PORT.
 
 If updateDriver = 1 then
     Set objPrinter = objWMIService.Get _
         ("Win32_Printer").SpawnInstance_
     objPrinter.DriverName = "Canon iR C5180-H1 PS Ver1.0"
     objPrinter.PortName   = "It_Installed"
     objPrinter.DeviceID   = "IT_Installed_Printer"
     objPrinter.Location = ""
     objPrinter.Network = True
     objPrinter.Shared = False
     objPrinter.Put_
     
     WScript.Echo "Printer " & objPrinter.DeviceID & "Added or Changed"
     
 End if
```

