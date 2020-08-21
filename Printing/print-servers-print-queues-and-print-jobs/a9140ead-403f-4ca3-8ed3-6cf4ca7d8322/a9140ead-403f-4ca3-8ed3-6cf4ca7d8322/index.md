# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/a9140ead-403f-4ca3-8ed3-6cf4ca7d8322)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/a9140ead-403f-4ca3-8ed3-6cf4ca7d8322/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer. This script requires both Windows PowerShell and the corresponding version of the .NET Framework. For more information on downloading these items see the Windows PowerShell download  page (right).

```
$strComputer = "."

$colItems = get-wmiobject -class "Win32_PrinterConfiguration" -namespace "root\CIMV2" `
-computername $strComputer

foreach ($objItem in $colItems) {
      write-host "Bits Per Pel: " $objItem.BitsPerPel
      write-host "Caption: " $objItem.Caption
      write-host "Collate: " $objItem.Collate
      write-host "Color: " $objItem.Color
      write-host "Copies: " $objItem.Copies
      write-host "Description: " $objItem.Description
      write-host "Device Name: " $objItem.DeviceName
      write-host "Display Flags: " $objItem.DisplayFlags
      write-host "Display Frequency: " $objItem.DisplayFrequency
      write-host "Dither Type: " $objItem.DitherType
      write-host "Driver Version: " $objItem.DriverVersion
      write-host "Duplex: " $objItem.Duplex
      write-host "Form Name: " $objItem.FormName
      write-host "Horizontal Resolution: " $objItem.HorizontalResolution
      write-host "ICM Intent: " $objItem.ICMIntent
      write-host "ICM Method: " $objItem.ICMMethod
      write-host "Log Pixels: " $objItem.LogPixels
      write-host "Media Type: " $objItem.MediaType
      write-host "Name: " $objItem.Name
      write-host "Orientation: " $objItem.Orientation
      write-host "Paper Length: " $objItem.PaperLength
      write-host "Paper Size: " $objItem.PaperSize
      write-host "Paper Width: " $objItem.PaperWidth
      write-host "Pels Height: " $objItem.PelsHeight
      write-host "Pels Width: " $objItem.PelsWidth
      write-host "Print Quality: " $objItem.PrintQuality
      write-host "Scale: " $objItem.Scale
      write-host "Setting ID: " $objItem.SettingID
      write-host "Specification Version: " $objItem.SpecificationVersion
      write-host "TT Option: " $objItem.TTOption
      write-host "Vertical Resolution: " $objItem.VerticalResolution
      write-host "X Resolution: " $objItem.XResolution
      write-host "Y Resolution: " $objItem.YResolution
      write-host
}
```

