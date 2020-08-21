#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

#set the environment details
$PWAInstanceURL = "https://tenant.sharepoint.com/sites/pwa"
$username = "admin@tenant.onmicrosoft.com" 
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#create the SharePoint list on the PWA site and add the correct columns based on the data required
$listname = "ProjectMutliLineFields"

$projectList = @()

#set the Odata URL with the correct project fields needed
$url = $PWAInstanceURL + "/_api/ProjectData/Projects()?`$Filter=ProjectType ne 7&`$Select=ProjectId"

#get all of the data from the OData URL
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
    $projectList += $results.d.results
    if ($results.d.__next){
        $url=$results.d.__next.ToString()
    }
    else {
        $url=$null
    }

}

 Foreach ($project in $projectList)
        {
            
            #set the project ID
            $projectID = $project.ProjectId
            #set the REST URL with the correct project multiline custom fields needed
            $url = $PWAInstanceURL + "/_api/ProjectServer/Projects(guid'$projectID')/IncludeCustomFields?`$Select=Name,Id,Custom_x005f_4d0daaaba6ade21193f900155d153dd4,Custom_x005f_3f9c814ca2ade21193f900155d153dd4,Custom_x005f_a801708ea5ade21193f900155d153dd4,Custom_x005f_70534c6aa2ade21193f900155d153dd4"
            Try{
            #get all of the data from the REST URL for multiline custom fields
                [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass);    
                $webrequest = [System.Net.WebRequest]::Create($url)
                $webrequest.Credentials = $spocreds
                $webrequest.Accept = "application/json;odata=verbose"
                $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
                $response = $webrequest.GetResponse()
                $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
                $data = $reader.ReadToEnd()
                $results = $data | ConvertFrom-Json

                #get PWA site client context
                $ctx = New-Object Microsoft.SharePoint.Client.ClientContext($PWAInstanceURL) 
                $credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass) 
                $ctx.Credentials = $credentials 
                $ctx.ExecuteQuery() 
                #get the target list 
                $List = $ctx.Web.Lists.GetByTitle($listname) 
                $ctx.Load($List) 
                $ctx.ExecuteQuery() 

                #for each project, create the list item - update the newitem with the correct list columns and project data
 
                $itemcreationInfo = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation 
                $newitem = $List.AddItem($itemcreationInfo) 
                $newitem["Title"] = $results.d.Name
                $newitem["ProjectId"] = $results.d.Id
                $newitem["Actions"] = $results.d.Custom_x005f_3f9c814ca2ade21193f900155d153dd4
                $newitem["Status"] = $results.d.Custom_x005f_4d0daaaba6ade21193f900155d153dd4
                $newitem["Changes"] = $results.d.Custom_x005f_70534c6aa2ade21193f900155d153dd4
                $newitem["RisksandIssues"] = $results.d.Custom_x005f_a801708ea5ade21193f900155d153dd4
                $newitem.Update() 
                $ctx.ExecuteQuery() 

            }
            Catch {
                write-host -ForegroundColor Red "Add error occurred whilst attempting to get project. The error details are: $($_)"
            }
        }