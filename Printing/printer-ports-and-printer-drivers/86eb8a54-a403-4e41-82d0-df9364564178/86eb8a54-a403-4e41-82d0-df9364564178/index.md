# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/86eb8a54-a403-4e41-82d0-df9364564178)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/86eb8a54-a403-4e41-82d0-df9364564178/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer.

This script was tested using Python 2.2.2-224 for Microsoft Windows, available from [ActiveState](http://www.activestate.com).

Python

```
import win32com.client
strComputer = "."
objWMIService = win32com.client.Dispatch("WbemScripting.SWbemLocator")
objSWbemServices = objWMIService.ConnectServer(strComputer,"root\cimv2")
colItems = objSWbemServices.ExecQuery("Select * from Win32_PrinterDriver")
for objItem in colItems:
    print "Caption: ", objItem.Caption
    print "Config File: ", objItem.ConfigFile
    print "Creation Class Name: ", objItem.CreationClassName
    print "Data File: ", objItem.DataFile
    print "Default Data Type: ", objItem.DefaultDataType
    z = objItem.DependentFiles
    if z is None:
        a = 1
    else:
        for x in z:
            print "Dependent Files: ", x
    print "Description: ", objItem.Description
    print "Driver Path: ", objItem.DriverPath
    print "File Path: ", objItem.FilePath
    print "Help File: ", objItem.HelpFile
    print "Inf Name: ", objItem.InfName
    print "Install Date: ", objItem.InstallDate
    print "Monitor Name: ", objItem.MonitorName
    print "Name: ", objItem.Name
    print "OEM Url: ", objItem.OEMUrl
    print "Started: ", objItem.Started
    print "Start Mode: ", objItem.StartMode
    print "Status: ", objItem.Status
    print "Supported Platform: ", objItem.SupportedPlatform
    print "System Creation Class Name: ", objItem.SystemCreationClassName
    print "System Name: ", objItem.SystemName
    print "Version: ", objItem.Version
```

