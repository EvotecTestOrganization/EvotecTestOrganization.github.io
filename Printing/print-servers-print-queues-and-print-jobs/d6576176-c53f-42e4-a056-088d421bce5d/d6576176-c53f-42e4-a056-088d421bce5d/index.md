# Resume All Print Jobs

## Original Links

- [x] Original Technet URL [Resume All Print Jobs](https://gallery.technet.microsoft.com/d6576176-c53f-42e4-a056-088d421bce5d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/d6576176-c53f-42e4-a056-088d421bce5d/description)
- [x] Download: Not available.

## Output from Technet Gallery

Resumes all the print jobs on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintJobs =  objWMIService.ExecQuery _
    ("Select * from Win32_PrintJob")

For Each objPrintJob in colPrintJobs 
    objPrintJob.Resume
Next
```

