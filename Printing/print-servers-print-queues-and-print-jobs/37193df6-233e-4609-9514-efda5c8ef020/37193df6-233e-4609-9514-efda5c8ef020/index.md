# Monitor Printer Status

## Original Links

- [x] Original Technet URL [Monitor Printer Status](https://gallery.technet.microsoft.com/37193df6-233e-4609-9514-efda5c8ef020)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/37193df6-233e-4609-9514-efda5c8ef020/description)
- [x] Download: Not available.

## Output from Technet Gallery

Displays current status for all printers on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    Wscript.Echo  "Name: " & objPrinter.Name
    Wscript.Echo  "Location: " & objPrinter.Location
    Select Case objPrinter.PrinterStatus
        Case 1
            strPrinterStatus = "Other"
        Case 2
            strPrinterStatus = "Unknown"
        Case 3
            strPrinterStatus = "Idle"
        Case 4
            strPrinterStatus = "Printing"
        Case 5
            strPrinterStatus = "Warmup"
    End Select
    Wscript.Echo  "Printer Status: " & strPrinterStatus
    Wscript.Echo  "Server Name: " & objPrinter.ServerName
    Wscript.Echo  "Share Name: " & objPrinter.ShareName
    Wscript.Echo
Next
```

