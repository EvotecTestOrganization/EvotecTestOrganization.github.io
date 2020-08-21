# Update Project Online Project Custom Field Value Using PowerShell

## Original Links

- [x] Original Technet URL [Update Project Online Project Custom Field Value Using PowerShell](https://gallery.technet.microsoft.com/Update-Online-Custom-Field-12f034f4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Update-Online-Custom-Field-12f034f4/description)
- [x] Download: [Download Link](Download\UpdateProjectCustomFieldsfromCSV.ps1)

## Output from Technet Gallery

This PowerShell script will connect to the Project Online PWA instance, import data from a CSV file then update the appropriate projects with the data from the CSV file. This demonstrates a simple example for importing the project  budget value from a CSV file into a project level custom field in Project Online. The CSV file could be an export from the financial system. The example script will need updating to for your PWA instance - the DLL location, PWA URL, username, password  and CSV file location. See the blog post for details.

A code snippet can be seen below (full code in the download):

```
#Add in libraries - update for the correct location
#SharePoint Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.SharePoint.Client.dll'
#Project Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.ProjectServer.Client.dll'
#Set PWA details - update for correct URL, username and password
$PWAInstanceURL = "https://paulmather.sharepoint.com/sites/pwa"
$PWAUserName = "paul@paulmather.onmicrosoft.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#Custom field ID - update for correct custom field internal ID
$customFieldInternalName = "Custom_7cdad654ca8fe61180c800155d306603"
$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $securePass);
$projContext.Credentials = $spocreds
#load projects
$projContext.Load($projContext.Projects)
$projContext.ExecuteQuery()
#Import CSV file and update associated project - update location for CSV file
Import-Csv "C:\Temp\ProjectBudgetData.csv"
```

This example is for Project Online but could easily be modified for Project Server 2013 / 2016 - just the authentication would need to be updated and change the DLL's that are being used as these are for SharePoint and Project Online.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2016/11/06/update-projectonline-project-custom-field-values-using-powershell-with-data-from-a-csv-file-ppm-projectserver-csom/

The script is provided "As is" with no warranties etc.

