# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/4c6560bd-917f-4090-9d8c-052378ea7e6c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/4c6560bd-917f-4090-9d8c-052378ea7e6c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists information about all the printers connected to a print server.

This script was tested using Kixtart 2001 (412) for Microsoft Windows, available from [Kixtart.org](http://www.kixtart.org).

Kixtart

```
$strComputer = "."
$objWMIService = GetObject("winmgmts:\\"+ $strComputer + "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_Printer")
For Each $objItem in $colItems
    ? "Attributes:" + $objItem.Attributes
    ? "Availability:" + $objItem.Availability
    For Each $x in $objItem.AvailableJobSheets
        ? "Available Job Sheets:" + $x
    Next
    ? "AveragePagesPerMinute:" + $objItem.AveragePagesPerMinute
    For Each $x in $objItem.Capabilities
        ? "Capabilities:" + $x
    Next
    For Each $x in $objItem.CapabilityDescriptions
        ? "Capability Descriptions:" + $x
    Next
    ? "Caption:" + $objItem.Caption
    For Each $x in $objItem.CharSetsSupported
        ? "Char Sets Supported:" + $x
    Next
    ? "Comment:" + $objItem.Comment
    ? "Config Manager Error Code:" + $objItem.ConfigManagerErrorCode
    ? "Config Manager User Config:" + $objItem.ConfigManagerUserConfig
    ? "Creation Class Name:" + $objItem.CreationClassName
    For Each $x in $objItem.CurrentCapabilities
        ? "Current Capabilities:" + $x
    Next
    ? "Current Char Set:" + $objItem.CurrentCharSet
    ? "Current Language:" + $objItem.CurrentLanguage
    ? "Current Mime Type:" + $objItem.CurrentMimeType
    ? "Current Natural Language:" + $objItem.CurrentNaturalLanguage
    ? "Current Paper Type:" + $objItem.CurrentPaperType
    ? "Default:" + $objItem.Default
    For Each $x in $objItem.DefaultCapabilities
        ? "Default Capabilities:" + $x
    Next
    ? "Default Copies:" + $objItem.DefaultCopies
    ? "Default Language:" + $objItem.DefaultLanguage
    ? "Default Mime Type:" + $objItem.DefaultMimeType
    ? "Default Number Up:" + $objItem.DefaultNumberUp
    ? "Default Paper Type:" + $objItem.DefaultPaperType
    ? "Default Priority:" + $objItem.DefaultPriority
    ? "Description:" + $objItem.Description
    ? "Detected Error State:" + $objItem.DetectedErrorState
    ? "Device ID:" + $objItem.DeviceID
    ? "Direct:" + $objItem.Direct
    ? "Do Complete First:" + $objItem.DoCompleteFirst
    ? "Driver Name:" + $objItem.DriverName
    ? "Enable BIDI:" + $objItem.EnableBIDI
    ? "Enable Dev Query Print:" + $objItem.EnableDevQueryPrint
    ? "Error Cleared:" + $objItem.ErrorCleared
    ? "Error Description:" + $objItem.ErrorDescription
    For Each $x in $objItem.ErrorInformation
        ? "Error Information:" + $x
    Next
    ? "Extended Detected Error State:" + $objItem.ExtendedDetectedErrorState
    ? "Extended Printer Status:" + $objItem.ExtendedPrinterStatus
    ? "Hidden:" + $objItem.Hidden
    ? "Horizontal Resolution:" + $objItem.HorizontalResolution
    ? "Install Date:" + $objItem.InstallDate
    ? "Job Count Since Last Reset:" + $objItem.JobCountSinceLastReset
    ? "Keep Printed Jobs:" + $objItem.KeepPrintedJobs
    For Each $x in $objItem.LanguagesSupported
        ? "Languages Supported:" + $x
    Next
    ? "Last Error Code:" + $objItem.LastErrorCode
    ? "Local:" + $objItem.Local
    ? "Location:" + $objItem.Location
    ? "Marking Technology:" + $objItem.MarkingTechnology
    ? "Max Copies:" + $objItem.MaxCopies
    ? "Max Number Up:" + $objItem.MaxNumberUp
    ? "Max Size Supported:" + $objItem.MaxSizeSupported
    For Each $x in $objItem.MimeTypesSupported
        ? "Mime Types Supported:" + $x
    Next
    ? "Name:" + $objItem.Name
    For Each $x in $objItem.NaturalLanguagesSupported
        ? "Natural Languages Supported:" + $x
    Next
    ? "Network:" + $objItem.Network
    For Each $x in $objItem.PaperSizesSupported
        ? "Paper Sizes Supported:" + $x
    Next
    For Each $x in $objItem.PaperTypesAvailable
        ? "Paper Types Available:" + $x
    Next
    ? "Parameters:" + $objItem.Parameters
    ? "PNP Device ID:" + $objItem.PNPDeviceID
    ? "Port Name:" + $objItem.PortName
    For Each $x in $objItem.PowerManagementCapabilities
        ? "Power Management Capabilities:" + $x
    Next
    ? "Power Management Supported:" + $objItem.PowerManagementSupported
    For Each $x in $objItem.PrinterPaperNames
        ? "Printer Paper Names:" + $x
    Next
    ? "Printer State:" + $objItem.PrinterState
    ? "Printer Status:" + $objItem.PrinterStatus
    ? "Print Job Data Type:" + $objItem.PrintJobDataType
    ? "Print Processor:" + $objItem.PrintProcessor
    ? "Priority:" + $objItem.Priority
    ? "Published:" + $objItem.Published
    ? "Queued:" + $objItem.Queued
    ? "Raw Only:" + $objItem.RawOnly
    ? "Separator File:" + $objItem.SeparatorFile
    ? "Server Name:" + $objItem.ServerName
    ? "Shared:" + $objItem.Shared
    ? "Share Name:" + $objItem.ShareName
    ? "Spool Enabled:" + $objItem.SpoolEnabled
    ? "Start Time:" + $objItem.StartTime
    ? "Status:" + $objItem.Status
    ? "Status Info:" + $objItem.StatusInfo
    ? "System Creation Class Name:" + $objItem.SystemCreationClassName
    ? "System Name:" + $objItem.SystemName
    ? "Time Of Last Reset:" + $objItem.TimeOfLastReset
    ? "Until Time:" + $objItem.UntilTime
    ? "Vertical Resolution:" + $objItem.VerticalResolution
    ? "Work Offline:" + $objItem.WorkOffline
Next
```

