#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

#set the environment detail variables: username, password and pwaUrl
$username = "username@cps.com" 
$password = "password"
$securePass = ConvertTo-SecureString $password -AsPlainText -Force
$pwaUrl = "pwa URL"

$results1 = @()

#set the Odata URL
$url = $pwaUrl + "/_api/ProjectData/Projects()?`$Filter=ProjectType ne 7&`$Select=ProjectWorkspaceInternalUrl"

write-host "Getting the list of Project Sites" -ForegroundColor Yellow

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

$projectsites = $results1.ProjectWorkspaceInternalUrl

write-host "List of Project Sites completed, there are: " $projectsites.count " Project Sites." -ForegroundColor Green
write-host "Starting to process the list of project sites" -ForegroundColor Yellow

Foreach ( $projectsite in $projectsites)
    {
        $webUrl = $projectsite

        $ctx = New-Object Microsoft.SharePoint.Client.ClientContext($webUrl)
        $ctx.Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePass)

        $web = $ctx.Web
        $ctx.Load($web)
        $ctx.ExecuteQuery()

        write-host "Project Site Title: " $web.Title -ForegroundColor Yellow
        write-host "Project Site URL: " $web.Url -ForegroundColor Yellow
        Write-host "Lists titles below:" -ForegroundColor Yellow
         
        #update site as required - this example just reads the lists on the site
        #load the Lists
        $lists = $ctx.Web.Lists
        $ctx.Load($lists) 
        $ctx.ExecuteQuery();

        foreach ($list in $lists)
            {
                $list.Title
            }

    }

write-host "Processing of Project Sites completed" -ForegroundColor Green