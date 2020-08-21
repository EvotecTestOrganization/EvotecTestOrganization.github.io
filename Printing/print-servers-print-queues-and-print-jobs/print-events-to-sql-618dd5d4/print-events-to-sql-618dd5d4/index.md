# Print Events to SQL

## Original Links

- [x] Original Technet URL [Print Events to SQL](https://gallery.technet.microsoft.com/Print-Events-to-SQL-618dd5d4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Print-Events-to-SQL-618dd5d4/description)
- [x] Download: [Download Link](Download\PrintingAuditToSQL.zip)

## Output from Technet Gallery

## Brief Description

This is a PowerShell script designed to be run on a scheduled basis to extract print job accounting reports from the Windows PrintService Event log into a SQL database. This has only been tested on Windows Server 2008 R2 SP1 print servers.

The script idea originated from the[VB script or PowerShell script for auditing Win2k8 Print server](https://social.technet.microsoft.com/Forums/en-US/ITCG/thread/007be664-1d8d-461c-9e0b-d8177106d4f8) thread. It was then enhanced over several  iterations:

- Event details are parsed via XML instead of RegEx so all portions of the fields are captured.

- Only events since the last retrieval are fetched for improved performance.

- Script runs with IDLE cpu priority as to not interfere with other server operations (such as Print Server processes).

- Events are stored into a basic SQL database which opens numerous possibilities for reporting, etc.

- User names are resolved using native Windows translation, instead of expensive Active Directory lookup calls.

## Release Notes:

1.1 - Released as zip file which contains PowerShell script and SQL table schema.

1.0 - Initial public release

