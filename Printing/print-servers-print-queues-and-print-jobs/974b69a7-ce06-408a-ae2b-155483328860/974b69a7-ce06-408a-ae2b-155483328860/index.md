# Resume a Paused Printer

## Original Links

- [x] Original Technet URL [Resume a Paused Printer](https://gallery.technet.microsoft.com/974b69a7-ce06-408a-ae2b-155483328860)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/974b69a7-ce06-408a-ae2b-155483328860/description)
- [x] Download: Not available.

## Output from Technet Gallery

Resumes a paused printer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Name = 'ArtDepartmentPrinter'")

For Each objPrinter in colInstalledPrinters 
    ObjPrinter.Resume()
Next
```

