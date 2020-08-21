# Map printer connections based on AD site, department and/or default gateway

## Original Links

- [x] Original Technet URL [Map printer connections based on AD site, department and/or default gateway](https://gallery.technet.microsoft.com/Map-printer-connections-68704bc6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Map-printer-connections-68704bc6/description)
- [x] Download: [Download Link](Download\MapPrinters.vbs)

## Output from Technet Gallery

Map printer connections based on AD site, department and\or default gateway.

The following script could be used as a template to create your own printer mapping login script.

The general logic revolves around mapping the printers based on the Active Directory site your computer reports it's in. For larger sites you could use Department and\or computer default gateways to be more specific. A few example sites have been left in  the script so you can see the various ways you could write this in your own enviroment with locations of varying sizes.

It uses Wscript.Shell's  "LogEvent" method to write an event into the application eventlog with how the script performed: [http://msdn.microsoft.com/en-us/library/b4ce6by3(v=vs.84).aspx](http://msdn.microsoft.com/en-us/library/b4ce6by3%28v=vs.84%29.aspx). This can be useful so you can easily check what the script did (or tried to do), why it did it and how long it took  after the event.

The MapPrinterConnection Sub accepts 3 parameters. These are:

 sPrinter - UNC path to the network printer.

 bDefault - True\False whether you want the printer to be set as default.

 sReason - A string that is passed into the Event description described above.

There are a few other variables in the script that are worth noting. These are described below:

VB Script

```
bOnlyRunOnWorkstations = True
bInteractive = False
bRemoveCurrentNetworkPrinters = True
```

bOnlyRunOnWorkstations

 True\False whether you want the script to only run on workstations or servers as well.

bInteractive

 The event log described above will be echo'd to screen if this is set to true.

bRemoveCurrentNetworkPrinters

 True\False whether you want the script to remove all current network printers before proceeding to map new ones.

 Removing them can be useful if people in your company move between sites a lot and you don't want them accumulating printer connections as they go.

