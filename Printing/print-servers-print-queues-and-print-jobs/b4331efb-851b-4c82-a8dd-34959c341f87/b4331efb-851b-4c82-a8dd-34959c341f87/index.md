# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/b4331efb-851b-4c82-a8dd-34959c341f87)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/b4331efb-851b-4c82-a8dd-34959c341f87/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists information about all the printers connected to a print server.

JavaScript

```
var wbemFlagReturnImmediately = 0x10;
var wbemFlagForwardOnly = 0x20;

   var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
   var colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Printer", "WQL",
                                          wbemFlagReturnImmediately | wbemFlagForwardOnly);

   var enumItems = new Enumerator(colItems);
   for (; !enumItems.atEnd(); enumItems.moveNext()) {
      var objItem = enumItems.item();

      WScript.Echo("Attributes: " + objItem.Attributes);
      WScript.Echo("Availability: " + objItem.Availability);
      try { WScript.Echo("Available Job Sheets: " + 
         (objItem.AvailableJobSheets.toArray()).join(",")); }
         catch(e) { WScript.Echo("Available Job Sheets: null"); }
      WScript.Echo("Average Pages Per Minute: " + objItem.AveragePagesPerMinute);
      try { WScript.Echo("Capabilities: " + (objItem.Capabilities.toArray()).join(",")); }
         catch(e) { WScript.Echo("Capabilities: null"); }
      try { WScript.Echo("Capability Descriptions: " + 
         (objItem.CapabilityDescriptions.toArray()).join(",")); }
         catch(e) { WScript.Echo("Capability Descriptions: null"); }
      WScript.Echo("Caption: " + objItem.Caption);
      try { WScript.Echo("Char Sets Supported: " + 
         (objItem.CharSetsSupported.toArray()).join(",")); }
         catch(e) { WScript.Echo("CharSetsSupported: null"); }
      WScript.Echo("Comment: " + objItem.Comment);
      WScript.Echo("Config Manager Error Code: " + objItem.ConfigManagerErrorCode);
      WScript.Echo("Config Manager User Config: " + objItem.ConfigManagerUserConfig);
      WScript.Echo("Creation Class Name: " + objItem.CreationClassName);
      try { WScript.Echo("Current Capabilities: " + 
         (objItem.CurrentCapabilities.toArray()).join(",")); }
         catch(e) { WScript.Echo("Current Capabilities: null"); }
      WScript.Echo("Current Char Set: " + objItem.CurrentCharSet);
      WScript.Echo("Current Language: " + objItem.CurrentLanguage);
      WScript.Echo("Current Mime Type: " + objItem.CurrentMimeType);
      WScript.Echo("Current Natural Language: " + objItem.CurrentNaturalLanguage);
      WScript.Echo("Current Paper Type: " + objItem.CurrentPaperType);
      WScript.Echo("Default: " + objItem.Default);
      try { WScript.Echo("Default Capabilities: " + 
         (objItem.DefaultCapabilities.toArray()).join(",")); }
         catch(e) { WScript.Echo("Default Capabilities: null"); }
      WScript.Echo("Default Copies: " + objItem.DefaultCopies);
      WScript.Echo("Default Language: " + objItem.DefaultLanguage);
      WScript.Echo("Default Mime Type: " + objItem.DefaultMimeType);
      WScript.Echo("Default Number Up: " + objItem.DefaultNumberUp);
      WScript.Echo("Default Paper Type: " + objItem.DefaultPaperType);
      WScript.Echo("Default Priority: " + objItem.DefaultPriority);
      WScript.Echo("Description: " + objItem.Description);
      WScript.Echo("Detected Error State: " + objItem.DetectedErrorState);
      WScript.Echo("Device ID: " + objItem.DeviceID);
      WScript.Echo("Direct: " + objItem.Direct);
      WScript.Echo("Do Complete First: " + objItem.DoCompleteFirst);
      WScript.Echo("Driver Name: " + objItem.DriverName);
      WScript.Echo("Enable BIDI: " + objItem.EnableBIDI);
      WScript.Echo("Enable Dev Query Print: " + objItem.EnableDevQueryPrint);
      WScript.Echo("Error Cleared: " + objItem.ErrorCleared);
      WScript.Echo("Error Description: " + objItem.ErrorDescription);
      try { WScript.Echo("Error Information: " + (objItem.ErrorInformation.toArray()).join(",")); }
         catch(e) { WScript.Echo("Error Information: null"); }
      WScript.Echo("Extended Detected Error State: " + objItem.ExtendedDetectedErrorState);
      WScript.Echo("Extended Printer Status: " + objItem.ExtendedPrinterStatus);
      WScript.Echo("Hidden: " + objItem.Hidden);
      WScript.Echo("Horizontal Resolution: " + objItem.HorizontalResolution);
      WScript.Echo("Install Date: " + objItem.InstallDate);
      WScript.Echo("Job Count Since Last Reset: " + objItem.JobCountSinceLastReset);
      WScript.Echo("Keep Printed Jobs: " + objItem.KeepPrintedJobs);
      try { WScript.Echo("Languages Supported: " + 
         (objItem.LanguagesSupported.toArray()).join(",")); }
         catch(e) { WScript.Echo("Languages Supported: null"); }
      WScript.Echo("Last Error Code: " + objItem.LastErrorCode);
      WScript.Echo("Local: " + objItem.Local);
      WScript.Echo("Location: " + objItem.Location);
      WScript.Echo("Marking Technology: " + objItem.MarkingTechnology);
      WScript.Echo("Max Copies: " + objItem.MaxCopies);
      WScript.Echo("Max Number Up: " + objItem.MaxNumberUp);
      WScript.Echo("Max Size Supported: " + objItem.MaxSizeSupported);
      try { WScript.Echo("Mime Types Supported: " + 
         (objItem.MimeTypesSupported.toArray()).join(",")); }
         catch(e) { WScript.Echo("Mime Types Supported: null"); }
      WScript.Echo("Name: " + objItem.Name);
      try { WScript.Echo("Natural Languages Supported: " + 
         (objItem.NaturalLanguagesSupported.toArray()).join(",")); }
         catch(e) { WScript.Echo("Natural Languages Supported: null"); }
      WScript.Echo("Network: " + objItem.Network);
      try { WScript.Echo("Paper Sizes Supported: " + 
         (objItem.PaperSizesSupported.toArray()).join(",")); }
         catch(e) { WScript.Echo("Paper Sizes Supported: null"); }
      try { WScript.Echo("Paper Types Available: " + 
         (objItem.PaperTypesAvailable.toArray()).join(",")); }
         catch(e) { WScript.Echo("Paper Types Available: null"); }
      WScript.Echo("Parameters: " + objItem.Parameters);
      WScript.Echo("PNP Device ID: " + objItem.PNPDeviceID);
      WScript.Echo("Port Name: " + objItem.PortName);
      try { WScript.Echo("Power Management Capabilities: " + 
         (objItem.PowerManagementCapabilities.toArray()).join(",")); }
         catch(e) { WScript.Echo("Power Management Capabilities: null"); }
      WScript.Echo("Power Management Supported: " + objItem.PowerManagementSupported);
      try { WScript.Echo("Printer Paper Names: " + 
         (objItem.PrinterPaperNames.toArray()).join(",")); }
         catch(e) { WScript.Echo("Printer Paper Names: null"); }
      WScript.Echo("Printer State: " + objItem.PrinterState);
      WScript.Echo("Printer Status: " + objItem.PrinterStatus);
      WScript.Echo("Print Job Data Type: " + objItem.PrintJobDataType);
      WScript.Echo("Print Processor: " + objItem.PrintProcessor);
      WScript.Echo("Priority: " + objItem.Priority);
      WScript.Echo("Published: " + objItem.Published);
      WScript.Echo("Queued: " + objItem.Queued);
      WScript.Echo("Raw Only: " + objItem.RawOnly);
      WScript.Echo("Separator File: " + objItem.SeparatorFile);
      WScript.Echo("Server Name: " + objItem.ServerName);
      WScript.Echo("Shared: " + objItem.Shared);
      WScript.Echo("Share Name: " + objItem.ShareName);
      WScript.Echo("Spool Enabled: " + objItem.SpoolEnabled);
      WScript.Echo("Start Time: " + objItem.StartTime);
      WScript.Echo("Status: " + objItem.Status);
      WScript.Echo("Status Info: " + objItem.StatusInfo);
      WScript.Echo("System Creation Class Name: " + objItem.SystemCreationClassName);
      WScript.Echo("System Name: " + objItem.SystemName);
      WScript.Echo("Time Of Last Reset: " + objItem.TimeOfLastReset);
      WScript.Echo("Until Time: " + objItem.UntilTime);
      WScript.Echo("Vertical Resolution: " + objItem.VerticalResolution);
      WScript.Echo("Work Offline: " + objItem.WorkOffline);
      WScript.Echo();
   }
```

