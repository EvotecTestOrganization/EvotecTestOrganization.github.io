# Access all Project Online Projects Sites using CSOM

## Original Links

- [x] Original Technet URL [Access all Project Online Projects Sites using CSOM](https://gallery.technet.microsoft.com/Access-all-Online-Projects-568c7c59)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Access-all-Online-Projects-568c7c59/description)
- [x] Download: [Download Link](Download\Example CSOM to access all Project Sites.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project Reporting OData API to get a list of all the Project Sites in the PWA Site Collection linked to a project. It will then access each of those project sites to enable you to easily update / review the site if needed.  This example just lists all of the list titles for each site but can be used as a starting script for modifying a particular list or adding a new list on all project sites etc. The user running the script will need to update the source PWA instance URL, username  and password. The account will need access to the OData API in PWA and access to all the project sites.

A code snippet can be seen below:

```
#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
#set the environment detail variables: username, password and pwaUrl
$username = "username@cps.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
$pwaUrl = "pwa URL"
```

For the script to work, the SharePoint Online client DLL is required for the SharePoint Online credentials class. This example is for Project Online but could easily be modified for Project Server 2013 / 2016.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2016/07/08/access-projectonline-project-sites-using-powershell-and-sharepoint-csom-office365/

The script is provided "As is" with no warranties etc.

