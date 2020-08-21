# Remove Printers

## Original Links

- [x] Original Technet URL [Remove Printers](https://gallery.technet.microsoft.com/658b88e8-012c-4dff-8fc7-a658cb1c6317)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/658b88e8-012c-4dff-8fc7-a658cb1c6317/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Anonymous Submission

Removes a pair of printers.

Visual Basic

```
' remove a printer script
' Printer1 is removed

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer where DeviceID = 'Printer1'")
For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next

' Printer2 is removed

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer where DeviceID = 'Printer2'")
For Each objPrinter in colInstalledPrinters
    objPrinter.Delete_
Next

' remove un-used ports

Set objDictionary = CreateObject("Scripting.Dictionary")
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")
For Each objPrinter in colPrinters 
    objDictionary.Add objPrinter.PortName, objPrinter.PortName
Next
Set colPorts = objWMIService.ExecQuery _
    ("Select * from Win32_TCPIPPrinterPort")
For Each objPort in colPorts
    If objDictionary.Exists(objPort.Name) Then
    Else
        ObjPort.Delete_
    End If
Next

' beep PC speaker when done

Set Shell = WScript.CreateObject("WScript.Shell")
Shell.Run "%comspec% /c echo " & Chr(07), 0, True
```

