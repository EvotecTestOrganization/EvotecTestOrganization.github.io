# Delete All Large Print Jobs

## Original Links

- [x] Original Technet URL [Delete All Large Print Jobs](https://gallery.technet.microsoft.com/9b07ec17-a3ae-427d-a417-c95f05fc515f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/9b07ec17-a3ae-427d-a417-c95f05fc515f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes all print jobs larger than 1 megabyte.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintJobs =  objWMIService.ExecQuery _
    ("Select * from Win32_PrintJob Where Size > 1000000")

For Each objPrintJob in colPrintJobs 
    objPrintJob.Delete_
Next
```

