# Migrate Printers

## Original Links

- [x] Original Technet URL [Migrate Printers](https://gallery.technet.microsoft.com/e74689e3-66e6-45c8-840b-0df67c264f5b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/e74689e3-66e6-45c8-840b-0df67c264f5b/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Al Wheedleton

Remaps printers to a new print server.

Visual Basic

```
Option explicit                        
On Error Resume Next  

Dim strPrintServerOld, strPrintServerNew, strComputer, strPrintShare          
Dim objWMIService, objPrinter, objNetwork           
Dim colInstalledPrinters        

'If any printer on the user's PC has a path other than the old server
'nothing will happen.
strPrintServerOld = "\\oldserver" 
strPrintServerNew = "\\newserver" 

strComputer = "."  
Set objNetwork = CreateObject("WScript.Network") 

Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")  

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Default = True")

For Each objPrinter in colInstalledPrinters
  strPrintShare = objPrinter.ShareName
  
  'If the old server was in all Capital letters change it to small letters
  If objPrinter.ServerName = "\\OLDSERVER"  Then
    objPrinter.ServerName = "\\oldserver"
  End if
  
  'Iterate through default printers first
  If objPrinter.ServerName = strPrintServerOld And objPrinter.default = True Then 
    objNetwork.AddWindowsPrinterConnection strPrintServerNew & "\" _
      & strPrintShare      
    objNetwork.SetDefaultPrinter(strPrintServerNew & "\" & strPrintShare)
    WScript.Sleep(5000) 
    
    'Script will quit if it cannot connect to the new server
    If err.Number <> 0 Then
      WScript.Echo "Could not connect to " & strPrintServerNew & vbCrLf  _
      & " Script is exiting without changes"
      err.Clear
      WScript.Quit  
    End if 
    
  Else  'These four lines can be commented out to reduce messages
        'for a logon script.
    WScript.Echo "Could not map default printer"
  End if
  WScript.Echo "Default is set"
Next  

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")
    
For Each objPrinter in colInstalledPrinters
  strPrintShare = objPrinter.ShareName
  
  'If the old server was in all Capital letters change it to small letters
  If objPrinter.ServerName = "\\OLDSERVER"  Then
    objPrinter.ServerName = "\\newserver"
  End if
  
  If objPrinter.ServerName = strPrintServerOld Then        
    
    'If not the default and in the list then create a new connection
    objNetwork.AddWindowsPrinterConnection strPrintServerNew & "\" _
      & strPrintShare
    WScript.Sleep(5000)          
          
    'Once all printers are mapped with the new server, the old server mapping
    'is removed
    objNetwork.RemovePrinterConnection strPrintServerOld & "\" _
      & StrPrintShare
    	
  End If  
Next

'This message can be commented out for a logon script.
WScript.Echo "Finished with Printers"

Set objWMIService = Nothing   
Set objNetwork = Nothing
```

