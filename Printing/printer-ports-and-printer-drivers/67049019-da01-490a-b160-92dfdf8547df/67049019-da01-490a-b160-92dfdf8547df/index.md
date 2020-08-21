# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/67049019-da01-490a-b160-92dfdf8547df)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/67049019-da01-490a-b160-92dfdf8547df/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

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
    ("SELECT * FROM Win32_TCPIPPrinterPort","WQL",wbemFlagReturnImmediately | wbemFlagForwardOnly);

foreach my $objItem (in $colItems)
{
      print "Byte Count: $objItem->{ByteCount}\n";
      print "Caption: $objItem->{Caption}\n";
      print "Creation Class Name: $objItem->{CreationClassName}\n";
      print "Description: $objItem->{Description}\n";
      print "Host Address: $objItem->{HostAddress}\n";
      print "Install Date: $objItem->{InstallDate}\n";
      print "Name: $objItem->{Name}\n";
      print "Port Number: $objItem->{PortNumber}\n";
      print "Protocol: $objItem->{Protocol}\n";
      print "Queue: $objItem->{Queue}\n";
      print "SNMP Community: $objItem->{SNMPCommunity}\n";
      print "SNMP Dev Index: $objItem->{SNMPDevIndex}\n";
      print "SNMP Enabled: $objItem->{SNMPEnabled}\n";
      print "Status: $objItem->{Status}\n";
      print "System Creation Class Name: $objItem->{SystemCreationClassName}\n";
      print "System Name: $objItem->{SystemName}\n";
      print "Type: $objItem->{Type}\n";
      print "\n";
}
```

