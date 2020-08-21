# Delete Unused Printer Ports

## Original Links

- [x] Original Technet URL [Delete Unused Printer Ports](https://gallery.technet.microsoft.com/c06c3764-d77a-43ae-b8ce-ad79a20dfd4f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/c06c3764-d77a-43ae-b8ce-ad79a20dfd4f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes any printer ports that have been installed on a computer but are not in use.

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
    Else
        ObjPort.Delete_
    End If
Next
```

