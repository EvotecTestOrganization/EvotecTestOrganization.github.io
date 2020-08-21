# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/21c354e5-c52a-45f5-99c7-12199ad52443)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/21c354e5-c52a-45f5-99c7-12199ad52443/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer. This script requires both Windows PowerShell and the corresponding version of the .NET Framework. For more information on downloading these items see the Windows PowerShell download page (right).

```
$strComputer = "."

$colItems = get-wmiobject -class "Win32_PrintJob" -namespace "root\CIMV2" `
-computername $strComputer

foreach ($objItem in $colItems) {
      write-host "Caption: " $objItem.Caption
      write-host "Data Type: " $objItem.DataType
      write-host "Description: " $objItem.Description
      write-host "Document: " $objItem.Document
      write-host "Driver Name: " $objItem.DriverName
      write-host "Elapsed Time: " $objItem.ElapsedTime
      write-host "Host Print Queue: " $objItem.HostPrintQueue
      write-host "Installation Date: " $objItem.InstallDate
      write-host "Job ID: " $objItem.JobId
      write-host "Job Status: " $objItem.JobStatus
      write-host "Name: " $objItem.Name
      write-host "Notify: " $objItem.Notify
      write-host "Owner: " $objItem.Owner
      write-host "Pages Printed: " $objItem.PagesPrinted
      write-host "Parameters: " $objItem.Parameters
      write-host "Print Processor: " $objItem.PrintProcessor
      write-host "Priority: " $objItem.Priority
      write-host "Size: " $objItem.Size
      write-host "Start Time: " $objItem.StartTime
      write-host "Status: " $objItem.Status
      write-host "Status Mask: " $objItem.StatusMask
      write-host "Time Submitted: " $objItem.TimeSubmitted
      write-host "Total Pages: " $objItem.TotalPages
      write-host "Until Time: " $objItem.UntilTime
      write-host
}
```

