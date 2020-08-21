# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/ff607ef9-3385-47d4-bb64-0fe9b3a4153c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ff607ef9-3385-47d4-bb64-0fe9b3a4153c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer.

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
    ("SELECT * FROM Win32_PrinterDriver","WQL",wbemFlagReturnImmediately | wbemFlagForwardOnly);

foreach my $objItem (in $colItems)
{
      print "Caption: $objItem->{Caption}\n";
      print "Config File: $objItem->{ConfigFile}\n";
      print "Creation Class Name: $objItem->{CreationClassName}\n";
      print "Data File: $objItem->{DataFile}\n";
      print "Default Data Type: $objItem->{DefaultDataType}\n";
      print "Dependent Files: " . join(",", (in $objItem->{DependentFiles})) . "\n";
      print "Description: $objItem->{Description}\n";
      print "Driver Path: $objItem->{DriverPath}\n";
      print "File Path: $objItem->{FilePath}\n";
      print "Help File: $objItem->{HelpFile}\n";
      print "Inf Name: $objItem->{InfName}\n";
      print "Install Date: $objItem->{InstallDate}\n";
      print "Monitor Name: $objItem->{MonitorName}\n";
      print "Name: $objItem->{Name}\n";
      print "OEM Url: $objItem->{OEMUrl}\n";
      print "Started: $objItem->{Started}\n";
      print "Start Mode: $objItem->{StartMode}\n";
      print "Status: $objItem->{Status}\n";
      print "Supported Platform: $objItem->{SupportedPlatform}\n";
      print "System Creation Class Name: $objItem->{SystemCreationClassName}\n";
      print "System Name: $objItem->{SystemName}\n";
      print "Version: $objItem->{Version}\n";
      print "\n";
}
```

