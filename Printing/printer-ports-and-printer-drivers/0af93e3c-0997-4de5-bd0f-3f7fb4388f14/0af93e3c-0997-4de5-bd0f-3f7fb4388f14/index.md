# Replace a Local Printer with an Active Directory Printer

## Original Links

- [x] Original Technet URL [Replace a Local Printer with an Active Directory Printer](https://gallery.technet.microsoft.com/0af93e3c-0997-4de5-bd0f-3f7fb4388f14)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/0af93e3c-0997-4de5-bd0f-3f7fb4388f14/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Eric Payne

Replaces local printer connections with Active Directory printer connections.

Visual Basic

```
'#####================================================================================ 
'## Title: SwapDirectPrinterWithADPrinter.vbs
'## Version: 1.00
'## Author: Eric Payne 
'## Date: 1/19/2007
'##         
'## Purpose: 
'##         1. Swaps out the local direct printer with an AD one and add\remove printers
'## Requirements:
'##     1. The account the script executes under must have permissions to query AD
'## Basic Logic: 
'##         1. Loop through all local printers looking for directly connected ones
'##     2. Searches AD for IP address of directly connected computer in the portName field
'##         3. If found adds the new printer to local computer
'##     4. Deletes old directly connected printer
'#####================================================================================ 

On error resume Next

strComputer = "."

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
("Select * from Win32_Printer Where Network = FALSE And portName Like 'IP%' ") 
'Get all local directlly connected printers

For Each objPrinter in colInstalledPrinters 'Loop through each printer
      WScript.Echo "Found local Printer with IP of: " & objPrinter.portName
      if objPrinter.Default = vbTrue Then 'Check if default
            bolPrinterDefault = vbTrue
            WScript.Echo objPrinter.portName & " is the default printer"
      Else
            bolPrinterDefault = vbFalse
      End if
      WScript.Echo "Searching AD for printer: " & objPrinter.portName
      strPath = GetURLForPrinterInAD(objPrinter.portName) 'Search AD for printer match via IP Address = portName
      if strPath = "NotFound" Then
            WScript.Echo "Could not find " & objPrinter.portName & " printer in AD"
      Else
            WScript.Echo "Found " & strPath
            if not AddPrinter(strPath,bolPrinterDefault) Then
                  WScript.Echo "Counld not add " & strPath
            Else
                  WScript.Echo "Succesfully added " & strPath
                  Delete Old Printer
                  objPrinter.Delete_
                  if err <> 0 Then _
                      WScript.Echo "Error trying to detete local printer. Err.Number: " & err.number _
                          & vbTab & " Err.Source: " & vbTab & " Err.Description: " & err.Description 
            End if
      End if
Next
if err <> 0 Then WScript.echo "An error occurred in function Main " & err.number & " " & err.Description 

Function GetURLForPrinterInAD(strPortName) 'DESC: Returns path to printer
      On Error Resume Next
      GetURLForPrinterInAD = "Not Found"
      Const ADS_SCOPE_SUBTREE = 5
      Set objRootDSE = GetObject("LDAP://rootDSE") 'Get domain info
      strDomain = objRootDSE.Get("defaultNamingContext")
      Set objConnection = CreateObject("ADODB.Connection") 'Set ADODB 
      Set objCommand =   CreateObject("ADODB.Command")
      objConnection.Provider = "ADsDSOObject"
      objConnection.Open "Active Directory Provider"
      Set objCommand.ActiveConnection = objConnection
      objCommand.CommandText = "Select serverName, printShareName from " _     'ADSI query
                  & " 'LDAP://" & strDomain & "' where objectClass='printQueue'" _
                  &     " and portName = '" & strPortName & "'"
      objCommand.Properties("Page Size") = 10000
      objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE 
      objCommand.Properties("Timeout") = 30
      objCommand.Properties("Cache Results") = False
      Set objRecordSet = objCommand.Execute
      if err <> 0 Then WScript.echo "An error occurred trying to query: " & objCommand.CommandText & _
           " " & err.number & " " & err.Description 
      if not objRecordSet.EOF or objRecordSet.BOF Then
            objRecordSet.MoveFirst
            Do Until objRecordSet.EOF 'Loop through recordset 
                  strServerName = objRecordSet.Fields("ServerName").Value
                  colShares = objRecordSet.Fields("printShareName").Value
                  strShareName = colShares(0)
                  if strServerName <> "" and strShareName <> "" then
                        GetURLForPrinterInAD  = "\\" & strServerName & "\" & strShareName
                        Exit Do
                  Else
                        objRecordSet.MoveNext
                  End if
            Loop
      Else
            WSCript.Echo "Can't find " & strIP & " in AD"
      End if

      if err <> 0 Then WScript.echo "An error occurred in function GetURLForPrinterInAD " & _
          err.number & " " & err.Description 
End Function

Function AddPrinter(strPath,bolPrinterDefault) 
'DESC: adds AD printer to local computer and optionally sets it to default

      On Error Resume Next
      Set objNetwork = CreateObject("WScript.Network") 
      objNetwork.AddWindowsPrinterConnection strPath
      If err.Number <> 0 Then
            WScript.Echo "Could not map to " & strPath & " " & "Err.Number: " & err.number & vbTab & _
                " Err.Source: " & vbTab & " Err.Description: " & err.Description 
            Err.Clear
            AddPrinter = vbFalse
      Else
            If bolPrinterDefault Then
                  objNetwork.SetDefaultPrinter strPath
            End if
            AddPrinter = vbTrue
      End if
      if err <> 0 Then WScript.echo "An error occurred in function AddPrinter " & _
          err.number & " " & err.Description 
End Function
```

