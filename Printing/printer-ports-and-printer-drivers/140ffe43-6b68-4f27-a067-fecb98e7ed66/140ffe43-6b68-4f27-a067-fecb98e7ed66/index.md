# Map Printers Based on Computer OU

## Original Links

- [x] Original Technet URL [Map Printers Based on Computer OU](https://gallery.technet.microsoft.com/140ffe43-6b68-4f27-a067-fecb98e7ed66)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/140ffe43-6b68-4f27-a067-fecb98e7ed66/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Brad Pursell

Maps printers according to the OU of the computer the user has logged on to. The script also logs the user name, computer name, IP address, logon time, and computer OU into an Access database.

Visual Basic

```
'This log on script will map printers according to the OU of the computer being logged into.
'This was developed due to students moving from classroom to classroom needing different printers for each room
'The script will also log username, computer name, IP address, logon time, and computer ou into an Access
'database for tracking student access
'written by Brad Pursell, pursellb@butlertech.org

On Error Resume Next

'=====VARIABLES=====

Set objNetwork = WSCript.CreateObject("WScript.Network")
strPooterName = objNetwork.ComputerName
strUserName = objNetwork.UserName

Set objWMIService = GetObject("winmgmts:\\" &  strPooterName & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = True")
For Each objItem in colItems
    strIPAddress = Join(objItem.IPAddress)
Next

strTimeStamp = Now

Const adOpenStatic = 3
Const adLockOptimistic = 3

'=====CONNECT TO AD=====

Set objADConnection = CreateObject("ADODB.Connection")
objADConnection.Open "Provider=ADsDSOObject;"

Set objADCommand = CreateObject("ADODB.Command")
objADCommand.ActiveConnection = objADConnection

objADCommand.CommandText = "SELECT distinguishedName FROM 'LDAP://dc=DOMAINNAMEHERE,dc=TLDOMAINHERE(E.G.,.ORG)' WHERE Name='" & strPooterName & "'"

Set objADRecordSet = objADCommand.Execute

'=====PARSE DN FOR OU=====

Do While Not objADRecordSet.EOFstrDN = objADRecordSet.Fields("distinguishedName")intCommaPosition=InStr(strDN, ",")strOU = Mid(strDN, intCommaPosition + 1, Len(strDN) - intCommaPosition)intCommaPosition = InStr(strOU, ",")strOU = Mid(strOU, 1, intCommaPosition - 1)intCommaPosition = InStr(strOU, "=")strOU = Mid(strOU, intCommaPosition + 1, Len(strOU) - intCommaPosition)objADRecordSet.MoveNext'WScript.Echo strOU
Loop

objADConnection.Close

'=====MAP DRIVES/PRINTERS BY OU=====

Select Case strOUCase "Technology Systems"	objNetwork.RemoveNetworkDrive "g:"	objNetwork.MapNetworkDrive "g:", "\\btfs1\fs5"	objNetwork.RemoveNetworkDrive "i:"	objNetwork.MapNetworkDrive "i:", "\\btfs1\fs1"	objNetwork.RemoveNetworkDrive "j:"	objNetwork.MapNetworkDrive "j:", "\\btfs1\fs2"	objNetwork.RemoveNetworkDrive "l:"	objNetwork.MapNetworkDrive "l:", "\\btfs1\paul1"	objNetwork.RemoveNetworkDrive "t:"	objNetwork.MapNetworkDrive "t:", "\\btfs1\vol1"	objNetwork.AddWindowsPrinterConnection "\\BTDC1\HPLJ4050_TechOffice"	objNetwork.AddWindowsPrinterConnection "\\BTDC1\HPLJ8100_TechRoom"	objNetwork.AddWindowsPrinterConnection "\\BTDC1\CanoniRC3200Color_LowerLevelERC"	objNetwork.AddWindowsPrinterConnection "\\BTDC1\CanoniR6000B&W_LowerLevelERC"	'objNetwork.SetDefaultPrinter "\\\"Case "INSERT ANOTHER OU HERE"	'CREATE A SEPARATE CASE STATEMENT FOR EACH OUcase Else	'not found
End Select

'=====LOGGING=====

Set objDBConnection = CreateObject("ADODB.Connection")
Set objDBRecordSet = CreateObject("ADODB.Recordset")

objDBConnection.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source='\\***INSERT PATH TO ACCESS DB***\ACCESSDB.mdb'" 
objDBRecordSet.Open "INSERT INTO Logons (Username, ComputerName, IPAddress, LogonTime, ComputerOU, ComputerDN) VALUES ('" & strUserName & "', '" & strPooterName & "', '" & strIPAddress & "', '" & strTimeStamp & "', '" & strOU & "', '" & strDN & "')", objDBConnection, adOpenStatic, adLockOptimistic

objDBConnection.Close
```

