# Script to backup Windows Server 2008R2 Printer configuration.

## Original Links

- [x] Original Technet URL [Script to backup Windows Server 2008R2 Printer configuration.](https://gallery.technet.microsoft.com/Script-to-backup-Windows-fcc24c7b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Script-to-backup-Windows-fcc24c7b/description)
- [x] Download: [Download Link](Download\PrintSvrConBackup.ps1.txt)

## Output from Technet Gallery

This PowerShell script will backup Windows Server printer configuration to a specified location.

1) Create a folder in C:\

2) Delete old printer backup file (Scheduled to run Monthly due to printer configuration changes)

3) Backup printer configuration to a folder in C:\

4) Another job to backup printer backup to a server in HO/ off-site location.

Tested with Windows Server 2008 R2.

