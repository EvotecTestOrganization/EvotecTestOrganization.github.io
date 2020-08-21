# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/7761fbca-8d74-4b5e-8cd5-4ca9c83d1408)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/7761fbca-8d74-4b5e-8cd5-4ca9c83d1408/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

This script was tested using Perl 5.8.0.804 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Perl

```
use Win32::OLE('in');
use constant wbemFlagReturnImmediately => 0x10;
use constant wbemFlagForwardOnly => 0x20;

$computer = ".";
$objWMIService = Win32::OLE->GetObject
    ("winmgmts:\\\\$computer\\root\\CIMV2") or die "WMI connection failed.\n";
$colItems = $objWMIService->ExecQuery
    ("SELECT * FROM Win32_PrinterConfiguration","WQL",wbemFlagReturnImmediately | wbemFlagForwardOnly);

foreach my $objItem (in $colItems)
{
      print "Bits Per Pel: $objItem->{BitsPerPel}\n";
      print "Caption: $objItem->{Caption}\n";
      print "Collate: $objItem->{Collate}\n";
      print "Color: $objItem->{Color}\n";
      print "Copies: $objItem->{Copies}\n";
      print "Description: $objItem->{Description}\n";
      print "Device Name: $objItem->{DeviceName}\n";
      print "Display Flags: $objItem->{DisplayFlags}\n";
      print "Display Frequency: $objItem->{DisplayFrequency}\n";
      print "Dither Type: $objItem->{DitherType}\n";
      print "Driver Version: $objItem->{DriverVersion}\n";
      print "Duplex: $objItem->{Duplex}\n";
      print "Form Name: $objItem->{FormName}\n";
      print "Horizontal Resolution: $objItem->{HorizontalResolution}\n";
      print "ICM Intent: $objItem->{ICMIntent}\n";
      print "ICM Method: $objItem->{ICMMethod}\n";
      print "Log Pixels: $objItem->{LogPixels}\n";
      print "Media Type: $objItem->{MediaType}\n";
      print "Name: $objItem->{Name}\n";
      print "Orientation: $objItem->{Orientation}\n";
      print "Paper Length: $objItem->{PaperLength}\n";
      print "Paper Size: $objItem->{PaperSize}\n";
      print "Paper Width: $objItem->{PaperWidth}\n";
      print "Pels Height: $objItem->{PelsHeight}\n";
      print "Pels Width: $objItem->{PelsWidth}\n";
      print "Print Quality: $objItem->{PrintQuality}\n";
      print "Scale: $objItem->{Scale}\n";
      print "Setting ID: $objItem->{SettingID}\n";
      print "Specification Version: $objItem->{SpecificationVersion}\n";
      print "TT Option: $objItem->{TTOption}\n";
      print "Vertical Resolution: $objItem->{VerticalResolution}\n";
      print "X Resolution: $objItem->{XResolution}\n";
      print "Y Resolution: $objItem->{YResolution}\n";
      print "\n";
}
```

