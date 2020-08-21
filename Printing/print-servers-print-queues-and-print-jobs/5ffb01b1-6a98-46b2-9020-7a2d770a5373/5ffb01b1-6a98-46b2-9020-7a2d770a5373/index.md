# Monitor Print Job Status

## Original Links

- [x] Original Technet URL [Monitor Print Job Status](https://gallery.technet.microsoft.com/5ffb01b1-6a98-46b2-9020-7a2d770a5373)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5ffb01b1-6a98-46b2-9020-7a2d770a5373/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns the job ID, user name, and total pages for each print job on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintJobs =  objWMIService.ExecQuery _
    ("Select * from Win32_PrintJob")

Wscript.Echo "Print Queue, Job ID, Owner, Total Pages"

For Each objPrintJob in colPrintJobs
    strPrinter = Split(objPrintJob.Name,",",-1,1)
    Wscript.Echo strPrinter(0) & ", " & _
        objPrintJob.JobID & ", " &  objPrintJob.Owner & ", " _
            & objPrintJob.TotalPages
Next
```

