# Connect to Printers in a Specific Location

## Original Links

- [x] Original Technet URL [Connect to Printers in a Specific Location](https://gallery.technet.microsoft.com/cd07d126-d326-4161-8a4d-29a59b890ab9)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/cd07d126-d326-4161-8a4d-29a59b890ab9/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Mark Fellensiek

Determines the computer's location in Active Directory and then connects to all the printers found in that location.

Visual Basic

```
'*********************************************************
' Purpose: Looks up the computer's account location in the 
' Active Directory, then finds all the printers
' at that location and connects them to the PC.
'
' Usage: Set the value below to the name of your domain
' eg: yourdomain.local
' 
'*********************************************************

Const TheDomainName = "'LDAP://DC=yourdomain,DC=local'"

'*********************************************************
' no need to change anything below this line
'*********************************************************

'*********************************************************
' Lookup the recorded location for this computer
'*********************************************************

Const ADS_SCOPE_SUBTREE = 2
Set WshNetwork = CreateObject("WScript.Network")
Set objSysInfo = CreateObject("ADSystemInfo")
Set objComputer = GetObject ("LDAP://" & objSysInfo.ComputerName)
ThisComputerLocation = objComputer.Location

'*********************************************************
' disconnect all network printers from the PC (optional)
'*********************************************************

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objNetwork = WScript.CreateObject("WScript.Network")
Set colPrinters = objNetwork.EnumPrinterConnections
For i = 0 to colPrinters.Count -1 Step 2
if lcase(left(colPrinters.Item (i+1),2)) = "\\" then
objNetwork.RemovePrinterConnection colPrinters.Item (i + 1), true, true
end if
Next

'*********************************************************
' Query the Directory for all printers at this location
'*********************************************************

Set objConnection = CreateObject("ADODB.Connection")
Set objCommand = CreateObject("ADODB.Command")
objConnection.Provider = "ADsDSOObject"
objConnection.Open "Active Directory Provider"
Set objCommand.ActiveConnection = objConnection

objCommand.CommandText = "Select uncName from " _ 
& TheDomainName & " where objectClass='printQueue' and Location='" & ThisComputerLocation &"'" 
objCommand.Properties("Page Size") = 1000
objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 
Set objRecordSet = objCommand.Execute
'objRecordSet.MoveFirst

'*********************************************************
' Connect them. 
' and set one of them as the default (optional)
'*********************************************************

While Not objRecordSet.EOF
objNetwork.AddWindowsPrinterConnection objRecordSet.Fields("uncName").Value
'objNetwork.SetDefaultPrinter objRecordSet.Fields("uncName").Value
objRecordSet.MoveNext
Wend
```

