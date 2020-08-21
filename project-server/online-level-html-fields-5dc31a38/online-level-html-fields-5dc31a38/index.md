# Project Online Project Level HTML fields to SP Lis

## Original Links

- [x] Original Technet URL [Project Online Project Level HTML fields to SP Lis](https://gallery.technet.microsoft.com/Online-Level-HTML-fields-5dc31a38)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Level-HTML-fields-5dc31a38/description)
- [x] Download: [Download Link](Download\ProjectMultilineFieldDatawithHTMLtoSPlist.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project Reporting OData API to get all of the published projects in the Project Online PWA Site Collection, then for each project it will get the project level multiple lines of text fields that include the HTML from the  REST API and then create a list item on the specified SharePoint list. The user setting up the script will need to update the source PWA instance URL, username, password and list name. The example script will need updating to meet the requirements for your  PWA instance, see the blog post for details.

The account will need access to the OData API in PWA, full read access to all projects and edit access to the target SharePoint list. The SharePoint list will also need to be created beforehand with the required columns.

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
$listname = "ProjectMutliLineFields"
$projectList = @()
```

For the script to work, the SharePoint Online client DLL is required for the SharePoint Online credentials class.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2018/01/27/projectonline-project-level-html-fields-to-a-sharepoint-list-powershell-ppm-office365/

The script is provided "As is" with no warranties etc.

