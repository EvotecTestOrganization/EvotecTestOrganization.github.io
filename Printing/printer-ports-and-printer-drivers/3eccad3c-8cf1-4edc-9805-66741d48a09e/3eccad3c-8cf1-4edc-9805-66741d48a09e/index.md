# Change the Printer Server on a Client Computer

## Original Links

- [x] Original Technet URL [Change the Printer Server on a Client Computer](https://gallery.technet.microsoft.com/3eccad3c-8cf1-4edc-9805-66741d48a09e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/3eccad3c-8cf1-4edc-9805-66741d48a09e/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **moshe.or@gmail.com

Points an existing printer on a client computer to a new print server.

Visual Basic

```
'Qchange.vbs

'Syntax:
'   cscript qchange.vbs changes.txt
'   File format: \\ServerName\Source_Printer;\\New_server\Source_printer

On Error Resume Next

Const VERBOSE = "N"   'Display progress (Y or N)
Const Title = "Print Connection Migrator"
Const ForReading = 1

Dim strDefaultPrinter 
Dim InstalledPrinters 'Array of printer names
Dim Textfile          'File with print Q names
Dim OldPrintQueues()  'Dynamic array to store old print queue names, from the text file
Dim NewPrintQueues()  'Dynamic array to store new print queue names, from the text file
Dim fso         'File System Object
Dim objTextFile 'Text file object
Dim strNextLine 'Line of the text file
Dim i
Dim WshNetwork

Set WshNetwork = CreateObject("WScript.Network")

' 1. - Get the command line args        ###

SET Parameters = Wscript.arguments

'If no command line arguments provided, quit
If Parameters.Count = 0 Then
    WScript.Quit(1)
Else
    Textfile = Parameters.item(0)
End If

If Textfile = "" or Not Right(TextFile,4) = ".txt" or Not FileExist(Textfile) Then
    Error=MsgBox("No valid input file provided. Stopping the script now.",vbokonly, Title)
    WScript.Quit(1)
End If

If VERBOSE = "Y" Then Wscript.Echo "Reading input file"
    
' 2. Read the text file and import it in a Array    ###

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSO.OpenTextFile (TextFile, ForReading)

i=-1
While not objTextFile.AtEndOfStream
    i = i+1
    Redim Preserve OldPrintQueues(i)
    ReDim Preserve NewPrintQueues(i)
    strLine = objTextFile.Readline
    'Do not import the comment lines
    If Left(strLine,2) = "\\" Then
        OldPrintQueues(i) = Left(strLine,InStr(strline,";")-1)
        If VERBOSE = "Y" Then Wscript.Echo " old Q is: " & OldPrintQueues(i)
        NewPrintQueues(i) = Mid(strline,InStr(strline,";")+1,Len(strline))
        If VERBOSE = "Y" Then Wscript.Echo " new Q is: " & NewPrintQueues(i)
    End If
Wend

objTextFile.Close

' 3. Store the name of the default Printer        ###

strDefaultPrinter = DefaultPrinter
If VERBOSE = "Y" Then Wscript.Echo " Default is: " & strDefaultPrinter

' 4. WMI query for current printer connections    ###

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colInstalledPrinters = objWMIService.ExecQuery _
("Select * from Win32_Printer")

' 5. Main Loop through printer collection         ###

For Each objPrinter in colInstalledPrinters
    If VERBOSE = "Y" Then Wscript.Echo " Current connection: " & objPrinter.Name
    If Left(objPrinter.Name, 2) = "\\" Then 'Work only On network printers
        'Search the corresponding printer and create it
        i = 0 'set the indice at the beginning of the array (prepare to loop)
        Do Until i > UBound(OldPrintQueues)
            If UCase(objPrinter.Name) = UCase(OldPrintQueues(i)) Then
                'Create the connection to the new printer
                If VERBOSE = "Y" Then Wscript.Echo " New connection: " & NewPrintQueues(i)
                WshNetwork.AddWindowsPrinterConnection NewPrintQueues(i)
                If UCase(strDefaultPrinter) = UCase(objPrinter.Name) Then 'This is the default printer
                    'Set the default Printer
                    WshNetwork.SetDefaultPrinter NewPrintQueues(i)
                End If
                'Delete the printer connection
                WshNetwork.RemovePrinterConnection objPrinter.Name
                If VERBOSE = "Y" Then Wscript.Echo " Removing : " & objPrinter.Name           
            End If
            i = i + 1
        Loop
    End If 'End of check for network printers
Next 'End of the loop through the printers of this user

Set WshNetwork = Nothing


'-----------------
' Functions
'-----------------

'Return the default printer
Function DefaultPrinter
    Dim strComputer
    Dim Result
    
    strComputer = "."
    Result = ""
    
    Set objWMIService = GetObject("winmgmts:" _
     & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colInstalledPrinters = objWMIService.ExecQuery _
     ("Select * from Win32_Printer")
    For Each objPrinter in colInstalledPrinters
        If objPrinter.Default = True Then
         Result = objPrinter.Name
        End If
    Next
    DefaultPrinter = Result
End Function

'-----------------

'Does File Exist (Boolean)
Function FileExist (FileFullPath)
    Dim Fso
    Set Fso = CreateObject("Scripting.FileSystemObject")
    If (Fso.FileExists(FileFullPath)) Then
        FileExist = True
    Else
        FileExist = False
    End If
End Function
```

