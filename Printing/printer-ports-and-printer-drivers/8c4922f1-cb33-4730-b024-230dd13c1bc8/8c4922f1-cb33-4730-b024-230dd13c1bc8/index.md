# Move Networked Printers

## Original Links

- [x] Original Technet URL [Move Networked Printers](https://gallery.technet.microsoft.com/8c4922f1-cb33-4730-b024-230dd13c1bc8)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/8c4922f1-cb33-4730-b024-230dd13c1bc8/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Francis Morley

Moves networked printers on a local computer from one print server to another. The script also identifies the default printer and maintains that setting after remapping the printers.

Visual Basic

```
'==========================================================================
'
' NAME: MovePrinters.vbs
'
' AUTHOR: Francis Morley
' DATE  : 03/02/2006
'
' COMMENT: Moves desired networked printers on a local computer from one print
'	   server to another print server by deleting the printers and recreating. 
'	   Determines the default printer and sets back the default printer 
'	   after recreation. Used for 2000 workstation printer migration.
'
' NOTE:	   We used a longer version which created a text file on a network share
'	   for each computer changed. The text file was called [username]-
'	   [computername].txt. The text file listed all the printers on the local
'	   computer and the default printer. This helped us track the changes.
'
'==========================================================================


Const HKEY_CURRENT_USER = &H80000001
Dim LocationArrays(2)

strComputer = "."

'List Printers To Be Changed
LocationArrays(0) = "PrinterName A"
LocationArrays(1) = "PrinterName B"
LocationArrays(2) = "PrinterName C"


Set WshNetwork = WScript.CreateObject("WScript.Network")

'Determine Default PrinterSet oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _ strComputer & "\root\default:StdRegProv")
strKeyPath = "Software\Microsoft\Windows NT\CurrentVersion\Windows"strValueName = "Device"oReg.GetStringValue HKEY_CURRENT_USER,strKeyPath,strValueName,strValue
strDefaultPrnt = strValuevlenDefaultPrnt = Len(strDefaultPrnt)vlenDefaultPrntm =  vlenDefaultPrnt - 15strDefaultPrntm = Left(strDefaultPrnt,vlenDefaultPrntm)

'Enumerate Printers and Change
   	Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\CIMV2")
   	Set colInstalledPrinters  = objWMIService.ExecQuery("SELECT * FROM Win32_Printer")

For Each objPrinter In colInstalledPrinters 
   	   vDeviceID = objPrinter.DeviceID
   For Each LocationArray In LocationArrays
   	      If (UCASE(vDeviceID)) = ("\\PRINTSERVER1\" & LocationArray & "") Then	 WshNetwork.RemovePrinterConnection "\\PRINTSERVER1\" & LocationArray & ""	 WshNetwork.AddWindowsPrinterConnection "\\PRINTSERVER2\" & LocationArray & ""
	 If vDeviceID = strDefaultPrntm Then	    WshNetwork.SetDefaultPrinter "\\PRINTSERVER2\" & LocationArray & ""	 End If      End If

   	      If (UCASE(vDeviceID)) = ("\\192.168.1.111\" & LocationArray & "") Then	 WshNetwork.RemovePrinterConnection "\\192.168.1.111\" & LocationArray & ""	 WshNetwork.AddWindowsPrinterConnection "\\192.168.2.222\" & LocationArray & ""
   	 If vDeviceID = strDefaultPrntm Then	    WshNetwork.SetDefaultPrinter "\\192.168.2.222\" & LocationArray & ""	 End If      End If   NextNext
```

