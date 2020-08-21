# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/3d913b42-dfa1-4e25-9f24-a5efe5a9778b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/3d913b42-dfa1-4e25-9f24-a5efe5a9778b/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer.

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
    ("SELECT * FROM Win32_PrintJob","WQL",wbemFlagReturnImmediately | wbemFlagForwardOnly);

foreach my $objItem (in $colItems)
{
      print "Caption: $objItem->{Caption}\n";
      print "Data Type: $objItem->{DataType}\n";
      print "Description: $objItem->{Description}\n";
      print "Document: $objItem->{Document}\n";
      print "Driver Name: $objItem->{DriverName}\n";
      print "Elapsed Time: $objItem->{ElapsedTime}\n";
      print "Host Print Queue: $objItem->{HostPrintQueue}\n";
      print "Install Date: $objItem->{InstallDate}\n";
      print "Job Id: $objItem->{JobId}\n";
      print "Job Status: $objItem->{JobStatus}\n";
      print "Name: $objItem->{Name}\n";
      print "Notify: $objItem->{Notify}\n";
      print "Owner: $objItem->{Owner}\n";
      print "Pages Printed: $objItem->{PagesPrinted}\n";
      print "Parameters: $objItem->{Parameters}\n";
      print "Print Processor: $objItem->{PrintProcessor}\n";
      print "Priority: $objItem->{Priority}\n";
      print "Size: $objItem->{Size}\n";
      print "Start Time: $objItem->{StartTime}\n";
      print "Status: $objItem->{Status}\n";
      print "Status Mask: $objItem->{StatusMask}\n";
      print "Time Submitted: $objItem->{TimeSubmitted}\n";
      print "Total Pages: $objItem->{TotalPages}\n";
      print "Until Time: $objItem->{UntilTime}\n";
      print "\n";
}
```

