# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/5bf528c2-367e-4b39-84bf-3d22e7310931)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5bf528c2-367e-4b39-84bf-3d22e7310931/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists information about all the printers connected to a print server.

This script was tested using Python 2.2.2-224 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Python

```
import win32com.client
strComputer = "."
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_Printer")
for objItem in colItems:
    print "Attributes: ", objItem.Attributes
    print "Availability: ", objItem.Availability
    z = objItem.AvailableJobSheets
    if z is None:
        a = 1
    else:
        for x in z:
            print "Available Job Sheets: ", x
    print "Average Pages Per Minute: ", objItem.AveragePagesPerMinute
    z = objItem.Capabilities
    if z is None:
        a = 1
    else:
        for x in z:
            print "Capabilities: ", x
    z = objItem.CapabilityDescriptions
    if z is None:
        a = 1
    else:
        for x in z:
            print "Capability Descriptions: ", x
    print "Caption: ", objItem.Caption
    z = objItem.CharSetsSupported
    if z is None:
        a = 1
    else:
        for x in z:
            print "Char Sets Supported: ", x
    print "Comment: ", objItem.Comment
    print "Config Manager Error Code: ", objItem.ConfigManagerErrorCode
    print "Config Manager User Config: ", objItem.ConfigManagerUserConfig
    print "Creation Class Name: ", objItem.CreationClassName
    z = objItem.CurrentCapabilities
    if z is None:
        a = 1
    else:
        for x in z:
            print "Current Capabilities: ", x
    print "Current Char Set: ", objItem.CurrentCharSet
    print "Current Language: ", objItem.CurrentLanguage
    print "Current Mime Type: ", objItem.CurrentMimeType
    print "Current Natural Language: ", objItem.CurrentNaturalLanguage
    print "Current Paper Type: ", objItem.CurrentPaperType
    print "Default: ", objItem.Default
    z = objItem.DefaultCapabilities
    if z is None:
        a = 1
    else:
        for x in z:
            print "Default Capabilities: ", x
    print "Default Copies: ", objItem.DefaultCopies
    print "Default Language: ", objItem.DefaultLanguage
    print "Default Mime Type: ", objItem.DefaultMimeType
    print "Default Number Up: ", objItem.DefaultNumberUp
    print "Default Paper Type: ", objItem.DefaultPaperType
    print "Default Priority: ", objItem.DefaultPriority
    print "Description: ", objItem.Description
    print "Detected Error State: ", objItem.DetectedErrorState
    print "Device ID: ", objItem.DeviceID
    print "Direct: ", objItem.Direct
    print "Do Complete First: ", objItem.DoCompleteFirst
    print "Driver Name: ", objItem.DriverName
    print "Enable BIDI: ", objItem.EnableBIDI
    print "Enable Dev Query Print: ", objItem.EnableDevQueryPrint
    print "Error Cleared: ", objItem.ErrorCleared
    print "Error Description: ", objItem.ErrorDescription
    z = objItem.ErrorInformation
    if z is None:
        a = 1
    else:
        for x in z:
            print "Error Information: ", x
    print "Extended Detected Error State: ", objItem.ExtendedDetectedErrorState
    print "Extended Printer Status: ", objItem.ExtendedPrinterStatus
    print "Hidden: ", objItem.Hidden
    print "Horizontal Resolution: ", objItem.HorizontalResolution
    print "Install Date: ", objItem.InstallDate
    print "Job Count Since Last Reset: ", objItem.JobCountSinceLastReset
    print "Keep Printed Jobs: ", objItem.KeepPrintedJobs
    z = objItem.LanguagesSupported
    if z is None:
        a = 1
    else:
        for x in z:
            print "Languages Supported: ", x
    print "Last Error Code: ", objItem.LastErrorCode
    print "Local: ", objItem.Local
    print "Location: ", objItem.Location
    print "Marking Technology: ", objItem.MarkingTechnology
    print "Max Copies: ", objItem.MaxCopies
    print "Max Number Up: ", objItem.MaxNumberUp
    print "Max Size Supported: ", objItem.MaxSizeSupported
    z = objItem.MimeTypesSupported
    if z is None:
        a = 1
    else:
        for x in z:
            print "Mime Types Supported: ", x
    print "Name: ", objItem.Name
    z = objItem.NaturalLanguagesSupported
    if z is None:
        a = 1
    else:
        for x in z:
            print "Natural Languages Supported: ", x
    print "Network: ", objItem.Network
    z = objItem.PaperSizesSupported
    if z is None:
        a = 1
    else:
        for x in z:
            print "Paper Sizes Supported: ", x
    z = objItem.PaperTypesAvailable
    if z is None:
        a = 1
    else:
        for x in z:
            print "Paper Types Available: ", x
    print "Parameters: ", objItem.Parameters
    print "PNP Device ID: ", objItem.PNPDeviceID
    print "Port Name: ", objItem.PortName
    z = objItem.PowerManagementCapabilities
    if z is None:
        a = 1
    else:
        for x in z:
            print "Power Management Capabilities: ", x
    print "Power Management Supported: ", objItem.PowerManagementSupported
    z = objItem.PrinterPaperNames
    if z is None:
        a = 1
    else:
        for x in z:
            print "Printer Paper Names: ", x
    print "Printer State: ", objItem.PrinterState
    print "Printer Status: ", objItem.PrinterStatus
    print "Print Job Data Type: ", objItem.PrintJobDataType
    print "Print Processor: ", objItem.PrintProcessor
    print "Priority: ", objItem.Priority
    print "Published: ", objItem.Published
    print "Queued: ", objItem.Queued
    print "Raw Only: ", objItem.RawOnly
    print "Separator File: ", objItem.SeparatorFile
    print "Server Name: ", objItem.ServerName
    print "Shared: ", objItem.Shared
    print "Share Name: ", objItem.ShareName
    print "Spool Enabled: ", objItem.SpoolEnabled
    print "Start Time: ", objItem.StartTime
    print "Status: ", objItem.Status
    print "Status Info: ", objItem.StatusInfo
    print "System Creation Class Name: ", objItem.SystemCreationClassName
    print "System Name: ", objItem.SystemName
    print "Time Of Last Reset: ", objItem.TimeOfLastReset
    print "Until Time: ", objItem.UntilTime
    print "Vertical Resolution: ", objItem.VerticalResolution
    print "Work Offline: ", objItem.WorkOffline
```

