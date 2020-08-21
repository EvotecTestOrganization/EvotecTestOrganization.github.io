# List Printer Connections

## Original Links

- [x] Original Technet URL [List Printer Connections](https://gallery.technet.microsoft.com/45ce3543-b951-44da-9315-49d0e741ba1d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/45ce3543-b951-44da-9315-49d0e741ba1d/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer connections on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    Wscript.Echo "Name: " & objPrinter.Name
    Wscript.Echo "Location: " & objPrinter.Location
    Wscript.Echo "Default: " & objPrinter.Default
Next
```

