# Search Active Directory for Specific Printers

## Original Links

- [x] Original Technet URL [Search Active Directory for Specific Printers](https://gallery.technet.microsoft.com/2fbd192e-41ab-4e76-ab9c-ee9b6ddb419d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/2fbd192e-41ab-4e76-ab9c-ee9b6ddb419d/description)
- [x] Download: Not available.

## Output from Technet Gallery

Searches Active Directory for all printers with a priority of 2.

Visual Basic

```
Const ADS_SCOPE_SUBTREE = 2

Set objConnection = CreateObject("ADODB.Connection")
Set objCommand =   CreateObject("ADODB.Command")

objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCOmmand.ActiveConnection = objConnection
objCommand.CommandText = "Select printerName, serverName from " _
    & "'LDAP://DC=fabrikam,DC=com'  where objectClass='printQueue' and " _
        & " Priority = 2 "  
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

