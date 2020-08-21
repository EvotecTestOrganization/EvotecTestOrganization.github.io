# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/List-Printer-Information-99f2b96d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/List-Printer-Information-99f2b96d/description)
- [x] Download: [Download Link](Download\ListPrinters.py)

## Output from Technet Gallery

Lists information about all the printers installed on a machine. The script requires python win32APIs to be installed. win32API is by default available in active state python distribution. win32API for standard python installations can be downloaded from  http://sourceforge.net/projects/pywin32/. The script works on python 2.x. It needs little modifications before it can be used with python 3.

Python

```
strComputer = "."
import win32com.client
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_Printer")
for objItem in colItems:
      print "Attributes: " ,objItem.Attributes
      print "Availability: " ,objItem.Availability
      print "Available Job Sheets: " ,objItem.AvailableJobSheets
      print "Average Pages Per Minute: " ,objItem.AveragePagesPerMinute
      print "Capabilities: " ,objItem.Capabilities
      print "Capability Descriptions: " ,objItem.CapabilityDescriptions
      print "Caption: " ,objItem.Caption
      print "Character Sets Supported: " ,objItem.CharSetsSupported
      print "Comment: " ,objItem.Comment
      print "Configuration Manager Error Code: " ,objItem.ConfigManagerErrorCode
      print "Configuration Manager User Configuration: " ,objItem.ConfigManagerUserConfig
      print "Creation Class Name: " ,objItem.CreationClassName
      print "Current Capabilities: " ,objItem.CurrentCapabilities
      print "Current Character Set: " ,objItem.CurrentCharSet
      print "Current Language: " ,objItem.CurrentLanguage
      print "Current MIME Type: " ,objItem.CurrentMimeType
      print "Current Natural Language: " ,objItem.CurrentNaturalLanguage
      print "Current Paper Type: " ,objItem.CurrentPaperType
      print "Default: " ,objItem.Default
      print "Default Capabilities: " ,objItem.DefaultCapabilities
      print "Default Copies: " ,objItem.DefaultCopies
      print "Default Language: " ,objItem.DefaultLanguage
      print "Default MIME Type: " ,objItem.DefaultMimeType
      print "Default Number Up: " ,objItem.DefaultNumberUp
      print "Default Paper Type: " ,objItem.DefaultPaperType
      print "Default Priority: " ,objItem.DefaultPriority
      print "Description: " ,objItem.Description
      print "Detected Error State: " ,objItem.DetectedErrorState
      print "Device ID: " ,objItem.DeviceID
      print "Direct: " ,objItem.Direct
      print "Do Complete First: " ,objItem.DoCompleteFirst
      print "Driver Name: " ,objItem.DriverName
      print "Enable BIDI: " ,objItem.EnableBIDI
      print "Enable Device Query Print: " ,objItem.EnableDevQueryPrint
      print "Error Cleared: " ,objItem.ErrorCleared
      print "Error Description: " ,objItem.ErrorDescription
      print "Error Information: " ,objItem.ErrorInformation
      print "Extended Detected Error State: " ,objItem.ExtendedDetectedErrorState
      print "Extended Printer Status: " ,objItem.ExtendedPrinterStatus
      print "Hidden: " ,objItem.Hidden
      print "Horizontal Resolution: " ,objItem.HorizontalResolution
      print "Installation Date: " ,objItem.InstallDate
      print "Job Count Since Last Reset: " ,objItem.JobCountSinceLastReset
      print "Keep Printed Jobs: " ,objItem.KeepPrintedJobs
      print "Languages Supported: " ,objItem.LanguagesSupported
      print "Last Error Code: " ,objItem.LastErrorCode
      print "Local: " ,objItem.Local
      print "Location: " ,objItem.Location
      print "Marking Technology: " ,objItem.MarkingTechnology
      print "Maximum Copies: " ,objItem.MaxCopies
      print "Maximum Number Up: " ,objItem.MaxNumberUp
      print "Maximum Size Supported: " ,objItem.MaxSizeSupported
      print "MIME Types Supported: " ,objItem.MimeTypesSupported
      print "Name: " ,objItem.Name
      print "Natural Languages Supported: " ,objItem.NaturalLanguagesSupported
      print "Network: " ,objItem.Network
      print "Paper Sizes Supported: " ,objItem.PaperSizesSupported
      print "Paper Types Available: " ,objItem.PaperTypesAvailable
      print "Parameters: " ,objItem.Parameters
      print "PNP Device ID: " ,objItem.PNPDeviceID
      print "Port Name: " ,objItem.PortName
      print "Power Management Capabilities: " ,objItem.PowerManagementCapabilities
      print "Power Management Supported: " ,objItem.PowerManagementSupported
      print "Printer Paper Names: " ,objItem.PrinterPaperNames
      print "Printer State: " ,objItem.PrinterState
      print "Printer Status: " ,objItem.PrinterStatus
      print "Print Job Data Type: " ,objItem.PrintJobDataType
      print "Print Processor: " ,objItem.PrintProcessor
      print "Priority: " ,objItem.Priority
      print "Published: " ,objItem.Published
      print "Queued: " ,objItem.Queued
      print "Raw-Only: " ,objItem.RawOnly
      print "Separator File: " ,objItem.SeparatorFile
      print "Server Name: " ,objItem.ServerName
      print "Shared: " ,objItem.Shared
      print "Share Name: " ,objItem.ShareName
      print "Spool Enabled: " ,objItem.SpoolEnabled
      print "Start Time: " ,objItem.StartTime
      print "Status: " ,objItem.Status
      print "Status Information: " ,objItem.StatusInfo
      print "System Creation Class Name: " ,objItem.SystemCreationClassName
      print "System Name: " ,objItem.SystemName
      print "Time Of Last Reset: " ,objItem.TimeOfLastReset
      print "Until Time: " ,objItem.UntilTime
      print "Vertical Resolution: " ,objItem.VerticalResolution
      print "Work Offline: " ,objItem.WorkOffline
      print
```

