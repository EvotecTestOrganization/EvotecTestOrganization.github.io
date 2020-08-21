# Install a New Default Printer

## Original Links

- [x] Original Technet URL [Install a New Default Printer](https://gallery.technet.microsoft.com/ea4bcf97-1ada-4f76-9f77-fc8ae0435bda)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ea4bcf97-1ada-4f76-9f77-fc8ae0435bda/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Eric Hanson

Installs a network printer on a workstation and makes that printer the default printer.

Visual Basic

```
on error resume next
Const HKEY_CURRENT_USER = &H80000001
strComputer = "."
strPrinter = "printerName"
strServer = "serverName"

Set netPrinter = CreateObject("WScript.Network") 

UNCpath = "\\" & strServer & "\" & strPrinter
netPrinter.AddWindowsPrinterConnection UNCpath

wscript.sleep 2000
Set objReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & _
    "\root\default:StdRegProv")
strKeyPath = "Software\Microsoft\Windows NT\CurrentVersion\Windows"
strEntryName = "Device"
strValue = "\\" & strServer & "\" & strPrinter & ",winspool,Ne04"
objReg.SetStringValue HKEY_CURRENT_USER, strKeyPath, strEntryName, strValue
```

