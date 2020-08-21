# Remove Paused Network Printers

## Original Links

- [x] Original Technet URL [Remove Paused Network Printers](https://gallery.technet.microsoft.com/f8961cb1-c4d2-446c-888c-4b3efb339234)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/f8961cb1-c4d2-446c-888c-4b3efb339234/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Ulco Landheer

Deletes connections to any network printers that are currently paused.

Visual Basic

```
'Remove Paused Network Printers on Windows 2000/XP Clients 
' 
' Runs at logon, so move on in case of an error 
On Error Resume Next 

' Scriptomatic stuff / Setting thing up for WSH 
Const wbemFlagReturnImmediately = &h10 
Const wbemFlagForwardOnly = &h20 
Set WshNetwork = WScript.CreateObject("WScript.Network") 

arrComputers = Array(".") 
For Each strComputer In arrComputers 
   WScript.Echo 
   WScript.Echo "==========================================" 
   WScript.Echo "Computer: " & strComputer 
   WScript.Echo "==========================================" 

   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2") 
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Printer", "WQL", _ 
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly) 



' Select paused printers on certain printservers and delete these                                                                         ' 

   For Each objItem In colItems 
        If objItem.PrinterStatus = 1 And (objItem.ServerName = "\\Printserver" Or _
            objItem.ServerName =  "\\Printserver2") then

                        Wcript.Echo "DeviceID: " & objItem.DeviceID 
                                WScript.Echo "Name: " & objItem.Name 
                        WScript.Echo "PrinterStatus: " & objItem.PrinterStatus 
                        WScript.Echo "ServerName: " & objItem.ServerName 
                        pPrinter = objItem.Name 
                        WScript.Echo "Deleting Printer: " & pPrinter 
                        WshNetwork.RemovePrinterConnection pPrinter, true, True 
                End if 
        Next 
next
```

