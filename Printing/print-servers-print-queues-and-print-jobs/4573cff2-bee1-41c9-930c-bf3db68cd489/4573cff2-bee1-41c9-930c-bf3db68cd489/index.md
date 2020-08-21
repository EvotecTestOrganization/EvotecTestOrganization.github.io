# Pause All Print Jobs

## Original Links

- [x] Original Technet URL [Pause All Print Jobs](https://gallery.technet.microsoft.com/4573cff2-bee1-41c9-930c-bf3db68cd489)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/4573cff2-bee1-41c9-930c-bf3db68cd489/description)
- [x] Download: Not available.

## Output from Technet Gallery

Pauses all the print jobs on a print server.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintJobs =  objWMIService.ExecQuery _
    ("Select * from Win32_PrintJob")

For Each objPrintJob in colPrintJobs 
    objPrintJob.Pause
Next
```

