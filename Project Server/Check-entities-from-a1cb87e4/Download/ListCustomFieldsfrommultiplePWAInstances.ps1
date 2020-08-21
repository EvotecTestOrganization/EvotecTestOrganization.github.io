#Add in libraries
#Project CSOM
Add-Type -Path 'C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.ProjectServer.Client.dll'
#add SharePoint Online DLL
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

$NoPWAInstances = Read-Host "how many instances to check?"

$PWAIntances = 1 

DO

{

 Write-host -Foregroundcolor Green "Starting read for PWA instance $PWAIntances" 
 $PWAInstanceURL = Read-Host "what is the source pwa url?"
 $PWAUserName = Read-Host "what is the source pwa username?" 
 $PWAUserPassword = Read-Host -AsSecureString "what is the source pwa password?" 

 $PWAIntances++ | out-null
 $projContext = New-Object Microsoft.ProjectServer.Client.ProjectContext($PWAInstanceURL)
 [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $PWAUserPassword); 
 $projContext.Credentials = $spocreds
    
 $projContext.Load($projContext.CustomFields)
 $projContext.ExecuteQuery()
 Write-Host -Foregroundcolor Green "Data for: $PWAInstanceURL"
 $projContext.CustomFields | select Id, Name, Description, FieldType

} While ($PWAIntances -le $NoPWAInstances)