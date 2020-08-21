# Keep Project Online data in sync with SharePoint lis

## Original Links

- [x] Original Technet URL [Keep Project Online data in sync with SharePoint lis](https://gallery.technet.microsoft.com/Keep-Online-data-in-sync-06a1bf8d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Keep-Online-data-in-sync-06a1bf8d/description)
- [x] Download: [Download Link](Download\ProjectDataToSharePointList.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project Reporting OData API to get all of the published projects in the Project Online PWA Site Collection, then for each project it will create / update a list item on the specified SharePoint list. The user setting up  the script will need to update the source PWA instance URL, username, password and list name. The example script will need updating to meet the requirements for your PWA instance, see the blog post for details.

The account will need access to the OData API in PWA and edit access to the target SharePoint list. The SharePoint list will also need to be created beforehand with the required columns.

A code snippet can be seen below - full code in the download:

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
$listname = "ProjectData"
$results1 = @()
#set the Odata URL with the correct project fields needed,
$url = $PWAInstanceURL + "/_api/ProjectData/Projects()?`$Filter=ProjectType ne 7&`$Select=ProjectId,ProjectName,ProjectPercentCompleted,ProjectOwnerName,ProjectDescription,ProjectStartDate,ProjectFinishDate,ProjectWorkspaceInternalUrl&`$orderby=ProjectName"
#get all of the data from the OData URL
while ($url){
```

For the script to work, the SharePoint Online client DLL is required for the SharePoint Online credentials class.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2018/03/01/projectonline-powershell-to-keep-ppm-data-in-sync-on-sharepoint-list-pmot-o365/

The script is provided "As is" with no warranties etc.

