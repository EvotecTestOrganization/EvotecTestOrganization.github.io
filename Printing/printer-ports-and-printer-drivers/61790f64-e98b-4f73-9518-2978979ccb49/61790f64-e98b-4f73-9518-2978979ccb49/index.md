# Install Printer Drivers

## Original Links

- [x] Original Technet URL [Install Printer Drivers](https://gallery.technet.microsoft.com/61790f64-e98b-4f73-9518-2978979ccb49)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/61790f64-e98b-4f73-9518-2978979ccb49/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs the printer driver for an Apple LaserWriter 8500 printer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set objDriver = objWMIService.Get("Win32_PrinterDriver")
objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True

objDriver.Name = "Apple LaserWriter 8500"
objDriver.SupportedPlatform = "Windows NT x86"
objDriver.Version = "3"
errResult = objDriver.AddPrinterDriver(objDriver)
```

