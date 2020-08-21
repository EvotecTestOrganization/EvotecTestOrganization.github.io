$projectClient = New-WebServiceProxy -uri "http://pf-dev-joa01/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
$ProjectList = $projectClient.ReadProjectList()
foreach ($project in $ProjectList.Project) 
{
 if ($project -ne "")
 { 
  $projectName = $project.PROJ_NAME
  $projectWorking = $projectClient.ReadProjectEntities($project.PROJ_UID, 1, "WorkingStore")
  
  
  $projectWorkingPub = $projectClient.ReadProjectEntities($project.PROJ_UID, 1, "PublishedStore")
        if($projectWorking.Project[0].PROJ_LAST_SAVED -ne $projectWorkingPub.Project[0].PROJ_LAST_SAVED)
        {
            Write-Host "Project: $projectName is not Published"
        }
        else
        {
            Write-Host "Project: $projectName is Published"
        }
 }
}
