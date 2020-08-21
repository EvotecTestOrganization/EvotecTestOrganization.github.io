# Pause All Printers with Empty Print Queues

## Original Links

- [x] Original Technet URL [Pause All Printers with Empty Print Queues](https://gallery.technet.microsoft.com/cf2b6b61-8ffe-444b-857b-e3a205bc693c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/cf2b6b61-8ffe-444b-857b-e3a205bc693c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Pauses any printers that have no pending print jobs.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    Set colPrintJobs = objWMIService.ExecQuery _
        ("Select * from Win32_PerfFormattedData_Spooler_PrintQueue " _
            & "Where Name = '" & objPrinter.Name & "'")
    For Each objPrintQueue in colPrintJobs
        If objPrintQueue.Jobs = 0 and objPrintQueue.Name <> "_Total" Then
            objPrinter.Pause()
        End If
    Next
Next
```

