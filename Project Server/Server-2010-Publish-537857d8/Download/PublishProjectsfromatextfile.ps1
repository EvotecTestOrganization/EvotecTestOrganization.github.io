$projectList = Get-Content C:\projectstobepub.txt
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwatest/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
foreach ($project in $projectList)
    { 
        
        $EPMTYGUID = [system.guid]::empty 
        $projectUids = $svcPSProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore",$project, "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
            foreach ($projectUid in $projectUids) 
                {
                    if ($projectUid -ne "")
                        {
                            $job = [system.guid]::NewGuid()
                            $svcPSProxy.QueuePublish($job, $projectUid, "true","")
                        }
                 }
    }