# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/62c1dc9b-3ad8-45a2-8955-83622b7ac3be)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/62c1dc9b-3ad8-45a2-8955-83622b7ac3be/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer.

This script was tested using Object REXX 2.1.0 for Microsoft Windows, available from [IBM](http://www.ibm.com/software/ad/obj-rexx/).

Object REXX

```
strComputer = "."
objWMIService = .OLEObject~GetObject("winmgmts:\\"||strComputer||"\root\CIMV2")
do objItem over objWMIService~ExecQuery("Select * from Win32_PrinterDriver")
    say "Caption:" objItem~Caption
    say "Config File:" objItem~ConfigFile
    say "Creation Class Name:" objItem~CreationClassName
    say "Data File:" objItem~DataFile
    say "Default Data Type:" objItem~DefaultDataType
    z = objItem~DependentFiles
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Description:" objItem~Description
    say "Driver Path:" objItem~DriverPath
    say "File Path:" objItem~FilePath
    say "Help File:" objItem~HelpFile
    say "Inf Name:" objItem~InfName
    say "Install Date:" objItem~InstallDate
    say "Monitor Name:" objItem~MonitorName
    say "Name:" objItem~Name
    say "OEM Url:" objItem~OEMUrl
    say "Started:" objItem~Started
    say "Start Mode:" objItem~StartMode
    say "Status:" objItem~Status
    say "Supported Platform:" objItem~SupportedPlatform
    say "System Creation Class Name:" objItem~SystemCreationClassName
    say "System Name:" objItem~SystemName
    say "Version:" objItem~Version
end
```

