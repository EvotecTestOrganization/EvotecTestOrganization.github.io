# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/5cb483ba-1ca5-4b5f-835d-a972f361b004)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5cb483ba-1ca5-4b5f-835d-a972f361b004/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer.

This script was tested using Object REXX 2.1.0 for Microsoft Windows, available from [IBM](http://www.ibm.com/software/ad/obj-rexx/).

Object REXX

```
strComputer = "."
objWMIService = .OLEObject~GetObject("winmgmts:\\"||strComputer||"\root\CIMV2")
do objItem over objWMIService~ExecQuery("Select * from Win32_PrintJob")
    say "Caption:" objItem~Caption
    say "Data Type:" objItem~DataType
    say "Description:" objItem~Description
    say "Document:" objItem~Document
    say "Driver Name:" objItem~DriverName
    say "Elapsed Time:" objItem~ElapsedTime
    say "Host Print Queue:" objItem~HostPrintQueue
    say "Install Date:" objItem~InstallDate
    say "Job Id:" objItem~JobId
    say "Job Status:" objItem~JobStatus
    say "Name:" objItem~Name
    say "Notify:" objItem~Notify
    say "Owner:" objItem~Owner
    say "Pages Printed:" objItem~PagesPrinted
    say "Parameters:" objItem~Parameters
    say "Print Processor:" objItem~PrintProcessor
    say "Priority:" objItem~Priority
    say "Size:" objItem~Size
    say "Start Time:" objItem~StartTime
    say "Status:" objItem~Status
    say "Status Mask:" objItem~StatusMask
    say "Time Submitted:" objItem~TimeSubmitted
    say "Total Pages:" objItem~TotalPages
    say "Until Time:" objItem~UntilTime
end
```

