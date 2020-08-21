# List Printer Port Properties

## Original Links

- [x] Original Technet URL [List Printer Port Properties](https://gallery.technet.microsoft.com/32ee7696-0e6c-4d6c-b439-a4ef62d17c0f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/32ee7696-0e6c-4d6c-b439-a4ef62d17c0f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties of all the TCP/IP printer ports installed on a computer. This script requires both Windows PowerShell and the corresponding version of the .NET Framework. For more information on downloading these items see the Windows PowerShell download  page (right).

```
$strComputer = "."

$colItems = get-wmiobject -class "Win32_TCPIPPrinterPort" -namespace "root\CIMV2" `
-computername $strComputer

foreach ($objItem in $colItems) {
      write-host "Byte Count: " $objItem.ByteCount
      write-host "Caption: " $objItem.Caption
      write-host "Creation Class Name: " $objItem.CreationClassName
      write-host "Description: " $objItem.Description
      write-host "Host Address: " $objItem.HostAddress
      write-host "Installation Date: " $objItem.InstallDate
      write-host "Name: " $objItem.Name
      write-host "Port Number: " $objItem.PortNumber
      write-host "Protocol: " $objItem.Protocol
      write-host "Queue: " $objItem.Queue
      write-host "SNMP Community: " $objItem.SNMPCommunity
      write-host "SNMP Device Index: " $objItem.SNMPDevIndex
      write-host "SNMP Enabled: " $objItem.SNMPEnabled
      write-host "Status: " $objItem.Status
      write-host "System Creation Class Name: " $objItem.SystemCreationClassName
      write-host "System Name: " $objItem.SystemName
      write-host "Type: " $objItem.Type
      write-host
}
```

