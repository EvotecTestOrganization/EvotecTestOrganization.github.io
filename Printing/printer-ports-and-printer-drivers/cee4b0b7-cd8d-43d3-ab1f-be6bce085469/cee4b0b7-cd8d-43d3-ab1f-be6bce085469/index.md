# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/cee4b0b7-cd8d-43d3-ab1f-be6bce085469)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/cee4b0b7-cd8d-43d3-ab1f-be6bce085469/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

This script was tested using Python 2.2.2-224 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Python

```
import win32com.client
strComputer = "."
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_TCPIPPrinterPort")
for objItem in colItems:
    print "Byte Count: ", objItem.ByteCount
    print "Caption: ", objItem.Caption
    print "Creation Class Name: ", objItem.CreationClassName
    print "Description: ", objItem.Description
    print "Host Address: ", objItem.HostAddress
    print "Install Date: ", objItem.InstallDate
    print "Name: ", objItem.Name
    print "Port Number: ", objItem.PortNumber
    print "Protocol: ", objItem.Protocol
    print "Queue: ", objItem.Queue
    print "SNMP Community: ", objItem.SNMPCommunity
    print "SNMP Dev Index: ", objItem.SNMPDevIndex
    print "SNMP Enabled: ", objItem.SNMPEnabled
    print "Status: ", objItem.Status
    print "System Creation Class Name: ", objItem.SystemCreationClassName
    print "System Name: ", objItem.SystemName
    print "Type: ", objItem.Type
```

