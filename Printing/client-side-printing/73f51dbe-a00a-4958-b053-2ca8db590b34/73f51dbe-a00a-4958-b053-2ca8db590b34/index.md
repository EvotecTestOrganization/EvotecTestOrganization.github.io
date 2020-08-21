# Delete a Printer Connection

## Original Links

- [x] Original Technet URL [Delete a Printer Connection](https://gallery.technet.microsoft.com/73f51dbe-a00a-4958-b053-2ca8db590b34)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/73f51dbe-a00a-4958-b053-2ca8db590b34/description)
- [x] Download: Not available.

## Output from Technet Gallery

Removes a printer connection to a network printer. Script must be run on the local computer.

Visual Basic

```
Set objNetwork = WScript.CreateObject("WScript.Network")
objNetwork.RemovePrinterConnection "\\PrintServer\xerox3006"
```

