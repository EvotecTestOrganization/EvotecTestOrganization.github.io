# Pre-Stage Printer Drivers

## Original Links

- [x] Original Technet URL [Pre-Stage Printer Drivers](https://gallery.technet.microsoft.com/5d23c2e4-369d-430a-a31c-853c76d68863)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5d23c2e4-369d-430a-a31c-853c76d68863/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs printer (driver only) from inf file so a standard user can connect later. (These days known as pre-staging driver)

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
   & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True
set objDriver = objWMIService.Get("Win32_PrinterDriver")
Set objShell = CreateObject("Wscript.Shell")
objDriver.Name = "Brother HL-5240 series"
objDriver.SupportedPlatform = "Windows NT x86"
objDriver.Version = "3"
objDriver.FilePath = "\\server\\share\\Printer_Drivers\\Brother\\HL 5240\\"
objDriver.Infname = "\\server\\share\\Printer_Drivers\\Brother\\HL 5240\\BROHL05A.INF"
intResult = objDriver.AddPrinterDriver(objDriver)
objShell.Popup objDriver.Name & " driver installed", 3, "Pre-stage Printer Driver By Andrew Barnes", vbInformation + vbOKOnly
```

