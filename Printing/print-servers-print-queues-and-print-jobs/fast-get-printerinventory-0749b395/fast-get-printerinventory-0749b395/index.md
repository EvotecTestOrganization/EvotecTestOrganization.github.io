# Fast Get-PrinterInventory

## Original Links

- [x] Original Technet URL [Fast Get-PrinterInventory](https://gallery.technet.microsoft.com/Fast-Get-PrinterInventory-0749b395)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Fast-Get-PrinterInventory-0749b395/description)
- [x] Download: [Download Link](Download\Get-PrinterInventory.ps1)

## Output from Technet Gallery

This is version 2 of the Fast Get-PrinterInventory command.  This now outputs objects to the powershell session and not to Excel as that is not always the best solution.  If you need to export this to Excel as well, pipe the command to export-csv

This script is a modification of the all the current scripts which are floating around to get the printer inventory from print servers.  The issue that I ran into with these is that for our larger client print servers, these took a LONG time to run.   For those print servers with 1000+ ques, a script execution time of six hours or more was not uncommon.  While working on some other scripts, my coworker and I found a way to greatly increase the speed of which print ques were enumerated and how  fast the report was generated.

To execute the script:

```
To run
Basic Example
Get-Printerinventory -computername "TestServer"
Basic Example with multiple servers
Get-Printerinventory -computername "testserver","testserver2"
Basic Example with passing values through the pipeline
"testserver1","testserver2" | get-printerinventory
Example with exporting to CSV file
get-printerinventory "testps01" | Export-csv c:\test.csv -notypeinformation
```

