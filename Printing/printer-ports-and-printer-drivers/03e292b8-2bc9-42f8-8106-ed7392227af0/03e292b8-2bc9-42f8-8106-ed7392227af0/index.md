# List Printer Drivers

## Original Links

- [x] Original Technet URL [List Printer Drivers](https://gallery.technet.microsoft.com/03e292b8-2bc9-42f8-8106-ed7392227af0)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/03e292b8-2bc9-42f8-8106-ed7392227af0/description)
- [x] Download: Not available.

## Output from Technet Gallery

Lists all the printer drivers that have been installed on a computer.

JavaScript

```
var wbemFlagReturnImmediately = 0x10;
var wbemFlagForwardOnly = 0x20;

   var objWMIService = GetObject("winmgmts:\\\\.\\root\\CIMV2");
   var colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PrinterDriver", "WQL",
                                          wbemFlagReturnImmediately | wbemFlagForwardOnly);

   var enumItems = new Enumerator(colItems);
   for (; !enumItems.atEnd(); enumItems.moveNext()) {
      var objItem = enumItems.item();

      WScript.Echo("Caption: " + objItem.Caption);
      WScript.Echo("Config File: " + objItem.ConfigFile);
      WScript.Echo("Creation Class Name: " + objItem.CreationClassName);
      WScript.Echo("Data File: " + objItem.DataFile);
      WScript.Echo("Default Data Type: " + objItem.DefaultDataType);
      try { WScript.Echo("DependentFiles: " + (objItem.DependentFiles.toArray()).join(",")); }
         catch(e) { WScript.Echo("DependentFiles: null"); }
      WScript.Echo("Description: " + objItem.Description);
      WScript.Echo("Driver Path: " + objItem.DriverPath);
      WScript.Echo("File Path: " + objItem.FilePath);
      WScript.Echo("Help File: " + objItem.HelpFile);
      WScript.Echo("Inf Name: " + objItem.InfName);
      WScript.Echo("Install Date: " + objItem.InstallDate);
      WScript.Echo("Monitor Name: " + objItem.MonitorName);
      WScript.Echo("Name: " + objItem.Name);
      WScript.Echo("OEM Url: " + objItem.OEMUrl);
      WScript.Echo("Started: " + objItem.Started);
      WScript.Echo("Start Mode: " + objItem.StartMode);
      WScript.Echo("Status: " + objItem.Status);
      WScript.Echo("Supported Platform: " + objItem.SupportedPlatform);
      WScript.Echo("System Creation Class Name: " + objItem.SystemCreationClassName);
      WScript.Echo("System Name: " + objItem.SystemName);
      WScript.Echo("Version: " + objItem.Version);
      WScript.Echo();
   }
```

