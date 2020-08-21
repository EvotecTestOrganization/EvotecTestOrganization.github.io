# Print a PDF Fil

## Original Links

- [x] Original Technet URL [Print a PDF Fil](https://gallery.technet.microsoft.com/5a3879e2-8536-4ba0-8b1a-e850509986ad)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5a3879e2-8536-4ba0-8b1a-e850509986ad/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Steve Yandl

Prints a PDF file to the specified printer.

Visual Basic

```
'  Statements assigning string values to strPrinterName, strPrinterDriver, and strAcroRead
'  should reflect the name and driver for designated printer and correct path to Acrobat Reader

'  Steve Yandl

'  ==============================================================

strPrinterName = "hp psc 2500 series"
strPrinterDriver = "hp psc 2500 series"
strAcroRead = "C:\Program Files\Adobe\Acrobat 7.0\Reader\acrord32.exe"

Dim wsh

Set fso = CreateObject("Scripting.FileSystemObject")

'  Verify that passed argument represents an existing Adobe pdf file

If WScript.Arguments.Count = 0 Then
WScript.Quit
End If

strPDFpath = WScript.Arguments.Item(0)

If Not fso.FileExists(strPDFpath) Then
WScript.Quit
End If

If Not fso.GetExtensionName(strPDFpath) = "pdf" Then
WScript.Quit
End If

'  Launch Acrobat Reader to print pdf file from designated printer

Set wsh = CreateObject("WScript.Shell")

wsh.Run Chr(34) & strAcroRead & Chr(34) & " /t  "  _& Chr(34) & strPDFpath & Chr(34) & " " _& Chr(34) & strPrinterName & Chr(34) & " " & Chr(34) & strPrinterDriver & Chr(34)

'  After allowing 15 seconds for spooling print job, kill the Acrobat Reader process

WScript.Sleep 15000
strComputer = "."
Set objWMIService = GetObject _
    ("winmgmts:\\" & strComputer & "\root\cimv2")
Set colProcessList = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where Name = 'acrord32.exe'")
For Each objProcess in colProcessList
    objProcess.Terminate()
Next
```

