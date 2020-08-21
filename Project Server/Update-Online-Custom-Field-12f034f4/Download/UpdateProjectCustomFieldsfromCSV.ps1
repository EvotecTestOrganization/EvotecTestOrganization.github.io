#Add in libraries - update for the correct location
#SharePoint Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.SharePoint.Client.dll'
#Project Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.ProjectServer.Client.dll'

#Set PWA details - update for correct URL, username and password
$PWAInstanceURL = "https://paulmather.sharepoint.com/sites/pwa"
$PWAUserName = "paul@paulmather.onmicrosoft.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force 

#Custom field ID - update for correct custom field internal ID
$customFieldInternalName = "Custom_7cdad654ca8fe61180c800155d306603"

$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $securePass); 
$projContext.Credentials = $spocreds

#load projects
$projContext.Load($projContext.Projects)
$projContext.ExecuteQuery() 

#Import CSV file and update associated project - update location for CSV file
Import-Csv "C:\Temp\ProjectBudgetData.csv" | Foreach-Object { 

    try {        
        $projectName = $_.ProjectName   
        $project = $projContext.Projects | select Id, Name | where {$_.Name -eq $projectName}
        if($project -ne $null){
            $proj = $projContext.Projects.GetByGuid($project.Id)
            $draftProject = $proj.CheckOut()
            $draftProject.SetCustomFieldValue($customFieldInternalName, $_.Budget)
            $draftProject.Publish($true) | Out-Null
            $projContext.ExecuteQuery()
            Write-host -ForegroundColor Green "'$projectName' has been updated"
            }
        else {
            Write-host -ForegroundColor Yellow "'$projectName' not found"
            }
        }
    catch{
        write-host -ForegroundColor Red "Add error occurred whilst attempting to update project: '$projectName'. The error details are: $($_)"
        }
}