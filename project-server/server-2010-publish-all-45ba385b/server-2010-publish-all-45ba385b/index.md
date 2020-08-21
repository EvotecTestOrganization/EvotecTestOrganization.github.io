# Project Server 2010 / 2013 - Publish all projects

## Original Links

- [x] Original Technet URL [Project Server 2010 / 2013 - Publish all projects](https://gallery.technet.microsoft.com/Server-2010-Publish-all-45ba385b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2010-Publish-all-45ba385b/description)
- [x] Download: [Download Link](Download\PublishAllProjects.ps1)

## Output from Technet Gallery

This PowerShell script will publish all projects in Project Server when run with an account that is an administrator in Project Server. This can either be run on demand or set to run on a schedule using the Windows Task Scheduler. If you want all projects  to be published, run on demand / set the windows scheduled task to run using the Project Server adminstrator account. The script will only access the projects that the user running the script has permission to.

A code snippet can be seen below:

```
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwatest/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$EPMTYGUID = [system.guid]::empty
$ProjectList = $svcPSProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore","", "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
foreach ($projectUid in $projectList)
{
    if ($projectUid -ne "")
    {
$G = [System.Guid]::NewGuid()
$svcPSProxy.QueuePublish("$G", $projectUid, "true","")}}
```

The script will need to be updated with the correct PWA URL for the WebServiceProxy. For further details on this script please see the following post:

http://pwmather.wordpress.com/2012/05/31/updated-publish-all-projects-in-projectserver-using-powershell-msproject-ps2010-sp2010/

For a JavaScript based version for Project Online / Project Server 2013, see the script below:

http://gallery.technet.microsoft.com/scriptcenter/Server-2013-Online-Publish-15215a56

