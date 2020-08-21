# Delete All Print Jobs

## Original Links

- [x] Original Technet URL [Delete All Print Jobs](https://gallery.technet.microsoft.com/0e89fa7c-a837-4607-b421-c870142e7323)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/0e89fa7c-a837-4607-b421-c870142e7323/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Rob Shannon

Deletes all the print jobs on the local computer.

Visual Basic

```
strComputer = "."

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery("Select * from Win32_Printer")

For Each objPrinter in colInstalledPrinters
    objPrinter.CancelAllJobs()
Next
```

