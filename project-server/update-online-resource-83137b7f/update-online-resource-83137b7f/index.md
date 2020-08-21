# Update Project Online Resource Pool with Azure AD user attributes

## Original Links

- [x] Original Technet URL [Update Project Online Resource Pool with Azure AD user attributes](https://gallery.technet.microsoft.com/Update-Online-Resource-83137b7f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Update-Online-Resource-83137b7f/description)
- [x] Download: [Download Link](Download\UpdateProjectOnlineResourcePoolwithADattributes.ps1)

## Output from Technet Gallery

This PowerShell script will connect to Azure AD and export all the users to a CSV file with the specified attributes. Then the script will connect to the Project Online PWA instance, import data from a CSV file then update the appropriate  resources with the data from the CSV file into the specified custom field. This demonstrates a simple example for importing Azure AD users attributes into resource custom fields. The example script will need updating  for your PWA instance - the DLL location,  PWA URL, username, password, CSV file location and Azure AD username / password. See the blog post for details.

A code snippet can be seen below (full code in the download):

```
Get-MsolUser -All | Select DisplayName, UserPrincipalName, Title | Export-CSV -NoTypeInformation -Path $CSVfilelocation
#Set PWA details - update for correct URL, username and password
$PWAInstanceURL = "https://paulmather.sharepoint.com/sites/pwa"
$PWAUserName = "paul@paulmather.onmicrosoft.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#Custom field ID - update for correct custom field internal ID
$customFieldInternalName = "Custom_3fa3e04146a4e61180d100155d507a05"
$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $securePass);
$projContext.Credentials = $spocreds
#load resources
$projContext.Load($projContext.EnterpriseResources)
$projContext.ExecuteQuery()
#Import CSV file created previously and update associated resources
Import-Csv $CSVfilelocation |
```

This example is for Project Online but could easily be modified for Project Server 2013 / 2016 - just the authentication and AD part would need to be updated and change the DLL's that are being used as these are for SharePoint/Project Online/Azure AD.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2016/11/07/update-projectonline-resource-custom-field-values-using-powershell-with-data-from-azuread-user-attributes-ppm-offce365-projectserver-csom/

The script is provided "As is" with no warranties etc.

