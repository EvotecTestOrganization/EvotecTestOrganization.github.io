# Add and Remove Printers

## Original Links

- [x] Original Technet URL [Add and Remove Printers](https://gallery.technet.microsoft.com/10ab836d-4d38-45a5-8d27-ba9af1717930)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/10ab836d-4d38-45a5-8d27-ba9af1717930/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Larry Motz

Logon script that installs new printers and deletes old printers.

Visual Basic

```
' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
' Script to remove a printer and add a new replacement printer (Names are case sensative, at least for me they were).
' Put in Logon Script after new printers have been added and IP Addresses and Names have been changed.
' Replace "ptr_server" with your print server, replace "prt_del" with the printer name you want to delete, and replace "prt_add" with the new printer name
' By Larry Motz 27 October 2005
' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

On Error Resume Next

strComputer = "."
' Set objWMIService = GetObject("winmgmts:" _
'   & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
  
Dim objNetwork
Set objNetwork = CreateObject("WScript.Network")

strPrintServer = "\\ptr_server\ptr_del"
If strPrintServer = ("\\ptr_server\ptr_del") Then
objNetwork.RemovePrinterConnection ("\\ptr_server\ptr_del") 
objNetwork.AddWindowsPrinterConnection ("\\ptr_server\ptr_add")

End If 

strPrintServer = "\\ptr_server\ptr_del"
If strPrintServer = ("\\ptr_server\ptr_del") Then
objNetwork.RemovePrinterConnection ("\\ptr_server\ptr_del") 
objNetwork.AddWindowsPrinterConnection ("\\ptr_server\ptr_add")

End If 

' Repeat above five (5) lines for each printer
```

