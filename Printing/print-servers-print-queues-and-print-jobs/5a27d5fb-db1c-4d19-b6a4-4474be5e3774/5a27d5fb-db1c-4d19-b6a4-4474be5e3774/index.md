# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/5a27d5fb-db1c-4d19-b6a4-4474be5e3774)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5a27d5fb-db1c-4d19-b6a4-4474be5e3774/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists information about all the printers connected to a print server.

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
    ("SELECT * FROM Win32_Printer","WQL",wbemFlagReturnImmediately | wbemFlagForwardOnly);

foreach my $objItem (in $colItems)
{
      print "Attributes: $objItem->{Attributes}\n";
      print "Availability: $objItem->{Availability}\n";
      print "Available JobS heets: " . join(",", (in $objItem->{AvailableJobSheets})) . "\n";
      print "Average Pages Per Minute: $objItem->{AveragePagesPerMinute}\n";
      print "Capabilities: " . join(",", (in $objItem->{Capabilities})) . "\n";
      print "Capability Descriptions: " . join(",", (in $objItem->{CapabilityDescriptions})) . "\n";
      print "Caption: $objItem->{Caption}\n";
      print "Char Sets Supported: " . join(",", (in $objItem->{CharSetsSupported})) . "\n";
      print "Comment: $objItem->{Comment}\n";
      print "Config Manager Error Code: $objItem->{ConfigManagerErrorCode}\n";
      print "Config Manager User Config: $objItem->{ConfigManagerUserConfig}\n";
      print "Creation Class Name: $objItem->{CreationClassName}\n";
      print "Current Capabilities: " . join(",", (in $objItem->{CurrentCapabilities})) . "\n";
      print "Current Char Set: $objItem->{CurrentCharSet}\n";
      print "Current Language: $objItem->{CurrentLanguage}\n";
      print "Current Mime Type: $objItem->{CurrentMimeType}\n";
      print "Current Natural Language: $objItem->{CurrentNaturalLanguage}\n";
      print "Current Paper Type: $objItem->{CurrentPaperType}\n";
      print "Default: $objItem->{Default}\n";
      print "Default Capabilities: " . join(",", (in $objItem->{DefaultCapabilities})) . "\n";
      print "Default Copies: $objItem->{DefaultCopies}\n";
      print "Default Language: $objItem->{DefaultLanguage}\n";
      print "Default Mime Type: $objItem->{DefaultMimeType}\n";
      print "Default Number Up: $objItem->{DefaultNumberUp}\n";
      print "Default Paper Type: $objItem->{DefaultPaperType}\n";
      print "Default Priority: $objItem->{DefaultPriority}\n";
      print "Description: $objItem->{Description}\n";
      print "Detected Error State: $objItem->{DetectedErrorState}\n";
      print "Device ID: $objItem->{DeviceID}\n";
      print "Direct: $objItem->{Direct}\n";
      print "Do Complete First: $objItem->{DoCompleteFirst}\n";
      print "Driver Name: $objItem->{DriverName}\n";
      print "Enable BIDI: $objItem->{EnableBIDI}\n";
      print "Enable Dev Query Print: $objItem->{EnableDevQueryPrint}\n";
      print "Error Cleared: $objItem->{ErrorCleared}\n";
      print "Error Description: $objItem->{ErrorDescription}\n";
      print "Error Information: " . join(",", (in $objItem->{ErrorInformation})) . "\n";
      print "Extended Detected Error State: $objItem->{ExtendedDetectedErrorState}\n";
      print "Extended Printer Status: $objItem->{ExtendedPrinterStatus}\n";
      print "Hidden: $objItem->{Hidden}\n";
      print "Horizontal Resolution: $objItem->{HorizontalResolution}\n";
      print "Install Date: $objItem->{InstallDate}\n";
      print "Job Count Since Last Reset: $objItem->{JobCountSinceLastReset}\n";
      print "Keep Printed Jobs: $objItem->{KeepPrintedJobs}\n";
      print "Languages Supported: " . join(",", (in $objItem->{LanguagesSupported})) . "\n";
      print "Last Error Code: $objItem->{LastErrorCode}\n";
      print "Local: $objItem->{Local}\n";
      print "Location: $objItem->{Location}\n";
      print "Marking Technology: $objItem->{MarkingTechnology}\n";
      print "Max Copies: $objItem->{MaxCopies}\n";
      print "Max Number Up: $objItem->{MaxNumberUp}\n";
      print "Max Size Supported: $objItem->{MaxSizeSupported}\n";
      print "Mime Types Supported: " . join(",", (in $objItem->{MimeTypesSupported})) . "\n";
      print "Name: $objItem->{Name}\n";
      print "Natural Languages Supported: " . join(",", (in $objItem->{NaturalLanguagesSupported})) . "\n";
      print "Network: $objItem->{Network}\n";
      print "Paper Sizes Supported: " . join(",", (in $objItem->{PaperSizesSupported})) . "\n";
      print "Paper Types Available: " . join(",", (in $objItem->{PaperTypesAvailable})) . "\n";
      print "Parameters: $objItem->{Parameters}\n";
      print "PNP Device ID: $objItem->{PNPDeviceID}\n";
      print "Port Name: $objItem->{PortName}\n";
      print "Power Management Capabilities: " . join(",", (in $objItem->{PowerManagementCapabilities})) . "\n";
      print "Power Management Supported: $objItem->{PowerManagementSupported}\n";
      print "Printer Paper Names: " . join(",", (in $objItem->{PrinterPaperNames})) . "\n";
      print "Printer State: $objItem->{PrinterState}\n";
      print "Printer Status: $objItem->{PrinterStatus}\n";
      print "Print Job Data Type: $objItem->{PrintJobDataType}\n";
      print "Print Processor: $objItem->{PrintProcessor}\n";
      print "Priority: $objItem->{Priority}\n";
      print "Published: $objItem->{Published}\n";
      print "Queued: $objItem->{Queued}\n";
      print "Raw Only: $objItem->{RawOnly}\n";
      print "Separator File: $objItem->{SeparatorFile}\n";
      print "Server Name: $objItem->{ServerName}\n";
      print "Shared: $objItem->{Shared}\n";
      print "Share Name: $objItem->{ShareName}\n";
      print "Spool Enabled: $objItem->{SpoolEnabled}\n";
      print "Start Time: $objItem->{StartTime}\n";
      print "Status: $objItem->{Status}\n";
      print "Status Info: $objItem->{StatusInfo}\n";
      print "System Creation Class Name: $objItem->{SystemCreationClassName}\n";
      print "System Name: $objItem->{SystemName}\n";
      print "Time Of Last Reset: $objItem->{TimeOfLastReset}\n";
      print "Until Time: $objItem->{UntilTime}\n";
      print "Vertical Resolution: $objItem->{VerticalResolution}\n";
      print "Work Offline: $objItem->{WorkOffline}\n";
      print "\n";
}
```

