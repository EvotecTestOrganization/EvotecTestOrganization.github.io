# List Printer Port Availability

## Original Links

- [x] Original Technet URL [List Printer Port Availability](https://gallery.technet.microsoft.com/55b0be84-64a2-41e9-9775-f607247641ec)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/55b0be84-64a2-41e9-9775-f607247641ec/description)
- [x] Download: Not available.

## Output from Technet Gallery

Identifies all the TCP/IP printer ports on a computer, and indicates which ports are being used and which ports are available.

Visual Basic

```
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
        strUsedPorts = strUsedPorts & _
            objDictionary.Item(objPort.Name) & VbCrLf
    Else
        strFreePorts = strFreePorts & objPort.Name & vbCrLf
    End If
Next

Wscript.Echo "The following ports are in use: " & VbCrLf & strUsedPorts
Wscript.Echo "The following ports are available: " & VbCrLf & strFreePorts
```

