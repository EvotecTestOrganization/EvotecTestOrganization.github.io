# Project Online Snapshot example with PowerShell

## Original Links

- [x] Original Technet URL [Project Online Snapshot example with PowerShell](https://gallery.technet.microsoft.com/Online-Snapshot-example-0437b680)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Snapshot-example-0437b680/description)
- [x] Download: [Download Link](Download\ProjectDataToSharePointListSnapshotExample.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project Reporting OData API to get all of the specified project data in the PWA Site Collection then create a list item on the specified SharePoint list. The user setting up the script will need to update the source PWA  instance URL, username, password and list name. This can be used to capture the data on a schedule to enable snapshot / trend reports to be created. The example script will need updating to meet the requirements on your PWA instance, see the blog post  for details.

The account will need access to the OData API in PWA and edit access to the target SharePoint list. The SharePoint list will also need to be created beforehand with the required columns.

A code snippet can be seen below:

```
#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
#set the environment details
$PWAInstanceURL = "https://tenant.sharepoint.com/sites/pwa"
$username = "admin@tenant.onmicrosoft.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#create the SharePoint list on the PWA site and add the correct columns based on the data required
$listname = "ProjectSnapShots"
$results1 = @()
```

For the script to work, the SharePoint Online client DLL is required for the SharePoint Online credentials class. This example is for Project Online but could easily be modified for Project Server 2013 / 2016.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2016/08/26/projectonline-data-capture-snapshot-capability-with-powershell-sharepoint-office365-ppm-bi/

The script is provided "As is" with no warranties etc.

