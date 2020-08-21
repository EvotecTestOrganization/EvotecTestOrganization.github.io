# Get-PrintStatistics

## Original Links

- [x] Original Technet URL [Get-PrintStatistics](https://gallery.technet.microsoft.com/Get-PrintStatistics-a6bb8323)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Get-PrintStatistics-a6bb8323/description)
- [x] Download: [Download Link](Download\Get-PrintStatistics.ps1)

## Output from Technet Gallery

Get-PrintStatistics queries a print server's event log to gather information about all print jobs. This information includes what each workstation/user has printed, to which printer, how many pages, and how many copies. The reports are output in an easy  to use CSV format.

The PrintService Operational event log must be enabled on the print server to track printing events. This script will only be able to report on information gathered while that log is enabled.

