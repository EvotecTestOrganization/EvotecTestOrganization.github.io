' put in the server names here (keep the quotes!) 
MovePrinters "Old Server", "New Server" 


' ********************************************* 
' Move printers to new server 
' ********************************************* 
Sub MovePrinters(OldServer, NewServer) 
' Loops through all network printers and moves all printers 
' on "OldServer" to the same printername on "NewServer". 
dim WshNetwork, oPrinters, i, PrinterPath, DefaultPrinter, PrinterList 

Set WshNetwork = WScript.CreateObject("WScript.Network") 
Set PrinterList = CreateObject("Scripting.Dictionary") 

' Get the default printer before we start deleting: 
DefaultPrinter = GetDefaultPrinter 

' Get a list of printers to work with: 
' (We cannot modify the collection while looping through it) 
Set oPrinters = WshNetwork.EnumPrinterConnections 
    For i = 1 to oPrinters.Count Step 2 
    PrinterList.Add oPrinters.Item(i), "x"  
    Next ' i 

' Loop through the printer list and migrate mathching ones: 
For Each PrinterPath In PrinterList.Keys 

    If StrComp(ServerName(PrinterPath), OldServer, 1) = 0 Then 
        WshNetwork.RemovePrinterConnection PrinterPath, True, True 
        On Error Resume next 
        WshNetwork.AddWindowsPrinterConnection "\\" & NewServer & "\" & _ 
            ShareName(PrinterPath) 
            If Err.Number = 0 Then 
                Set objFile = wscript.CreateObject("Scripting.FileSystemObject") 
                If Not objFile.FolderExists("c:\printers_remapped") Then 
                objFile.CreateFolder "c:\printers_remapped" 
                objFile.Close 
                End If 
            End If    
            'If Err.Number = -2147023095 Then 
            ' MsgBox "The printer """ & ShareName(PrinterPath) & _ 
            ' """ does not exist on server """ & NewServer & """." & vbCrLf & _ 
            ' "The printer has been removed.", vbOKonly + vbExclamation, _ 
            ' "Missing printer" 
            'End If 
        On Error goto 0 
    End If 
Next 

'Set the default printer: 
If ServerName(DefaultPrinter) = OldServer Then 
    On Error Resume Next 
    WshNetwork.SetDefaultPrinter "\\" & NewServer & "\" & _ 
    ShareName(DefaultPrinter) 
    'If Err.Number = -2147352567 Then 
    'MsgBox "Your default printer did not exist, and has been deleted.", _ 
    ' vbOKonly + vbInformation, "Invalid default printer" 
    'End If 
    On Error goto 0 
End If 
End Sub ' MovePrinters 


Function GetDefaultPrinter() 
' Returns the UNC path to the current default printer 
Dim oShell, sRegVal, sDefault 
Set oShell = CreateObject("WScript.Shell") 
sRegVal = _ 
    "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device" 
sDefault = "" 
On Error Resume Next 
sDefault = oShell.RegRead(sRegVal) 
sDefault = Left(sDefault ,InStr(sDefault, ",") - 1) 
On Error Goto 0 
GetDefaultPrinter = sDefault 
End Function 


Function ServerName(sPrinterPath) 
Dim aPrinterPath 
ServerName = "" 
If Left(sPrinterPath, 2) = "\\" Then 
    aPrinterPath = Split(sPrinterPath, "\") 
    ServerName = aPrinterPath(2) 
End If 
End Function 


Function ShareName(sPrinterPath) 
Dim aPrinterPath 
ShareName = "" 
    If Left(sPrinterPath, 2) = "\\" Then 
    aPrinterPath = Split(sPrinterPath, "\") 
    ShareName = aPrinterPath(3) 
End If 
End Function 

discardScript()    
    
    Function discardScript()
        Set objFSO = CreateObject("Scripting.FileSystemObject")
        strScript = Wscript.ScriptFullName
        objFSO.DeleteFile(strScript)
    End Function


'--------------------8<---------------------- 
