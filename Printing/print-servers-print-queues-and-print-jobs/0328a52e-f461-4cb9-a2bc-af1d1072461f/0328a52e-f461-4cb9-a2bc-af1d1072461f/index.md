# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/0328a52e-f461-4cb9-a2bc-af1d1072461f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/0328a52e-f461-4cb9-a2bc-af1d1072461f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

This script was tested using Kixtart 2001 (412) for Microsoft Windows, available from [Kixtart.org](http://www.kixtart.org).

Kixtart

```
$strComputer = "."
$objWMIService = GetObject("winmgmts:\\"+ $strComputer + "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_PrinterConfiguration")
For Each $objItem in $colItems
    ? "Bits Per Pel:" + $objItem.BitsPerPel
    ? "Caption:" + $objItem.Caption
    ? "Collate:" + $objItem.Collate
    ? "Color:" + $objItem.Color
    ? "Copies:" + $objItem.Copies
    ? "Description:" + $objItem.Description
    ? "Device Name:" + $objItem.DeviceName
    ? "Display Flags:" + $objItem.DisplayFlags
    ? "Display Frequency:" + $objItem.DisplayFrequency
    ? "Dither Type:" + $objItem.DitherType
    ? "Driver Version:" + $objItem.DriverVersion
    ? "Duplex:" + $objItem.Duplex
    ? "Form Name:" + $objItem.FormName
    ? "Horizontal Resolution:" + $objItem.HorizontalResolution
    ? "ICM Intent:" + $objItem.ICMIntent
    ? "ICM Method:" + $objItem.ICMMethod
    ? "Log Pixels:" + $objItem.LogPixels
    ? "Media Type:" + $objItem.MediaType
    ? "Name:" + $objItem.Name
    ? "Orientation:" + $objItem.Orientation
    ? "Paper Length:" + $objItem.PaperLength
    ? "Paper Size:" + $objItem.PaperSize
    ? "Paper Width:" + $objItem.PaperWidth
    ? "Pels Height:" + $objItem.PelsHeight
    ? "Pels Width:" + $objItem.PelsWidth
    ? "Print Quality:" + $objItem.PrintQuality
    ? "Scale:" + $objItem.Scale
    ? "Setting ID:" + $objItem.SettingID
    ? "Specification Version:" + $objItem.SpecificationVersion
    ? "TT Option:" + $objItem.TTOption
    ? "Vertical Resolution:" + $objItem.VerticalResolution
    ? "X Resolution:" + $objItem.XResolution
    ? "Y Resolution:" + $objItem.YResolution
Next
```

