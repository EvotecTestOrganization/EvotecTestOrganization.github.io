# Remove Printer Connections

## Original Links

- [x] Original Technet URL [Remove Printer Connections](https://gallery.technet.microsoft.com/a349ef0f-6881-4ca3-98de-668935bb7522)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/a349ef0f-6881-4ca3-98de-668935bb7522/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Ulco Landheer

Lists all printers on a given print server (or the entire domain), connects to those print servers, and then removes the printer connection. Handy when you do not allow Terminal Server users to install drivers.

Visual Basic

```
' printer Connection Script
' Change the printserver name to the server you want to connect to 3 times
' And go.....
' Use Cscript.exe to execute or you will get RSI from clicking the OK button....
' 
' Ulco Landheer 20 Januar 2006


Const ADS_SCOPE_SUBTREE = 2

set WshNetwork = CreateObject("Wscript.Network")
Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"

Set objCommand.ActiveConnection = objConnection
objCommand.CommandText = "Select printerName, serverName from " _     
    & " 'LDAP://DC=domain,DC=com'  where objectClass='printQueue' AND serverName='printserver.domain.com'"  
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst

Do Until objRecordSet.EOF
    Wscript.Echo "Printer Name: " & objRecordSet.Fields("printerName").Value
    Wscript.Echo "Server Name: " & objRecordSet.Fields("serverName").ValueWshNetwork.AddWindowsPrinterConnection "\\printserver\" & objRecordSet.Fields("printerName").ValueWscript.sleep 300wshNetwork.RemovePrinterConnection "\\printserver\" & objRecordSet.Fields("printerName").ValueWscript.Echo "Printer " & objRecordSet.Fields("serverName").Value & "\" & objRecordSet.Fields("printerName").Value & " was connected to and deleted"
    objRecordSet.MoveNext
Loop
```

