# List Print Queue Statistics

## Original Links

- [x] Original Technet URL [List Print Queue Statistics](https://gallery.technet.microsoft.com/5588f58e-891e-4f77-8c49-c6c4ff7fdd59)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5588f58e-891e-4f77-8c49-c6c4ff7fdd59/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses cooked performance counters to retrieve data such as total number of jobs printed and total number of printing errors for each print queue on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintQueues =  objWMIService.ExecQuery _
    ("Select * from Win32_PerfFormattedData_Spooler_PrintQueue Where " & _
        "Name <> '_Total'")

For Each objPrintQueue in colPrintQueues
    Wscript.Echo "Name: " & objPrintQueue.Name
    Wscript.Echo "Jobs: " & objPrintQueue.Jobs
    Wscript.Echo "Current jobs spooling: " & objPrintQueue.JobsSpooling
    Wscript.Echo "Maximum jobs spooling: " & objPrintQueue.MaxJobsSpooling
    Wscript.Echo "Total jobs printed: " & objPrintQueue.TotalJobsPrinted
    Wscript.Echo "Job errors: " & objPrintQueue.JobErrors
    Wscript.Echo "Not ready errors: " & objPrintQueue.NotReadyErrors
    Wscript.Echo "Out of paper errors: " & objPrintQueue.OutOfPaperErrors
Next
```

