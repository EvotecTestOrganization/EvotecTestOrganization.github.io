# Monitor Print Queues

## Original Links

- [x] Original Technet URL [Monitor Print Queues](https://gallery.technet.microsoft.com/7c5e58a6-14bc-481f-9ae7-8b49c56641af)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/7c5e58a6-14bc-481f-9ae7-8b49c56641af/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses cooked performance counters to return the number of jobs currently in each print queue on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintQueues =  objWMIService.ExecQuery _
    ("Select * from Win32_PerfFormattedData_Spooler_PrintQueue " & _
        "Where Name <> '_Total'")

For Each objPrintQueue in colPrintQueues
    Wscript.Echo "Name: " & objPrintQueue.Name
    Wscript.Echo "Current jobs: " & objPrintQueue.Jobs
Next
```

