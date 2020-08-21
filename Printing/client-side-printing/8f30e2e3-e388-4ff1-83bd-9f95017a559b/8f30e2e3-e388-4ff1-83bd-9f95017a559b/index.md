# Assign a Default Printer Based on Queue Leng

## Original Links

- [x] Original Technet URL [Assign a Default Printer Based on Queue Leng](https://gallery.technet.microsoft.com/8f30e2e3-e388-4ff1-83bd-9f95017a559b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/8f30e2e3-e388-4ff1-83bd-9f95017a559b/description)
- [x] Download: Not available.

## Output from Technet Gallery

Examines all the print queues on a computer, and sets the default printer to the queue with the fewest documents.

Visual Basic

```
intSmallestQueue = 1000

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrintQueues =  objWMIService.ExecQuery _
    ("Select * from Win32_PerfFormattedData_Spooler_PrintQueue " _
        & "Where Name <> '_Total'")

For Each objPrintQueue in colPrintQueues
    intCurrentQueue = objPrintQueue.Jobs + objPrintQueue.JobsSpooling
    If intCurrentQueue <= intSmallestQueue Then
        strNewDefault = objPrintQueue.Name
        intSmallestQueue = intCurrentQueue
    End If
Next

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Name = '" & strNewDefault & "'")

For Each objPrinter in colInstalledPrinters
    objPrinter.SetDefaultPrinter()
Next
```

