# Project Online Project User Sync to Project Si

## Original Links

- [x] Original Technet URL [Project Online Project User Sync to Project Si](https://gallery.technet.microsoft.com/Online-User-Sync-to-7a75ef77)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-User-Sync-to-7a75ef77/description)
- [x] Download: [Download Link](Download\ProjectOnline - SyncProjectTeamtoProjectSite.ps1)

## Output from Technet Gallery

This solution starter PowerShell script will add the users from the project team into the associated Project Site in Project Online. The solution starter example will action this for the specified project. For production use this could easily be made dynamic  to iterate over all / specified projects and project sites. This solution starter code would be a good example to enable user synchronisation for project sites that are not in the Project Online PWA site collection.

A code snippet can be seen below (full code in the download):

```
#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
#set the environment details
$PWAInstanceURL = "PWAURL"
$username = "username"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#example project details
$exampleProjectGUID = 'Target project guid'
$exampleProjectSiteURL = 'TargetProjectSiteUrl'
$groupName = 'Target SP permission group'
try
{
    Function GetProjectTeamMembers
    {
        #get all of the team members  - will include resources that are not users too.
        $team = @()
        #set the REST URL project
        $url = $PWAInstanceURL + "/_api/ProjectServer/Projects('$exampleProjectGUID')/ProjectResources()?`$Select=Id"
        #get all of the data from the REST URL for the Project Team
        while ($url){
            [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds =
```

 The example script will need updating for your PWA instance - the DLL location, PWA URL, username, password and example project details.

A support blog post can be found here:

https://pwmather.wordpress.com/2017/07/07/projectonline-project-user-sync-to-project-sites-ppm-o365-powershell-sharepoint/

The script is provided "As is" with no warranties etc. Fully test this on a non-production PWA instance first and update to be production standard code if running this in a production instance.

