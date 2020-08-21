# List Print Job Information

## Original Links

- [x] Original Technet URL [List Print Job Information](https://gallery.technet.microsoft.com/efc75ee2-8f24-468b-8c9f-36ac8d8ef98e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/efc75ee2-8f24-468b-8c9f-36ac8d8ef98e/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns information for each print job on a computer.

JavaScript

```
var wbemFlagReturnImmediately = 0x10;
var wbemFlagForwardOnly = 0x20;

   var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
   var colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PrintJob", "WQL",
                                          wbemFlagReturnImmediately | wbemFlagForwardOnly);

   var enumItems = new Enumerator(colItems);
   for (; !enumItems.atEnd(); enumItems.moveNext()) {
      var objItem = enumItems.item();

      WScript.Echo("Caption: " + objItem.Caption);
      WScript.Echo("Data Type: " + objItem.DataType);
      WScript.Echo("Description: " + objItem.Description);
      WScript.Echo("Document: " + objItem.Document);
      WScript.Echo("Driver Name: " + objItem.DriverName);
      WScript.Echo("Elapsed Time: " + objItem.ElapsedTime);
      WScript.Echo("Host Print Queue: " + objItem.HostPrintQueue);
      WScript.Echo("Install Date: " + objItem.InstallDate);
      WScript.Echo("Job Id: " + objItem.JobId);
      WScript.Echo("Job Status: " + objItem.JobStatus);
      WScript.Echo("Name: " + objItem.Name);
      WScript.Echo("Notify: " + objItem.Notify);
      WScript.Echo("Owner: " + objItem.Owner);
      WScript.Echo("Pages Printed: " + objItem.PagesPrinted);
      WScript.Echo("Parameters: " + objItem.Parameters);
      WScript.Echo("Print Processor: " + objItem.PrintProcessor);
      WScript.Echo("Priority: " + objItem.Priority);
      WScript.Echo("Size: " + objItem.Size);
      WScript.Echo("Start Time: " + objItem.StartTime);
      WScript.Echo("Status: " + objItem.Status);
      WScript.Echo("Status Mask: " + objItem.StatusMask);
      WScript.Echo("Time Submitted: " + objItem.TimeSubmitted);
      WScript.Echo("Total Pages: " + objItem.TotalPages);
      WScript.Echo("Until Time: " + objItem.UntilTime);
      WScript.Echo();
   }
```

