#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

#set the environment details
$PWAInstanceURL = "https://tenant.sharepoint.com/sites/pwa"
$username = "admin@tenant.onmicrosoft.com" 
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
#create the SharePoint list on the PWA site and add the correct columns based on the data required
$listname = "ProjectData"

$results1 = @()

#set the Odata URL with the correct project fields needed,
$url = $PWAInstanceURL + "/_api/ProjectData/Projects()?`$Filter=ProjectType ne 7&`$Select=ProjectId,ProjectName,ProjectPercentCompleted,ProjectOwnerName,ProjectDescription,ProjectStartDate,ProjectFinishDate,ProjectWorkspaceInternalUrl&`$orderby=ProjectName"

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
    $results1 += $results.d.results
    if ($results.d.__next){
        $url=$results.d.__next.ToString()
    }
    else {
        $url=$null
    }
}

#add data to project data list
#get PWA site client context
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($PWAInstanceURL) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass) 
$ctx.Credentials = $credentials 
$ctx.ExecuteQuery() 
 
 
#get the target list 
$List = $ctx.Web.Lists.GetByTitle($listname) 
$ctx.Load($List) 
$ctx.ExecuteQuery() 

#for each project, create/update the list item - update the item / newitem with the correct list columns and project data
foreach ($projectrow in $results1)
{ 

   #check if list item exists for project
   $camlQuery = new-object Microsoft.SharePoint.Client.CamlQuery
   $camlQuery.ViewXml ="<View><Query><Where><Eq><FieldRef Name='ProjectId'/><Value Type='Text'>$($projectrow.ProjectId)</Value></Eq></Where></Query></View>"
   $items = $List.GetItems($camlQuery) 
   $ctx.Load($items)
   $ctx.ExecuteQuery() 
    
   if($items -ne $null)
   {
       foreach($item in $items)
       {
            #update existing list item for project
            $item["Title"] = $projectrow.ProjectName
            $item["ProjectId"] = $projectrow.ProjectId
            $item["ProjectDescription"] = $projectrow.ProjectDescription
            $item["Progress"] = $projectrow.ProjectPercentCompleted
            $item["ProjectOwner"] = $projectrow.ProjectOwnerName
            $item["ProjectStart"] = $projectrow.ProjectStartDate
            $item["ProjectFinish"] = $projectrow.ProjectFinishDate
            $item["ProjectSiteUrl"] = $projectrow.ProjectWorkspaceInternalUrl
            $item.Update() 
            $ctx.ExecuteQuery()
       }
   }
   else
   {
       #create new list item for project
       $itemcreationInfo = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation 
       $newitem = $List.AddItem($itemcreationInfo) 
       $newitem["Title"] = $projectrow.ProjectName
       $newitem["ProjectId"] = $projectrow.ProjectId
       $newitem["ProjectDescription"] = $projectrow.ProjectDescription
       $newitem["Progress"] = $projectrow.ProjectPercentCompleted
       $newitem["ProjectOwner"] = $projectrow.ProjectOwnerName
       $newitem["ProjectStart"] = $projectrow.ProjectStartDate
       $newitem["ProjectFinish"] = $projectrow.ProjectFinishDate
       $newitem["ProjectSiteUrl"] = $projectrow.ProjectWorkspaceInternalUrl
       $newitem.Update() 
       $ctx.ExecuteQuery()
   }
} 