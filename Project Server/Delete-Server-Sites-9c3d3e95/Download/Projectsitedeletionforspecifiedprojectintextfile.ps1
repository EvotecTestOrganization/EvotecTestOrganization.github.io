#Fully test on a test PWA instance first
#For projects that you wish to delete the project site, add the exact project names to a text file and reference the text file location below
$projectList = Get-Content C:\Users\paulmather\Desktop\projectsitesstodelete.txt
#Update the uri with the correct PWA URL for your PWA instance and run with an administrator account
$svcPSProxy = New-WebServiceProxy -uri "http://vm753/PWA/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$svcWSSProxy = New-WebServiceProxy -uri "http://vm753/PWA/_vti_bin/PSI/WssInterop.asmx?wsdl" -useDefaultCredential
$emptyGUID = [system.guid]::empty
if ($projectList.count -gt 0)
{
    Write-Host -ForegroundColor Red "There are " $projectList.Count " project sites to delete, sites will now be deleted for these projects"
    foreach ($project in $projectList)
            {
                 $projectGUIDs = $svcPSProxy.ReadProjectStatus("$emptyGUID","PublishedStore",$project, "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
   
                    foreach ($projectUid in $projectGUIDs) 
                        {
	                            if ($projectUid -ne "")
	                                {
                                        $svcWSSProxy.DeleteWSSSite($projectUid)
                                        Write-host -ForegroundColor Green 'Project UID for deleted site' $projectUid
                                    }
                        }     
            }
}
else
{
    Write-host -ForegroundColor Green "There are no project sites to delete"
}