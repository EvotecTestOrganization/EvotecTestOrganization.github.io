# Save print server settings scrip

## Original Links

- [x] Original Technet URL [Save print server settings scrip](https://gallery.technet.microsoft.com/Save-printer-server-90a75354)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Save-printer-server-90a75354/description)
- [x] Download: [Download Link](Download\SavePrinters.ps1)

## Output from Technet Gallery

Use this script the save printer settings on all shared printers on a print server. Then use the second script, MigratePrinters.ps1 (http://gallery.technet.microsoft.com/scriptcenter/Migrate-printers-script-ab044c5f) to import the printers to a new print server.

Must be run from a Windows 2012/8+ computer with print server role enabled, but can be run against a Windows 2008/Vista+ machine.

When ran, a .csv file will created on the desktop. This file can be updated with Excel to update print driver names if changing drivers, like installing universal drivers or update comments or location information. Remove rows in the spreadsheet to skip the migration of a specific printer and port.

```
[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$SourceComputerName
)
# Gets the shared printers on the machine
$p=get-printer -ComputerName $SourceComputerName|?{$_.Shared -eq $true}
# Saves the printer settings in a CSV file on the current user's desktop
$p|select *|Export-Csv -Path "$env:USERPROFILE\Desktop\printers.csv" -NoTypeInformation
```

