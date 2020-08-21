# Generate report of all printers on print servers

## Original Links

- [x] Original Technet URL [Generate report of all printers on print servers](https://gallery.technet.microsoft.com/Generate-report-of-all-99a4155f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Generate-report-of-all-99a4155f/description)
- [x] Download: [Download Link](Download\ListPrintServer.ps1)

## Output from Technet Gallery

PowerShell Workflow

```
. .\ListPrintServer.ps1
```

This script creates a report of all network-shared printers based off of providing a list of print servers as the input. Excel required. Lists pertinent info relating to printer share. Matches port to the printer IP for easy linking to web site--this feature  works with standard TCP/IP ports but not proprietary ports such as HP propietary or Lexmark propietary, all other info will however populate. (Typically these port types are not needed, Standard TCP/IP often used instead). Provided as-is/no warranty.

