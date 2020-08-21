# List Printer Capabilities

## Original Links

- [x] Original Technet URL [List Printer Capabilities](https://gallery.technet.microsoft.com/83421975-55ee-453e-8834-d2540a1ae35f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/83421975-55ee-453e-8834-d2540a1ae35f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists properties and capabilities for all the printers installed on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_PrinterConfiguration")

For Each objPrinter in colInstalledPrinters
    Wscript.Echo "Name: " & objPrinter.Name
    Wscript.Echo "Collate: " & objPrinter.Collate
    Wscript.Echo "Copies: " & objPrinter.Copies
    Wscript.Echo "Driver Version: " & objPrinter.DriverVersion
    Wscript.Echo "Duplex: " & objPrinter.Duplex
    Wscript.Echo "Horizontal Resolution: " & _
        objPrinter.HorizontalResolution
    If objPrinter.Orientation = 1 Then
        strOrientation =  "Portrait"
    Else 
        strOrientation = "Landscape"
    End If
    Wscript.Echo "Orientation : " & strOrientation
    Wscript.Echo "Paper Length: " & objPrinter.PaperLength / 254
    Wscript.Echo "Paper Width: " & objPrinter.PaperWidth / 254
    Wscript.Echo "Print Quality: " & objPrinter.PrintQuality
    Wscript.Echo "Scale: " & objPrinter.Scale
    Wscript.Echo "Specification Version: " & _
        objPrinter.SpecificationVersion
    If objPrinter.TTOption = 1 Then
        strTTOption = "Print TrueType fonts as graphics."
    Elseif objPrinter.TTOption = 2 Then
        strTTOption = "Download TrueType fonts as soft fonts."
    Else
        strTTOption = "Substitute device fonts for TrueType fonts."
    End If
    Wscript.Echo "True Type Option: " & strTTOption
    Wscript.Echo "Vertical Resolution: " & objPrinter.VerticalResolution
Next
```

