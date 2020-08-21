# List All Published Printers

## Original Links

- [x] Original Technet URL [List All Published Printers](https://gallery.technet.microsoft.com/80a75a64-980f-414d-b084-01c83f6ce261)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/80a75a64-980f-414d-b084-01c83f6ce261/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns a list of all the printers published in Active Directory.

Visual Basic

```
Const ADS_SCOPE_SUBTREE = 2

Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"

Set objCommand.ActiveConnection = objConnection
objCommand.CommandText = "Select printerName, serverName from " _     
    & " 'LDAP://DC=fabrikam,DC=com'  where objectClass='printQueue'"  
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 
Set objRecordSet = objCommand.Execute
objRecordSet.MoveFirst

Do Until objRecordSet.EOF
    Wscript.Echo "Printer Name: " & objRecordSet.Fields("printerName").Value
    Wscript.Echo "Server Name: " & objRecordSet.Fields("serverName").Value
    objRecordSet.MoveNext
Loop
```

