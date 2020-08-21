# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/209b4bb5-e9e1-4f55-b104-fb541f90759a)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/209b4bb5-e9e1-4f55-b104-fb541f90759a/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer.

This script was tested using Python 2.2.2-224 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Python

```
import win32com.client
strComputer = "."
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_PrintJob")
for objItem in colItems:
    print "Caption: ", objItem.Caption
    print "Data Type: ", objItem.DataType
    print "Description: ", objItem.Description
    print "Document: ", objItem.Document
    print "Driver Name: ", objItem.DriverName
    print "Elapsed Time: ", objItem.ElapsedTime
    print "Host Print Queue: ", objItem.HostPrintQueue
    print "Install Date: ", objItem.InstallDate
    print "Job Id: ", objItem.JobId
    print "Job Status: ", objItem.JobStatus
    print "Name: ", objItem.Name
    print "Notify: ", objItem.Notify
    print "Owner: ", objItem.Owner
    print "Pages Printed: ", objItem.PagesPrinted
    print "Parameters: ", objItem.Parameters
    print "Print Processor: ", objItem.PrintProcessor
    print "Priority: ", objItem.Priority
    print "Size: ", objItem.Size
    print "Start Time: ", objItem.StartTime
    print "Status: ", objItem.Status
    print "Status Mask: ", objItem.StatusMask
    print "Time Submitted: ", objItem.TimeSubmitted
    print "Total Pages: ", objItem.TotalPages
    print "Until Time: ", objItem.UntilTime
```

