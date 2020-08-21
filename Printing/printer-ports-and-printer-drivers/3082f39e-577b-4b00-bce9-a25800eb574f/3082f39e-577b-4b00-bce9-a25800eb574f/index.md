# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/3082f39e-577b-4b00-bce9-a25800eb574f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/3082f39e-577b-4b00-bce9-a25800eb574f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

This script was tested using Object REXX 2.1.0 for Microsoft Windows, available from [IBM](http://www.ibm.com/software/ad/obj-rexx/).

Object REXX

```
strComputer = "."
objWMIService = .OLEObject~GetObject("winmgmts:\\"||strComputer||"\root\CIMV2")
do objItem over objWMIService~ExecQuery("Select * from Win32_TCPIPPrinterPort")
    say "Byte Count:" objItem~ByteCount
    say "Caption:" objItem~Caption
    say "Creation Class Name:" objItem~CreationClassName
    say "Description:" objItem~Description
    say "Host Address:" objItem~HostAddress
    say "Install Date:" objItem~InstallDate
    say "Name:" objItem~Name
    say "Port Number:" objItem~PortNumber
    say "Protocol:" objItem~Protocol
    say "Queue:" objItem~Queue
    say "SNMP Community:" objItem~SNMPCommunity
    say "SNMP Dev Index:" objItem~SNMPDevIndex
    say "SNMP Enabled:" objItem~SNMPEnabled
    say "Status:" objItem~Status
    say "System Creation Class Name:" objItem~SystemCreationClassName
    say "System Name:" objItem~SystemName
    say "Type:" objItem~Type
end
```

