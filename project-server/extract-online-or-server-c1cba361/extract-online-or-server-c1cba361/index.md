# Extract Project Online or Project Server 2013 / 2016 Timesheet data

## Original Links

- [x] Original Technet URL [Extract Project Online or Project Server 2013 / 2016 Timesheet data](https://gallery.technet.microsoft.com/Extract-Online-or-Server-c1cba361)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Extract-Online-or-Server-c1cba361/description)
- [x] Download: [Download Link](Download\ExtractTimesheetDatafromProjectOdataAPI.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project Reporting OData API to extract the timesheet data between the given start and end dates. The user running the script specifies the source PWA instance URL, Username and password. They then enter the start and finish  dates in yyyy-mm-dd format and run. The data will then be displayed in the console and output to a CSV file.

A code snippet can be seen below:

```
#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
#get the environment details
$PWAInstanceURL = Read-Host "what is the pwa url?"
$PWAUserName = Read-Host "what is the pwa username?"
$PWAUserPassword = Read-Host -AsSecureString "what is the pwa password?"
$startDate = Read-Host "enter the period start date in the following format yyyy-mm-dd"
```

For the script to work, the SharePoint Online client DLL is required for the SharePoint Online credentials class. This will work for both Project Online and Project Server 2013 / 2016.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2016/05/17/extract-projectonline-or-projectserver-2013-2016-timesheet-data-powershell-office365/

The script is provided "As is" with no warranties etc.

