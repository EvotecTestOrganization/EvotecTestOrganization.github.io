# Install a Printer

## Original Links

- [x] Original Technet URL [Install a Printer](https://gallery.technet.microsoft.com/02ee2662-2f8c-4f86-9b77-e0cc6b2d231e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/02ee2662-2f8c-4f86-9b77-e0cc6b2d231e/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs a logical network printer on a print server.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set objPrinter = objWMIService.Get("Win32_Printer").SpawnInstance_

objPrinter.DriverName = "HP LaserJet 4000 Series PS"
objPrinter.PortName   = "IP_169.254.110.160"
objPrinter.DeviceID   = "ScriptedPrinter"
objPrinter.Location = "USA/Redmond/Building 37/Room 114"
objPrinter.Network = True
objPrinter.Shared = True
objPrinter.ShareName = "ScriptedPrinter"
objPrinter.Put_
```

