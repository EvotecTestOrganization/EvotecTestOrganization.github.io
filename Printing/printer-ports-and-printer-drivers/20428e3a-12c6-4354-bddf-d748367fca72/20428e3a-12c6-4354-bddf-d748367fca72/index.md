# Move Printers from One Print Server to Another

## Original Links

- [x] Original Technet URL [Move Printers from One Print Server to Another](https://gallery.technet.microsoft.com/20428e3a-12c6-4354-bddf-d748367fca72)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/20428e3a-12c6-4354-bddf-d748367fca72/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Martin Berton

Moves mapped printers from one print server to another.

Visual Basic

```
'Replace mapped printers from one print server to another
'Shared printers on new server must have identical printer sharenames as printers on old server
'Replaced and removed printers is logged in a logfile
'Written by: Martin Berton (martin.berton@infocare.se)

on error resume next

Const ForReading = 1, ForWriting = 2, ForAppending = 8 

'=======================================
'Here you name the servers and logfile
'=======================================

oldprintserver = "OLDSERVER"
newprintserver = "NEWSERVER"
logfilepath = "remapp_printers.txt"


Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetxt = filesys.OpenTextFile(logfilepath, ForAppending, True) 

'Default printer is read from the registry
Set objShell = CreateObject("WScript.Shell")
sPath = "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device"
ar_PrnInfo = Split(objShell.RegRead(sPath), ",")
sPrinter = ""
 
If IsArray(ar_PrnInfo) Then
   sPrinter = ar_PrnInfo(0)
End If

'Installed printers is read
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set Printers = WshNetwork.EnumPrinterConnections

'Checking if printers is on old print server
For i = 0 to Printers.Count - 1 
  if UCase(Mid(Printers.Item(i), 2, Len(oldprintserver)+2)) = "\"& oldprintserver &"\" Then
     oldprinter = Printers.Item(i)
     newprinter = "\\" & newprintserver & "\" & Mid(Printers.Item(i), Len(oldprintserver)+4)

     ' Check if printer the printer on the new print server allready is installed
     allreadyinstalled = false
     For j = 0 to Printers.Count - 1 
       if newprinter = Printers.Item(j) Then
          allreadyinstalled = true
       end if
     Next

     if allreadyinstalled then
       'If the printer allreday is installed, the printer on the old print server will be removed
       filetxt.WriteLine(oldprinter & " removed")
     else
       'If the printer is not installed, the printer on the new print server is installed
       'and the printer on the old print server will be removed
       filetxt.WriteLine(oldprinter & " replaced with " & newprinter)
       WshNetwork.AddWindowsPrinterConnection newprinter
     end if
     WshNetwork.RemovePrinterConnection oldprinter

  end if
Next

'if the users default printer is a printer on the old print server, the default printer
'is changed to the new print server
if UCase(Mid(sPrinter, 2, Len(oldprintserver)+2)) = "\"& oldprintserver &"\" Then
     PrinterPath = "\\" & newprintserver & "\" & Mid(sPrinter, Len(oldprintserver)+4)
     filetxt.WriteLine("New default printer = " & PrinterPath)
     WshNetwork.SetDefaultPrinter PrinterPath

End If

filetxt.Close
```

