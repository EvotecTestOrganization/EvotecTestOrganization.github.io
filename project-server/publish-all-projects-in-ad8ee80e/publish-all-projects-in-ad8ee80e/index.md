# Publish All Projects in Project Online using PowerShell

## Original Links

- [x] Original Technet URL [Publish All Projects in Project Online using PowerShell](https://gallery.technet.microsoft.com/Publish-All-Projects-in-ad8ee80e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Publish-All-Projects-in-ad8ee80e/description)
- [x] Download: [Download Link](Download\Publish_All_Projects_ProjectOnline.ps1)

## Output from Technet Gallery

This PowerShell script publishes all projects in a Project Web App instance of Project Online. This is useful to ensure that Project Status Reports are showing most uptodate data.

The pre-requisites to run this script are

1. **Copy SharePoint & Project Server CSOM DLLs**

Download SharePoint & Project Server CSOM Dlls from the nuget https://www.nuget.org/packages/Microsoft.SharePointOnline.CSOM

Then copy the following DLLs files in the same folder as the script

- Microsoft.SharePoint.Client.Dll

- Microsoft.SharePoint.Client.Runtime.Dll

- Microsoft.ProjectServer.Client.Dll

** 2. Change PWA details in the script**

Set the PWA url, username & password at the beginning of the script under the "#set the environment details" comment.

A code snippet can be seen below:

```
#set the environment details
$PWAInstanceURL = "https://sometenant.sharepoint.com/sites/pwa"
$username = "admin@sometenant.onmicrosoft.com"
$password = "s0mep@ssw0rd"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#Import Dlls
Import-Module ".\Microsoft.SharePoint.Client.dll"
Import-Module ".\Microsoft.ProjectServer.Client.dll"
#load projects
$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass);
$projContext.Credentials = $spocreds
$projContext.Load($projContext.Projects)
$projContext.ExecuteQuery()
```

 The script is provided "As is" with no warranties etc.

