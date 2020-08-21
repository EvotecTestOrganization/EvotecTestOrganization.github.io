# Project Server 2010 / 2013 - Publish specified projects

## Original Links

- [x] Original Technet URL [Project Server 2010 / 2013 - Publish specified projects](https://gallery.technet.microsoft.com/Server-2010-Publish-537857d8)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2010-Publish-537857d8/description)
- [x] Download: [Download Link](Download\PublishProjectsfromatextfile.ps1)

## Output from Technet Gallery

This PowerShell script will publish the projects specified in a text file. The projects will be published to Project Server when run with an account that has access to the specified projects in Project Server. This can either be run on demand or set to run  on a schedule using the Windows Task Scheduler. The script will only access the projects that the user running the script has permission to.

 A code snippet can be seen below:

```
$projectList = Get-Content C:\projectstobepub.txt
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwatest/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
foreach ($project in $projectList)
    {
        $EPMTYGUID = [system.guid]::empty
        $projectUids = $svcPSProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore",$project, "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
            foreach ($projectUid in $projectUids)
                {
                    if ($projectUid -ne "")
                        {
                            $job = [system.guid]::NewGuid()
                            $svcPSProxy.QueuePublish($job, $projectUid, "true","")
                        }
                 }
    }
```

The script will need to be updated with the correct PWA URL for the WebServiceProxy and text file. For further details on this script please see the following post:

http://pwmather.wordpress.com/2012/10/22/publish-specified-projects-in-projectserver-using-powershell-msproject-ps2010-sp2010/

