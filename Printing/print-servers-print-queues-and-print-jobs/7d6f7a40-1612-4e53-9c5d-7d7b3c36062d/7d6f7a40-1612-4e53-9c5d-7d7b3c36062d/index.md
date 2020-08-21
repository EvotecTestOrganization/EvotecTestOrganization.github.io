# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/7d6f7a40-1612-4e53-9c5d-7d7b3c36062d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/7d6f7a40-1612-4e53-9c5d-7d7b3c36062d/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

This script was tested using Python 2.2.2-224 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Python

```
import win32com.client
strComputer = "."
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_PrinterConfiguration")
for objItem in colItems:
    print "Bits Per Pel: ", objItem.BitsPerPel
    print "Caption: ", objItem.Caption
    print "Collate: ", objItem.Collate
    print "Color: ", objItem.Color
    print "Copies: ", objItem.Copies
    print "Description: ", objItem.Description
    print "Device Name: ", objItem.DeviceName
    print "Display Flags: ", objItem.DisplayFlags
    print "Display Frequency: ", objItem.DisplayFrequency
    print "Dither Type: ", objItem.DitherType
    print "Driver Version: ", objItem.DriverVersion
    print "Duplex: ", objItem.Duplex
    print "Form Name: ", objItem.FormName
    print "Horizontal Resolution: ", objItem.HorizontalResolution
    print "ICM Intent: ", objItem.ICMIntent
    print "ICM Method: ", objItem.ICMMethod
    print "Log Pixels: ", objItem.LogPixels
    print "Media Type: ", objItem.MediaType
    print "Name: ", objItem.Name
    print "Orientation: ", objItem.Orientation
    print "Paper Length: ", objItem.PaperLength
    print "Paper Size: ", objItem.PaperSize
    print "Paper Width: ", objItem.PaperWidth
    print "Pels Height: ", objItem.PelsHeight
    print "Pels Width: ", objItem.PelsWidth
    print "Print Quality: ", objItem.PrintQuality
    print "Scale: ", objItem.Scale
    print "Setting ID: ", objItem.SettingID
    print "Specification Version: ", objItem.SpecificationVersion
    print "TT Option: ", objItem.TTOption
    print "Vertical Resolution: ", objItem.VerticalResolution
    print "X Resolution: ", objItem.XResolution
    print "Y Resolution: ", objItem.YResolution
```

