#set the environment details
$PWAInstanceURL = "https://sometenant.sharepoint.com/sites/pwa"
$username = "admin@sometenant.onmicrosoft.com" 
$password = "s0mep@ssw0rd"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force

#Import Dlls
Import-Module ".\Microsoft.SharePoint.Client.dll" 
Import-Module ".\Microsoft.ProjectServer.Client.dll"



#load projects
$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass);    
$projContext.Credentials = $spocreds
$projContext.Load($projContext.Projects)
$projContext.ExecuteQuery() 

# publish them all
foreach ($project in $projContext.Projects) 
{ 
    try 
        {  
            "Attempting to Project" + $Project.Name      
            $draftProject = $project.CheckOut()
            $draftProject.Publish($true) | Out-Null
            $projContext.ExecuteQuery()
            Write-host -ForegroundColor Green $Project.Name "has been published"
        }
    catch{
        write-host -ForegroundColor Red "Add error occurred whilst attempting to publish project: '$projectName'. The error details are: $($_)"
        }
} 

