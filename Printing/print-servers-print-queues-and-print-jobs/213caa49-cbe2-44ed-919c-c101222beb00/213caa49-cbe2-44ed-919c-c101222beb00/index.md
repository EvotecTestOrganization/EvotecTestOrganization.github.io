# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/213caa49-cbe2-44ed-919c-c101222beb00)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/213caa49-cbe2-44ed-919c-c101222beb00/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

This script was tested using Object REXX 2.1.0 for Microsoft Windows, available from [IBM](http://www.ibm.com/software/ad/obj-rexx/).

Object REXX

```
strComputer = "."
objWMIService = .OLEObject~GetObject("winmgmts:\\"||strComputer||"\root\CIMV2")
do objItem over objWMIService~ExecQuery("Select * from Win32_PrinterConfiguration")
    say "Bits Per Pel:" objItem~BitsPerPel
    say "Caption:" objItem~Caption
    say "Collate:" objItem~Collate
    say "Color:" objItem~Color
    say "Copies:" objItem~Copies
    say "Description:" objItem~Description
    say "Device Name:" objItem~DeviceName
    say "Display Flags:" objItem~DisplayFlags
    say "Display Frequency:" objItem~DisplayFrequency
    say "Dither Type:" objItem~DitherType
    say "Driver Version:" objItem~DriverVersion
    say "Duplex:" objItem~Duplex
    say "Form Name:" objItem~FormName
    say "Horizontal Resolution:" objItem~HorizontalResolution
    say "ICM Intent:" objItem~ICMIntent
    say "ICM Method:" objItem~ICMMethod
    say "Log Pixels:" objItem~LogPixels
    say "Media Type:" objItem~MediaType
    say "Name:" objItem~Name
    say "Orientation:" objItem~Orientation
    say "Paper Length:" objItem~PaperLength
    say "Paper Size:" objItem~PaperSize
    say "Paper Width:" objItem~PaperWidth
    say "Pels Height:" objItem~PelsHeight
    say "Pels Width:" objItem~PelsWidth
    say "Print Quality:" objItem~PrintQuality
    say "Scale:" objItem~Scale
    say "Setting ID:" objItem~SettingID
    say "Specification Version:" objItem~SpecificationVersion
    say "TT Option:" objItem~TTOption
    say "Vertical Resolution:" objItem~VerticalResolution
    say "X Resolution:" objItem~XResolution
    say "Y Resolution:" objItem~YResolution
end
```

