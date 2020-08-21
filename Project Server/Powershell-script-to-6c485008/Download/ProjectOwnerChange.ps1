$ProjectSite = "http://project.contoso.com/PWA"
$NewProjectOwnerID = "e7615885-4ab5-e111-95dc-00155d02c97f"
$OldProjectOwnerID = "c448cc7d-a3be-e111-9f1e-00155d022681"

function Load_SPAddin()
 {
    $ver = $host | select version
    if ($ver.Version.Major -gt 1) {$host.Runspace.ThreadOptions = “ReuseThread”}
    if ((Get-PSSnapin “Microsoft.SharePoint.PowerShell” -ErrorAction SilentlyContinue) -eq $null)
        {
        Add-PSSnapin “Microsoft.SharePoint.PowerShell”
        }
 }

Load_SPAddin

$svcPSProxy = New-WebServiceProxy -uri "$ProjectSite/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
$EPMTYGUID = [system.guid]::empty
$ProjectList = $svcPSProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore","", "0").Project | format-table proj_uid -hidetableheaders | out-string -stream

foreach ($projectUid in $ProjectList) 
{
    if ($projectUid -ne "")
	{ 


        $project = $svcPSProxy.ReadProjectEntities($projectUid, 1 , "WorkingStore")
        
        if ($project.Project[0].ProjectOwnerID -eq $OldProjectOwnerID)
        {
            Write-Host $project.Project[0].Proj_Name "will be updated"
            $sessionGuid = [System.Guid]::NewGuid()
            $jobGuid = [System.Guid]::NewGuid()
            $project.Project[0].ProjectOwnerID = $NewProjectOwnerID
            $svcPSProxy.CheckOutProject($projectUid, $sessionGuid, "Updating Project")
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.QueueUpdateProject($jobGuid, $sessionGuid, $project, $FALSE);  
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.QueuePublish($jobGuid, $projectUid, $FALSE, $EPMTYGUID);                   
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.QueueCheckInProject($jobGuid, $projectUid, $TRUE, $sessionGuid, "CheckIn Update...")       
        }
            
        
    }
}