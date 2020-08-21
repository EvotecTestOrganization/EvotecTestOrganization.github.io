# Save printer information script
# Chad Schultz - chad.a@microsoft.com Microsoft PFE
# Saves shared printer settings from a 2008+ server and writes the settings to a CSV file on the desktop. This CSV file can be used to import with another script, MigratePrinters.ps1 also found in the script gallery.

[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$SourceComputerName
)

# Gets the shared printers on the machine
$p=get-printer -ComputerName $SourceComputerName|?{$_.Shared -eq $true}

# Saves the printer settings in a CSV file on the current user's desktop
$p|select *|Export-Csv -Path "$env:USERPROFILE\Desktop\printers.csv" -NoTypeInformation