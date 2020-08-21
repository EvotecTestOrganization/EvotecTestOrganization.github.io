# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/eb9bcdbf-4f11-484c-b481-a40b332385fe)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/eb9bcdbf-4f11-484c-b481-a40b332385fe/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPorts =  objWMIService.ExecQuery _
    ("Select * from Win32_TCPIPPrinterPort")

For Each objPort in colPorts
    Wscript.Echo "Description: " & objPort.Description
    Wscript.Echo "Host Address: " & objPort.HostAddress
    Wscript.Echo "Name: " & objPort.Name
    Wscript.Echo "Port Number: " & objPort.PortNumber
    Wscript.Echo "Protocol: " & objPort.Protocol
    Wscript.Echo "SNMP Community: " & objPort.SNMPCommunity
    Wscript.Echo "SNMP Dev Index: " & objPort.SnMPDevIndex
    Wscript.Echo "SNMP Enabled: " & objPort.SNMPEnabled
Next
```

