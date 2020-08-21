#Add in libraries - update for the correct location 
#SharePoint Online CSOM DLL 
Import-Module 'C:\temp\Microsoft.SharePoint.Client.dll' 
#Project Online CSOM DLL 
Import-Module 'C:\temp\Microsoft.ProjectServer.Client.dll' 
 
#Set PWA details - update for correct URL, username and password 
$PWAInstanceURL = "http://domain/pwa" 
$PWAUserName = "domain\username" 
#$password = Read-Host -AsSecureString -Prompt 'Enter Password'
#$securePass = ConvertTo-SecureString $password -AsPlainText -Force  
$securePass = Read-Host -AsSecureString -Prompt 'Enter Password' 
 
#Custom field ID - update for correct custom field internal ID 
$Dept = "Custom_9d77d62aa92e4d40adc8446c90eb7456" #Lookup
$Cost = "Custom_d2a40d243da3420caebbb654cbcae066" #Cost-Text
$multiselect = "Custom_c5fc29195257e71180ef0050568143d9" #Lookup
$State = "Custom_53443140e3134b54a89a2578926e8409" #SinglelineText
 
$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL) 
$spocreds = New-Object System.Net.NetworkCredential($PWAUserName, $securePass);  
$projContext.Credentials = $spocreds 
 
#load projects 
$projContext.Load($projContext.Projects) 
$projContext.ExecuteQuery()  
 
#Import CSV file and update associated project - update location for CSV file 
Import-Csv "C:\ProjectBulkUpdate.csv" | Foreach-Object { 

    try {        
        $projectName = $_.ProjectName
        [Array]$MyArray1 = $_.Dept  
        [Array]$MyArray3 = $_.multiselect1,$_.multiselect2,$_.multiselect3      
        $project = $projContext.Projects | select Id, Name | where {$_.Name -eq $projectName}
        if($project -ne $null){
            $proj = $projContext.Projects.GetByGuid($project.Id)
            $draftProject = $proj.CheckOut()
            $draftProject.SetCustomFieldValue($Dept,$MyArray1)            
            $draftProject.SetCustomFieldValue($Cost,$_.Cost)
            $draftProject.SetCustomFieldValue($multiselect,$MyArray3)            
            $draftProject.SetCustomFieldValue($State,$_.State)
            $draftProject.Publish($true) | Out-Null
            $projContext.ExecuteQuery()
            Write-host -ForegroundColor Green "'$projectName' has been updated"
            }
        else {
            Write-host -ForegroundColor Yellow "'$projectName' not found with $_.Dept , $_.State , $_.ProjectStatus , $_.multiselect1 , $_.multiselect2 , $_.multiselect3 "
            }
        }
    catch{
        write-host -ForegroundColor Red "Add error occurred whilst attempting to update project: '$projectName'. The error details are: $($_)"
        }
}