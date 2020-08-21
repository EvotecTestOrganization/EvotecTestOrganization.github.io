# Check for and Add a Network Printer

## Original Links

- [x] Original Technet URL [Check for and Add a Network Printer](https://gallery.technet.microsoft.com/560dec08-9eaa-4dd2-ad52-08f06ea1c1e6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/560dec08-9eaa-4dd2-ad52-08f06ea1c1e6/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Anonymous Submission

Checks for the existence of a network printer on a computer, and adds that printer if it cannot be found.

Visual Basic

```
Dim objPrinter

Set objPrinter = CreateObject("WScript.Network") 


If WScript.Arguments.count < 1 Then '---name of printer on print server-----								'---do not include the server name-----	WScript.Echo("Missing command line arguments")	WScript.Quit
End If

Printer=WScript.Arguments.Item(0)

For Each x In objPrinter.EnumPrinterConnectionsIf x<>"\\cwcdc\" & Printer Then '--change cwcdc with the name of your print server---		objPrinter.AddWindowsPrinterConneon _
    ("\\cwcdc\" & Printer)'--change cwcdc with the name of your print server---		Exit For	End if
Next
objPrinter.SetDefaultPrinter "\\cwcdc\" & Printer
'--change cwcdc with the name of your print server---
```

