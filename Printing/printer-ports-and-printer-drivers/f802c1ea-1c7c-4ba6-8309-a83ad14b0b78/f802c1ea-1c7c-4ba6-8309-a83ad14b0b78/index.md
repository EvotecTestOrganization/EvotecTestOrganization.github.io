# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/f802c1ea-1c7c-4ba6-8309-a83ad14b0b78)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/f802c1ea-1c7c-4ba6-8309-a83ad14b0b78/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

This script was tested using Kixtart 2001 (412) for Microsoft Windows, available from [Kixtart.org](http://www.kixtart.org).

Kixtart

```
$strComputer = "."
$objWMIService = GetObject("winmgmts:\\"+ $strComputer + "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_TCPIPPrinterPort")
For Each $objItem in $colItems
    ? "Byte Count:" + $objItem.ByteCount
    ? "Caption:" + $objItem.Caption
    ? "Creation Class Name:" + $objItem.CreationClassName
    ? "Description:" + $objItem.Description
    ? "Host Address:" + $objItem.HostAddress
    ? "Install Date:" + $objItem.InstallDate
    ? "Name:" + $objItem.Name
    ? "Port Number:" + $objItem.PortNumber
    ? "Protocol:" + $objItem.Protocol
    ? "Queue:" + $objItem.Queue
    ? "SNMP Community:" + $objItem.SNMPCommunity
    ? "SNMP Dev Index:" + $objItem.SNMPDevIndex
    ? "SNMP Enabled:" + $objItem.SNMPEnabled
    ? "Status:" + $objItem.Status
    ? "System Creation Class Name:" + $objItem.SystemCreationClassName
    ? "System Name:" + $objItem.SystemName
    ? "Type:" + $objItem.Type
Next
```

