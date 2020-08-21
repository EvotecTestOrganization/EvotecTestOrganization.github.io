###create sites for projects without a site
###update the uri with the correct PWA URL for your farm
$svcPSProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$svcWSSProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/WssInterop.asmx?wsdl" -useDefaultCredential
$emptyGUID = [system.guid]::empty
$wssServerUID =  $svcWSSProxy.ReadWssSettings().WSSadmin.Wadmin_current_sts_server_uid   
$wssWebFullUrl = [system.string]::Empty
$webTemplateLcid = '1033'
$webTemplateName = [system.string]::Empty
$projectList = $svcPSProxy.ReadProjectStatus("$emptyGUID","PublishedStore","", "0").Project |  where {$_.WPROJ_STS_SUBWEB_NAME -notlike "*/*"}
$projectGUIDs = $projectList.Proj_uid
if ($projectGUIDs.Count -gt 0)
{
    Write-Host -ForegroundColor Red "There are " $projectGUIDs.Count " projects without a project site, sites will now be created for these projects"
    foreach ($projectUid in $projectGUIDs) 
    {
	    if ($projectUid -ne "")
	    { 
            $svcWSSProxy.CreateWssSite($projectUid,$wssServerUID, $wssWebFullUrl, $webTemplateLcid, $webTemplateName)
            Write-host -ForegroundColor Green 'Project UID for created site' $projectUid
        }
    }
}
else
{
    Write-host -ForegroundColor Green "All Projects have a project site associated"
}