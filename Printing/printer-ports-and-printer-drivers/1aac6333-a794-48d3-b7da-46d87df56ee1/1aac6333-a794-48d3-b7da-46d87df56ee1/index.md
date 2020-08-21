# Install a Printer Driver not Found in Drivers Cab

## Original Links

- [x] Original Technet URL [Install a Printer Driver not Found in Drivers Cab](https://gallery.technet.microsoft.com/1aac6333-a794-48d3-b7da-46d87df56ee1)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/1aac6333-a794-48d3-b7da-46d87df56ee1/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs a hypothetical printer using a print driver not found in Drivers.cab.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True

Set objDriver = objWMIService.Get("Win32_PrinterDriver")

objDriver.Name = "NewPrinter Model 2900"
objDriver.SupportedPlatform = "Windows NT x86"
objDriver.Version = "3"
objDriver.DriverPath = "C:\Scripts\NewPrinter.dll"
objDriver.Infname = "C:\Scripts\NewPrinter.inf"
intResult = objDriver.AddPrinterDriver(objDriver)
```

