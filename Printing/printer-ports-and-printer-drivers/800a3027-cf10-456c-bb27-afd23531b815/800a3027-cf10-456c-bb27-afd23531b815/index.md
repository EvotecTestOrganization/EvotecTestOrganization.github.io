# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/800a3027-cf10-456c-bb27-afd23531b815)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/800a3027-cf10-456c-bb27-afd23531b815/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer.

This script was tested using Kixtart 2001 (412) for Microsoft Windows, available from [Kixtart.org](http://www.kixtart.org).

Kixtart

```
$strComputer = "."
$objWMIService = GetObject("winmgmts:\\"+ $strComputer + "\root\cimv2")
$colItems = $objWMIService.ExecQuery("Select * from Win32_PrinterDriver")
For Each $objItem in $colItems
    ? "Caption:" + $objItem.Caption
    ? "Config File:" + $objItem.ConfigFile
    ? "Creation Class Name:" + $objItem.CreationClassName
    ? "DataFile:" + $objItem.DataFile
    ? "Default Data Type:" + $objItem.DefaultDataType
    For Each $x in $objItem.DependentFiles
        ? "Dependent Files:" + $x
    Next
    ? "Description:" + $objItem.Description
    ? "Driver Path:" + $objItem.DriverPath
    ? "File Path:" + $objItem.FilePath
    ? "Help File:" + $objItem.HelpFile
    ? "Inf Name:" + $objItem.InfName
    ? "Install Date:" + $objItem.InstallDate
    ? "Monitor Name:" + $objItem.MonitorName
    ? "Name:" + $objItem.Name
    ? "OEM Url:" + $objItem.OEMUrl
    ? "Started:" + $objItem.Started
    ? "Start Mode:" + $objItem.StartMode
    ? "Status:" + $objItem.Status
    ? "Supported Platform:" + $objItem.SupportedPlatform
    ? "System Creation Class Name:" + $objItem.SystemCreationClassName
    ? "System Name:" + $objItem.SystemName
    ? "Version:" + $objItem.Version
Next
```

