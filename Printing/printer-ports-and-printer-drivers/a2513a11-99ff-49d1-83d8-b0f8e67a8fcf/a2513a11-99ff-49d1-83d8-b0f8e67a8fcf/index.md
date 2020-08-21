# Assign Print Servers at Logon

## Original Links

- [x] Original Technet URL [Assign Print Servers at Logon](https://gallery.technet.microsoft.com/a2513a11-99ff-49d1-83d8-b0f8e67a8fcf)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/a2513a11-99ff-49d1-83d8-b0f8e67a8fcf/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Emad Aziz

Logon script that connects users to assigned\available print servers. Each location has an allocated print server and the script provides resilience in case one the remote\central servers is off line. The administrator does need to know the actual name of  the server, just the location.

Visual Basic

```
' PrnConnector.vbs 
' 06/10/2005 V 1.0
' Emad Aziz e.aziz@soton.ac.uk
On Error Resume Next
Const number0 = 0, number1 = 1, number2 = 2, number3 = 3, number4 = 4, number5 = 5, number6 = 6, number7 = 7, number8 = 8, number9 = 9, number10 = 10
Dim argNumber, pop, queueName, popvalue
popvalue = "/popup"
Computers = Array("Central01",  "Central02","Central03","remote01","remote02","remote03","remote04","remote05","remote06","remote07","remote08")
Set objectShell =WScript.CreateObject("WScript.Shell")
Set wshnetwork = createobject("WScript.Network")
Set objectArgs = WScript.Arguments
pop = Lcase(objectArgs(number0))
argNumber = objectArgs.Count - number2 
If objectArgs.Count < number3 Then
help()
Else 
main()
End If
WScript.Quit
'Sub main()
Sub main()
SrvName = LCase(objectArgs(number1))
defaultsrv = defaultServer(Srvname)
location = locationArea(defaultsrv)
secondSrv = secSrv(location, defaultsrv)
counter = number0
If Isconnected(defaultsrv) Then 
Do
queueName = objectArgs(counter+number2)
Call pconnecter1(defaultsrv, queueName)
counter = counter + number1
Loop While counter < argNumber
If pop = popvalue Then
popUpConnector()
End If 
Elseif Isconnected(secondSrv) Then
Do
queueName = objectArgs(counter+number2)
Call pconnecter1(secondSrv, queueName)
counter = counter + number1
Loop While counter < argNumber
If pop = popvalue Then
popUpConnector()
End If
Else 
reportError()
End If
End Sub
' SUB popUpConnector()
Sub popUpConnector()
WScript.Sleep 5000
objectShell.Run """\\Domain\DFSroot\System Tools\PrintQConnector\PPOPUP.EXE""/noexit /poll=5"
End Sub
Function Isconnected(SrvName)
strPingCmdEcdl = "ping -n 3 -w 254 " & SrvName
Set objectExecobject = objectShell.Exec("%comspec% /c " & strPingCmdEcdl)

Do While Not objectExecObject.stdOut.AtEndofStream
strText = objectExecObject.stdOut.ReadLine()
If Instr(strText, "Reply") > 0 Then 
Isconnected = 1
Exit Do
Else 
Isconnected = 0
End If 
Loop
End Function
Sub pconnecter1 (srv, queueName )
wshnetwork.addwindowsprinterconnection "\\" & srv & "\" & queueName
End Sub
Function defaultServer(defaultSrv)
Select Case defaultSrv
Case "central011"
defaultServer = Computers(number0)
Exit Function 
Case "central02"
defaultServer = Computers(number1)
Exit Function
Case "central03"
defaultServer = Computers(number2)
Exit Function
Case "remote01"
defaultServer = Computers(number3)
Exit Function
Case "remote02"
defaultServer = Computers(number4)
Exit Function
Case "remote03"
defaultServer = Computers(number5)
Exit Function
Case "remote04"
defaultServer = Computers(number6)
Exit Function
Case "remote05"
defaultServer = Computers(number7)
Exit Function
Case "remote06"
defaultServer = Computers(number8)
Exit Function
Case "remote07"
defaultServer = Computers(number9)
Exit Function
Case "remote08"
defaultServer = Computers(number10)
Exit Function
Case Else
WScript.Echo "NO Server found, Please consult System adminstartor, call Service Line on 25656"
WScript.Quit
End Select
End Function
Function secSrv(location, SrvName)
Select Case location
Case "central"
If srvName = Computers(number0) Then
secSrv = Computers(number1)
Else 
secSrv = Computers(number0)
End If
Case "remote1"
If srvName = Computers(number3) Then
secSrv = Computers(number4)
Else 
secSrv = Computers(number3)
End If
Case "Remote2"
secSrv = Computers(number0)
End Select 
End Function
Function locationArea(serverName)
If serverName = Computers(number0) Or serverName = Computers(number1) Then
location = "central"
locationArea = location 
Elseif serverName = Computers(number3) Or serverName = Computers(number4) Then
location = "remote1"
locationArea = location 
Else 
location = "Remote2"
locationArea = location 
End If
End Function
Sub help()
msgbox "Connects to print server and its Queue(s)" & vbCr &_"Usage:" & vbCr &_"======" & vbCr &_"Prnconnector.vbs PrntSrv Q1 Q2 ....." & vbCr &_"examples:" & vbCr &_"======" & vbCr &_"Prnconnector.vbs /nopopup central01 LaserJet 4550" & vbCr &_"Prnconnector.vbs /popup central02 Color LaserJet 4550" & vbCr &_"Please note that you SHOULD add "" for any queue that has Spaces" & vbCr &_"Emad Aziz - ISS"   & _vbCr & vbCr,, "Public Workstations Queues Connector" 
WScript.Quit
End Sub
Sub reportError()
    msgbox "No printers are connected, Please call Service Line on 25656" & vbCr &_"  Emad Aziz - ISS"   & _    vbCr,, "Service Line" 
End Sub
```

