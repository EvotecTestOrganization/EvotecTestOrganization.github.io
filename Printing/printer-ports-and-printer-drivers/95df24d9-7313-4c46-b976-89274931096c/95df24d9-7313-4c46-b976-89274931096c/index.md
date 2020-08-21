# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/95df24d9-7313-4c46-b976-89274931096c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/95df24d9-7313-4c46-b976-89274931096c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer. This script requires both Windows PowerShell and the corresponding version of the .NET Framework. For more information on downloading these items see the Windows PowerShell download page  (right).

```
$strComputer = "."

$colItems = get-wmiobject -class "Win32_PrinterDriver" -namespace "root\CIMV2" `
-computername $strComputer

foreach ($objItem in $colItems) {
      write-host "Caption: " $objItem.Caption
      write-host "Configuration File: " $objItem.ConfigFile
      write-host "Creation Class Name: " $objItem.CreationClassName
      write-host "Data File: " $objItem.DataFile
      write-host "Default Data Type: " $objItem.DefaultDataType
      write-host "Dependent Files: " $objItem.DependentFiles
      write-host "Description: " $objItem.Description
      write-host "Driver Path: " $objItem.DriverPath
      write-host "File Path: " $objItem.FilePath
      write-host "Help File: " $objItem.HelpFile
      write-host "Inf Name: " $objItem.InfName
      write-host "Installation Date: " $objItem.InstallDate
      write-host "Monitor Name: " $objItem.MonitorName
      write-host "Name: " $objItem.Name
      write-host "OEM Url: " $objItem.OEMUrl
      write-host "Started: " $objItem.Started
      write-host "Start Mode: " $objItem.StartMode
      write-host "Status: " $objItem.Status
      write-host "Supported Platform: " $objItem.SupportedPlatform
      write-host "System Creation Class Name: " $objItem.SystemCreationClassName
      write-host "System Name: " $objItem.SystemName
      write-host "Version: " $objItem.Version
      write-host
}
```

