# Reinstall a Client Printer

## Original Links

- [x] Original Technet URL [Reinstall a Client Printer](https://gallery.technet.microsoft.com/87f9a46c-01b9-4217-9286-3234c16e8929)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/87f9a46c-01b9-4217-9286-3234c16e8929/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Fergy

Reinstalls a client printer, reflecting changes made to a network print server.

Visual Basic

```
'***************************************
'*** Name : 	BobchgPrt.vbs   ***
'*** Author : 	M. Ferguson(Fergy) ***
'*** Created: 	19/07/2005          ***
'*** Modified:	06/10/2005           ***
'*** Modified by: Fergy		          ***
'***************************************
Option Explicit
'On Error Resume Next

Const ForReading = 1

'*******************************  Variables declared ******************************
Dim Wsh, WsNet
Dim Strline, Serv
Dim ObjFso
Dim objservice
Dim wsnet1
Dim objComputer
Dim PrtArray()
Dim nodftprt, Prtpos
Dim Prtnum, prtlen
Dim oldprt, flrnum
Dim Srvname, City 
Dim NewPrter, defaultprinter
Dim dfltprter
Dim newdfltprt, olddfltprt
Dim PrtServ, PrtCity
Dim lenprtnum, chkdflt
Dim Rdfile, wrfile
Dim OPrtnum, flrcity 
Dim NCity, NPrtnum
Dim i, prtdflt
Dim PrtDigital
Dim OldServ, StrPrtname
Dim strdfltprt
Dim Prter1
Dim numcnt
Dim string3
Dim objprinter
Dim strcomputer
Dim objWMIService
Dim colInstalledPrinters
Dim cnter1

string3 = "\\CA"
i = 0

numcnt = 0
chkdflt = 0
OPrtnum = 0
'************************* Network & System Objects required  **********************
Set ObjFso = CreateObject("Scripting.FileSystemObject")
Set WsNet = CreateObject("WScript.Network")
Set Wsh = CreateObject("WScript.Shell")
	'************** Retrieve Current Default Printer **************** 
defaultprinter = Wsh.RegRead _
    ("HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device")
dfltprter = Split(defaultprinter, ",")
olddfltprt = UCASE(dfltprter(0))

'********** Get computer name and apply the impersonate WMI service for printers and 
'********** run a Printer query
strComputer = WsNet.ComputerName

Set objWMIService = GetObject _
    ("winmgmts:{impersonationLevel=impersonate}!\\" & strcomputer & "\root\cimv2")
Set colInstalledPrinters =  objWMIService.ExecQuery("SELECT * FROM Win32_Printer")

'******* From the printer query load printers installed into an array and remove and 
'******* add re-printer
For Each objprinter In colInstalledPrinters 
ReDim Preserve PrtArray(i) If string3 = Ucase(Left(objprinter.name, 4)) Then	PrtArray(i) = UCASE(objprinter.name)	'OPrtnum = OPrtnum + 1'WScript.Echo PrtArray(i)	WsNet.RemovePrinterConnection PrtArray(i)	WScript.Sleep(3000)	WsNet.AddWindowsPrinterConnection(PrtArray(i))	 End If    If olddfltprt = PrtArray(i) Then
      	WsNet.SetDefaultPrinter PrtArray(i)
      	      	'newdfltprt = Prter1
         chkdflt = 1    End If i = i + 1
  Next  

'******************** Notify User that default printer Not on Network ************
If chkdflt = 0 ThenWScript.Echo "Default printer not available. Please install manually"
End If

WScript.Echo "Completed" ' Notification that printer process is completed

Set WsNet = Nothing
Set Wsh = Nothing
```

