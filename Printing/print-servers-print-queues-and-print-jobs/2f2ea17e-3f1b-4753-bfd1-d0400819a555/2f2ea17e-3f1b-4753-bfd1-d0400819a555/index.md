# List Print Queue Statistics

## Original Links

- [x] Original Technet URL [List Print Queue Statistics](https://gallery.technet.microsoft.com/2f2ea17e-3f1b-4753-bfd1-d0400819a555)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/2f2ea17e-3f1b-4753-bfd1-d0400819a555/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns total number of jobs, total number of pages, and largest job for all print queues on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintJobs =  objWMIService.ExecQuery _
    ("Select * from Win32_PrintJob")

For Each objPrintJob in colPrintJobs 
    intTotalJobs = intTotalJobs + 1
    intTotalPages = intTotalPages + objPrintJob.TotalPages
    If objPrintJob.TotalPages > intMaxPrintJob Then
        intMaxPrintJob = objPrintJob.TotalPages
    End If
Next

Wscript.Echo "Total print jobs in queue: " & intTotalJobs 
Wscript.Echo "Total pages in queue: " & intTotalPages
Wscript.Echo "Largest print job in queue: " & intMaxPrintJob
```

