# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/8dec37aa-c772-4c55-9404-fa05dfad8330)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/8dec37aa-c772-4c55-9404-fa05dfad8330/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer.

JavaScript

```
var wbemFlagReturnImmediately = 0x10;
var wbemFlagForwardOnly = 0x20;

   var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
   var colItems = objWMIService.ExecQuery("SELECT * FROM Win32_TCPIPPrinterPort", "WQL",
                                          wbemFlagReturnImmediately | wbemFlagForwardOnly);

   var enumItems = new Enumerator(colItems);
   for (; !enumItems.atEnd(); enumItems.moveNext()) {
      var objItem = enumItems.item();

      WScript.Echo("Byte Count: " + objItem.ByteCount);
      WScript.Echo("Caption: " + objItem.Caption);
      WScript.Echo("Creation Class Name: " + objItem.CreationClassName);
      WScript.Echo("Description: " + objItem.Description);
      WScript.Echo("Host Address: " + objItem.HostAddress);
      WScript.Echo("Install Date: " + objItem.InstallDate);
      WScript.Echo("Name: " + objItem.Name);
      WScript.Echo("Port Number: " + objItem.PortNumber);
      WScript.Echo("Protocol: " + objItem.Protocol);
      WScript.Echo("Queue: " + objItem.Queue);
      WScript.Echo("SNMP Community: " + objItem.SNMPCommunity);
      WScript.Echo("SNMP Dev Index: " + objItem.SNMPDevIndex);
      WScript.Echo("SNMP Enabled: " + objItem.SNMPEnabled);
      WScript.Echo("Status: " + objItem.Status);
      WScript.Echo("System Creation Class Name: " + objItem.SystemCreationClassName);
      WScript.Echo("System Name: " + objItem.SystemName);
      WScript.Echo("Type: " + objItem.Type);
      WScript.Echo();
   }
```

