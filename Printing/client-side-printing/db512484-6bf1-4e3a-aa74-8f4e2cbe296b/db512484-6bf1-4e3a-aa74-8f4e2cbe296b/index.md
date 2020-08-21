# Add a Printer Connection

## Original Links

- [x] Original Technet URL [Add a Printer Connection](https://gallery.technet.microsoft.com/db512484-6bf1-4e3a-aa74-8f4e2cbe296b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/db512484-6bf1-4e3a-aa74-8f4e2cbe296b/description)
- [x] Download: Not available.

## Output from Technet Gallery

Adds a printer connection to a network printer. Script must be run on the local computer.

Visual Basic

```
Set WshNetwork = CreateObject("WScript.Network")

WshNetwork.AddWindowsPrinterConnection "\\PrintServer1\Xerox300"
WshNetwork.SetDefaultPrinter "\\PrintServer1\Xerox300"
```

