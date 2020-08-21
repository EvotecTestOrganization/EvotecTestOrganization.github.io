# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/c6020440-e800-4c60-b646-157152553d90)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/c6020440-e800-4c60-b646-157152553d90/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists information about all the printers connected to a print server.

This script was tested using Object REXX 2.1.0 for Microsoft Windows, available from [IBM](http://www.ibm.com/software/ad/obj-rexx/).

Object REXX

```
strComputer = "."
objWMIService = .OLEObject~GetObject("winmgmts:\\"||strComputer||"\root\CIMV2")
do objItem over objWMIService~ExecQuery("Select * from Win32_Printer")
    say "Attributes:" objItem~Attributes
    say "Availability:" objItem~Availability
    z = objItem~AvailableJobSheets
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Average Pages Per Minute:" objItem~AveragePagesPerMinute
    z = objItem~Capabilities
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    z = objItem~CapabilityDescriptions
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Caption:" objItem~Caption
    z = objItem~CharSetsSupported
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Comment:" objItem~Comment
    say "Config Manager Error Code:" objItem~ConfigManagerErrorCode
    say "Config Manager User Config:" objItem~ConfigManagerUserConfig
    say "Creation Class Name:" objItem~CreationClassName
    z = objItem~CurrentCapabilities
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Current Char Set:" objItem~CurrentCharSet
    say "Current Language:" objItem~CurrentLanguage
    say "Current Mime Type:" objItem~CurrentMimeType
    say "Current Natural Language:" objItem~CurrentNaturalLanguage
    say "Curren tPaper Type:" objItem~CurrentPaperType
    say "Default:" objItem~Default
    z = objItem~DefaultCapabilities
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Default Copies:" objItem~DefaultCopies
    say "Default Language:" objItem~DefaultLanguage
    say "Default Mime Type:" objItem~DefaultMimeType
    say "Default Number Up:" objItem~DefaultNumberUp
    say "Default Paper Type:" objItem~DefaultPaperType
    say "Default Priority:" objItem~DefaultPriority
    say "Description:" objItem~Description
    say "Detected Error State:" objItem~DetectedErrorState
    say "Device ID:" objItem~DeviceID
    say "Direct:" objItem~Direct
    say "Do Complete First:" objItem~DoCompleteFirst
    say "Driver Name:" objItem~DriverName
    say "Enable BIDI:" objItem~EnableBIDI
    say "Enable Dev Query Print:" objItem~EnableDevQueryPrint
    say "Error Cleared:" objItem~ErrorCleared
    say "Error Description:" objItem~ErrorDescription
    z = objItem~ErrorInformation
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Extended Detected Error State:" objItem~ExtendedDetectedErrorState
    say "Extended Printer Status:" objItem~ExtendedPrinterStatus
    say "Hidden:" objItem~Hidden
    say "Horizontal Resolution:" objItem~HorizontalResolution
    say "Install Date:" objItem~InstallDate
    say "Job Count Since Last Reset:" objItem~JobCountSinceLastReset
    say "Keep Printed Jobs:" objItem~KeepPrintedJobs
    z = objItem~LanguagesSupported
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Last Error Code:" objItem~LastErrorCode
    say "Local:" objItem~Local
    say "Location:" objItem~Location
    say "Marking Technology:" objItem~MarkingTechnology
    say "Max Copies:" objItem~MaxCopies
    say "Max Number Up:" objItem~MaxNumberUp
    say "Max Size Supported:" objItem~MaxSizeSupported
    z = objItem~MimeTypesSupported
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Name:" objItem~Name
    z = objItem~NaturalLanguagesSupported
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Network:" objItem~Network
    z = objItem~PaperSizesSupported
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    z = objItem~PaperTypesAvailable
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Parameters:" objItem~Parameters
    say "PNP Device ID:" objItem~PNPDeviceID
    say "Port Name:" objItem~PortName
    z = objItem~PowerManagementCapabilities
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Power Management Supported:" objItem~PowerManagementSupported
    z = objItem~PrinterPaperNames
    if .NIL <> z then
        do x over z
            say objProperty.Name ": " x
    end
    say "Printer State:" objItem~PrinterState
    say "Printer Status:" objItem~PrinterStatus
    say "Print Job Data Type:" objItem~PrintJobDataType
    say "Print Processor:" objItem~PrintProcessor
    say "Priority:" objItem~Priority
    say "Published:" objItem~Published
    say "Queued:" objItem~Queued
    say "Raw Only:" objItem~RawOnly
    say "Separator File:" objItem~SeparatorFile
    say "Server Name:" objItem~ServerName
    say "Shared:" objItem~Shared
    say "Share Name:" objItem~ShareName
    say "Spool Enabled:" objItem~SpoolEnabled
    say "Start Time:" objItem~StartTime
    say "Status:" objItem~Status
    say "Status Info:" objItem~StatusInfo
    say "System Creation Class Name:" objItem~SystemCreationClassName
    say "System Name:" objItem~SystemName
    say "Time Of Last Reset:" objItem~TimeOfLastReset
    say "Until Time:" objItem~UntilTime
    say "Vertical Resolution:" objItem~VerticalResolution
    say "Work Offline:" objItem~WorkOffline
end
```

