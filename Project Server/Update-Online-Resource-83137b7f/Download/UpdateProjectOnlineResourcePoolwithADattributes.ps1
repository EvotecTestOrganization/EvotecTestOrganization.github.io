#Add in libraries - update for the correct location
#SharePoint Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.SharePoint.Client.dll'
#Project Online CSOM DLL
Import-Module 'C:\OneDrive for Business\External Disk\SharePointOnlineCSOMDLLs\16.1.5521.1200\Microsoft.ProjectServer.Client.dll'

#install the Azure AD PowerShell module - downloaded from here http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185
#Set Azure AD user details - update for correct username, password and CSV file location
$ADusername = "paul@paulmather.onmicrosoft.com"
$ADpassword = "password"
$CSVfilelocation = "C:\Temp\ADusers.csv" 
$secureADpassword = ConvertTo-SecureString $ADpassword -AsPlainText -Force
$ADcreditials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ADusername,$secureADpassword
Import-Module MSOnline
connect-msolservice -credential $ADcreditials
Get-MsolUser -All | Select DisplayName, UserPrincipalName, Title | Export-CSV -NoTypeInformation -Path $CSVfilelocation

#Set PWA details - update for correct URL, username and password
$PWAInstanceURL = "https://paulmather.sharepoint.com/sites/pwa"
$PWAUserName = "paul@paulmather.onmicrosoft.com"
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force 

#Custom field ID - update for correct custom field internal ID
$customFieldInternalName = "Custom_3fa3e04146a4e61180d100155d507a05"

$projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
[Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $securePass); 
$projContext.Credentials = $spocreds

#load resources
$projContext.Load($projContext.EnterpriseResources)
$projContext.ExecuteQuery() 

#Import CSV file created previously and update associated resources
Import-Csv $CSVfilelocation | Foreach-Object { 
    try {        
        $resName = $_.DisplayName   
        $resource = $projContext.EnterpriseResources | select Id, Name | where {$_.Name -eq $resName}
        if($resource -ne $null){
            $res = $projContext.EnterpriseResources.GetByGuid($resource.Id)
            $res[$customFieldInternalName] = $_.Title
            $projContext.EnterpriseResources.Update()
            $projContext.ExecuteQuery()
            Write-host -ForegroundColor Green "'$resName' has been updated"
            }
        else {
            Write-host -ForegroundColor Yellow "'$resName' not found"
            }
        }
    catch{
        write-host -ForegroundColor Red "Add error occurred whilst attempting to update resource: '$resName'. The error details are: $($_)"
        }
}