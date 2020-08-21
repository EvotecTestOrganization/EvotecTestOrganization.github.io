# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/f12eb87b-413e-4d11-8c5a-17f73ae2ae89)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/f12eb87b-413e-4d11-8c5a-17f73ae2ae89/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

JavaScript

```
var wbemFlagReturnImmediately = 0x10;
var wbemFlagForwardOnly = 0x20;

   var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
   var colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PrinterConfiguration", "WQL",
                                          wbemFlagReturnImmediately | wbemFlagForwardOnly);

   var enumItems = new Enumerator(colItems);
   for (; !enumItems.atEnd(); enumItems.moveNext()) {
      var objItem = enumItems.item();

      WScript.Echo("Bits Per Pel: " + objItem.BitsPerPel);
      WScript.Echo("Caption: " + objItem.Caption);
      WScript.Echo("Collate: " + objItem.Collate);
      WScript.Echo("Color: " + objItem.Color);
      WScript.Echo("Copies: " + objItem.Copies);
      WScript.Echo("Description: " + objItem.Description);
      WScript.Echo("Device Name: " + objItem.DeviceName);
      WScript.Echo("Display Flags: " + objItem.DisplayFlags);
      WScript.Echo("Display Frequency: " + objItem.DisplayFrequency);
      WScript.Echo("Dither Type: " + objItem.DitherType);
      WScript.Echo("Driver Version: " + objItem.DriverVersion);
      WScript.Echo("Duplex: " + objItem.Duplex);
      WScript.Echo("Form Name: " + objItem.FormName);
      WScript.Echo("Horizontal Resolution: " + objItem.HorizontalResolution);
      WScript.Echo("ICM Intent: " + objItem.ICMIntent);
      WScript.Echo("ICM Method: " + objItem.ICMMethod);
      WScript.Echo("Log Pixels: " + objItem.LogPixels);
      WScript.Echo("Media Type: " + objItem.MediaType);
      WScript.Echo("Name: " + objItem.Name);
      WScript.Echo("Orientation: " + objItem.Orientation);
      WScript.Echo("Paper Length: " + objItem.PaperLength);
      WScript.Echo("Paper Size: " + objItem.PaperSize);
      WScript.Echo("Paper Width: " + objItem.PaperWidth);
      WScript.Echo("Pels Height: " + objItem.PelsHeight);
      WScript.Echo("Pels Width: " + objItem.PelsWidth);
      WScript.Echo("Print Quality: " + objItem.PrintQuality);
      WScript.Echo("Scale: " + objItem.Scale);
      WScript.Echo("Setting ID: " + objItem.SettingID);
      WScript.Echo("Specification Version: " + objItem.SpecificationVersion);
      WScript.Echo("TT Option: " + objItem.TTOption);
      WScript.Echo("Vertical Resolution: " + objItem.VerticalResolution);
      WScript.Echo("X Resolution: " + objItem.XResolution);
      WScript.Echo("Y Resolution: " + objItem.YResolution);
      WScript.Echo();
   }
```

