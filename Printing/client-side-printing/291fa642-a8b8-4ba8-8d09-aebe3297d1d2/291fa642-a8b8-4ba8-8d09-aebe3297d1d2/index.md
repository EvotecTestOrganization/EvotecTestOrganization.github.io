# Assign a Default Printer

## Original Links

- [x] Original Technet URL [Assign a Default Printer](https://gallery.technet.microsoft.com/291fa642-a8b8-4ba8-8d09-aebe3297d1d2)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/291fa642-a8b8-4ba8-8d09-aebe3297d1d2/description)
- [x] Download: Not available.

## Output from Technet Gallery

Sets the default printer on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Name = 'ScriptedPrinter'")

For Each objPrinter in colInstalledPrinters
    objPrinter.SetDefaultPrinter()
Next
```

