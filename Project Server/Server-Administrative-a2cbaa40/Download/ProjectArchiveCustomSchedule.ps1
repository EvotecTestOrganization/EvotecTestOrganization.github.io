#The site URL where the schedule is defined
$AdminSite = "http://project.contoso.com"
#The schedule library and the column names that are used to define the archive schedule (a new entry for each day when the projects will be archived)
$ScheduleLibrary ="MySchedule"
$ScheduleLibraryColumn ="DateTime"
#The project site URL
$ProjectSite = "http://project.contoso.com/PWA"
#the text custom field UID. the field value will be updated accross all projects (not sub or master projects) so the projects can be archived
$ecfGuidValue = "efcc9c8f-3f58-e411-9493-00155d00c808"

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

$RunArchive = "0"
$web = Get-SPWeb $AdminSite
$MyList = $web.Lists[$ScheduleLibrary]
$eitems = $MyList.GetItems()
$Today = Get-Date
foreach ($eitem in $eitems)
    {
    $MyDate = Get-Date $eitem[$ScheduleLibraryColumn]
    if($Today.Day -eq $MyDate.Day -and $Today.Month -eq $MyDate.Month -and $Today.Year -eq $MyDate.Year)
        {
        $RunArchive = "1"
        }   
    }

if ($RunArchive -eq "1")
    {
    $svcPSProxy = New-WebServiceProxy -uri "$ProjectSite/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
    $EmptyGUID = [system.guid]::empty
    $ProjectList = $svcPSProxy.ReadProjectStatus("$EmptyGUID","WorkingStore","", "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
    foreach ($projectUid in $ProjectList) 
    {
        $foundCustomField = "0"
        if ($projectUid -ne "")
	    { 
            $sessionGuid = [System.Guid]::NewGuid()
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.CheckOutProject($projectUid, $sessionGuid, "Updating Project") 
            $project = $svcPSProxy.ReadProjectEntities($projectUid, 32,"WorkingStore")  
            foreach($row in $project.ProjectCustomFields)
            {
                if([System.Guid]$row.MD_PROP_UID -eq [System.Guid]$ecfGuidValue)
                {
                    $row.TEXT_VALUE = [System.String]$Today
                    $foundCustomField = "1"
                }
            }
            if ($foundCustomField -eq "0")
            {
                $myNewCustomRow = $project.ProjectCustomFields.NewProjectCustomFieldsRow() 
                $myNewCustomRow.PROJ_UID = [System.Guid]$projectUid
                $myNewCustomRow.CUSTOM_FIELD_UID = [System.Guid]::NewGuid()
                $myNewCustomRow.MD_PROP_UID = [System.Guid]$ecfGuidValue
                $myNewCustomRow.TEXT_VALUE = [System.String]$Today
                $project.ProjectCustomFields.AddProjectCustomFieldsRow($myNewCustomRow)
 
            }
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.QueueUpdateProject($jobGuid, $sessionGuid, $project, $FALSE);                    
            $jobGuid = [System.Guid]::NewGuid()
            $svcPSProxy.QueueCheckInProject($jobGuid, $projectUid, $TRUE, $sessionGuid, "CheckIn Update...")      
        }
    }
    #Start-Sleep -s 300

    $svcPSProxy2 = New-WebServiceProxy -uri "$ProjectSite/_vti_bin/PSI/Archive.asmx?wsdl" -useDefaultCredential
    $svcPSProxy2.QueueArchiveProjects()
    }
