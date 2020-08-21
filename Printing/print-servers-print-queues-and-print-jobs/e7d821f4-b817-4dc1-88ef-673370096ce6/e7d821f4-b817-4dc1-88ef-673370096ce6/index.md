# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/e7d821f4-b817-4dc1-88ef-673370096ce6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/e7d821f4-b817-4dc1-88ef-673370096ce6/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer.

This script was tested using Kixtart 2001 (412) for Microsoft Windows, available from [Kixtart.org](http://www.kixtart.org).

Kixtart

```
$strComputer = "."
$objWMIService = GetObject("winmgmts:\\"+ $strComputer + "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_PrintJob")
For Each $objItem in $colItems
    ? "Caption:" + $objItem.Caption
    ? "Data Type:" + $objItem.DataType
    ? "Description:" + $objItem.Description
    ? "Document:" + $objItem.Document
    ? "Driver Name:" + $objItem.DriverName
    ? "Elapsed Time:" + $objItem.ElapsedTime
    ? "Host Print Queue:" + $objItem.HostPrintQueue
    ? "Install Date:" + $objItem.InstallDate
    ? "Job Id:" + $objItem.JobId
    ? "Job Status:" + $objItem.JobStatus
    ? "Name:" + $objItem.Name
    ? "Notify:" + $objItem.Notify
    ? "Owner:" + $objItem.Owner
    ? "Pages Printed:" + $objItem.PagesPrinted
    ? "Parameters:" + $objItem.Parameters
    ? "Print Processor:" + $objItem.PrintProcessor
    ? "Priority:" + $objItem.Priority
    ? "Size:" + $objItem.Size
    ? "Start Time:" + $objItem.StartTime
    ? "Status:" + $objItem.Status
    ? "Status Mask:" + $objItem.StatusMask
    ? "Time Submitted:" + $objItem.TimeSubmitted
    ? "Total Pages:" + $objItem.TotalPages
    ? "Until Time:" + $objItem.UntilTime
Next
```

