# Delete A Printer Por

## Original Links

- [x] Original Technet URL [Delete A Printer Por](https://gallery.technet.microsoft.com/60308cdd-bcf8-46b8-9f8d-5384d34faa08)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/60308cdd-bcf8-46b8-9f8d-5384d34faa08/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes a TCP/IP printer port from a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPorts =  objWMIService.ExecQuery _
    ("Select * from Win32_TCPIPPrinterPort Where Name = 'IP_169.254.110.14'")

For Each objPort in colInstalledPorts 
    objPort.Delete_
Next
```

