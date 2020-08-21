# Migrate print server scrip

## Original Links

- [x] Original Technet URL [Migrate print server scrip](https://gallery.technet.microsoft.com/Migrate-printers-script-ab044c5f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Migrate-printers-script-ab044c5f/description)
- [x] Download: [Download Link](Download\MigratePrinters.ps1)

## Output from Technet Gallery

Uses the output of another script, SavePrinters.ps1(http://gallery.technet.microsoft.com/scriptcenter/Save-printer-server-90a75354), also in the script gallery in my profile to migrate the saved printers to a new print server.

Will create printers on the destination based on the .csv file information saved from SavePrinters.ps1 script. Will query the source print server for port information and create new TCP/IP ports on the destination server.

Before running script, install the same drivers on the destination server as are installed on the source, or install new drivers and update the driver names in the .csv file prior to importing.

Must be ran on Windows 2012/8+ as an administrator. Source computer must be Windows 2008/Vista+.

```
[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$SourceComputerName,
[Parameter(Mandatory=$True)]
[string]$DestinationComputerName
)
# Gets the settings for printers from a saved CSV file on the current user's desktop
$printers= import-csv "$env:USERPROFILE\desktop\printers.csv"
# cycles through the printers and queries the source computer to match the port specified in the CSV file. Creates the port and printer on the destination server
foreach ($printer in $printers) {
    $port=get-printerport -ComputerName $SourceComputerName|? {$_.Name -eq $printer.PortName}
    Add-PrinterPort -ComputerName $DestinationComputerName -Name $port.Name -PrinterHostAddress $port.PrinterHostAddress
    Add-Printer -ComputerName $DestinationComputerName -Name $printer.Name -DriverName $printer.DriverName -PortName $printer.PortName -Comment $printer.Comment -ShareName $printer.ShareName
    [boolean]$shared=[System.Convert]::ToBoolean($printer.Shared)
    [boolean]$published=[System.Convert]::ToBoolean($printer.Published)
    Set-printer -ComputerName $DestinationComputerName -Name $printer.Name -Shared $shared -Published $published
```

