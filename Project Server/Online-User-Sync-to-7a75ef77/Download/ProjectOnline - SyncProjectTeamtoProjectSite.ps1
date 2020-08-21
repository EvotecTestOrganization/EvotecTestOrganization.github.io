#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

#set the environment details
$PWAInstanceURL = "PWAURL"
$username = "username" 
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force

#example project details
$exampleProjectGUID = 'Target project guid'
$exampleProjectSiteURL = 'TargetProjectSiteUrl'
$groupName = 'Target SP permission group'

try
{
    Function GetProjectTeamMembers
    {
        #get all of the team members  - will include resources that are not users too.
        $team = @()

        #set the REST URL project
        $url = $PWAInstanceURL + "/_api/ProjectServer/Projects('$exampleProjectGUID')/ProjectResources()?`$Select=Id"

        #get all of the data from the REST URL for the Project Team
        while ($url){
            [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass);    
            $webrequest = [System.Net.WebRequest]::Create($url)
            $webrequest.Credentials = $spocreds
            $webrequest.Accept = "application/json;odata=verbose"
            $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
            $response = $webrequest.GetResponse()
            $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
            $data = $reader.ReadToEnd()
            $results = ConvertFrom-Json -InputObject $data
            $team += $results.d.results
            if ($results.d.__next){
                $url=$results.d.__next.ToString()
            }
            else {
                $url=$null
            }
        }
    }

    Function FilterProjectTeamforUsers
    {
        #get all of the team members login accounts and remove resources that are not users in PWA.
        $teamusers = @()

        Foreach ($teammember in $team)
            {
                #set the resource ID
                $teammemberID = $teammember.Id

                #set up the Odata URL
                #$url = $PWAInstanceURL + "/_api/ProjectServer/EnterpriseResources('$teammemberID')/User?`$Select=LoginName,Id" #alternative to OData
                $url = $PWAInstanceURL + "/_api/ProjectData/Resources()?`$Select=ResourceNTAccount,ResourceName&`$Filter=ResourceId eq guid'$teammemberID' and ResourceNTAccount ne null"

                #get all of the data from the OData URL for the project team members that are users in PWA
                [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass);    
                $webrequest = [System.Net.WebRequest]::Create($url)
                $webrequest.Credentials = $spocreds
                $webrequest.Accept = "application/json;odata=verbose"
                $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
                $response = $webrequest.GetResponse()
                $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
                $data = $reader.ReadToEnd()
                $results = ConvertFrom-Json -InputObject $data
                $teamusers += $results.d.results  
            }
    }

    Function AddProjectUserstoProjectSite
    {
        #add the user to the project site
        Foreach ($teamuser in $teamusers)
            {
                $teamuserLogin = $teamuser.ResourceNTAccount
                $teamusername = $teamuser.ResourceName
        
                #get SP site client context
                $ctx = New-Object Microsoft.SharePoint.Client.ClientContext($exampleProjectSiteURL) 
                $credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass) 
                $ctx.Credentials = $credentials 

                #get all the site groups on the Project Site
                $projSiteGroups = $ctx.Web.SiteGroups
                $ctx.Load.($projSiteGroups)

                #get the correct group to add the user into
                $projSiteGroup = $projSiteGroups.GetByName($groupName)
                $ctx.Load($projSiteGroup)
              
                #add the user to the group on the Project Site
                $projSiteUser = $ctx.Web.EnsureUser($teamuserLogin) 
                $ctx.Load($projSiteUser) 
                $teamMemberToAdd = $projSiteGroup.Users.AddUser($projSiteUser) 
                $ctx.Load($teamMemberToAdd) 
                $ctx.ExecuteQuery()

                write-host -ForegroundColor Green "Added $teamusername to the Project Site"
            }
    }

    #call functions
    write-host -ForegroundColor Yellow "Reading Project team member details"
    GetProjectTeamMembers 
    write-host -ForegroundColor Green "Project team member details read"
    write-host -ForegroundColor Yellow "Filtering Project team members for users"
    FilterProjectTeamforUsers
    write-host -ForegroundColor Green "Project team members filtered to users"
    write-host -ForegroundColor Yellow "Adding Project team members to Project site"
    AddProjectUserstoProjectSite
    write-host -ForegroundColor Green "Completed Adding Project team members to Project site"
}
Catch
{
    Write-Host -ForegroundColor Red 'Error encountered when trying to add Project users to the Project site, error details:' $Error[0].ToString();
}