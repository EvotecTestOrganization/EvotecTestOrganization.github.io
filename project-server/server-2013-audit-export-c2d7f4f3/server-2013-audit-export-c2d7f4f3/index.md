# Project Server 2013 Audit Export with automated maintenance for multiple PWAs

## Original Links

- [x] Original Technet URL [Project Server 2013 Audit Export with automated maintenance for multiple PWAs](https://gallery.technet.microsoft.com/Server-2013-Audit-Export-c2d7f4f3)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2013-Audit-Export-c2d7f4f3/description)
- [x] Download: [Download Link](Download\QueueAuditexport.ps1)

## Output from Technet Gallery

This script is higly inspired by the [sample uploaded by PWMather](https://gallery.technet.microsoft.com/projectserver/Server-2010-High-level-e9c6ad09). It was sent and recommended to me by a Microsoft engineer working on one of our cases.

I did however have a few problems with just copying and pasting it to production. Main things that were missing for me were:

- Automatically detecting the PWAs (we have more than 20 and I didn't want to add a task for each of them)

- Automatic export files purging

- Ensuring exported data completness in case the scheduler task doesn't run ocasionally

As I had to implement those anyway I thought I might share the effect.

The script is meant to be run by the Task Scheduler every day.

```
#initial variables
$auditExportRootFolder="c:\Logs\ProjectServer\QueueAudit"
$wsSuffix="/_vti_bin/PSI/QueueSystem.asmx?wsdl"
$ExportFilePrefix="QueueAudit-"
$maxRows=10000
$includeDaysOnFirstRun=7
$logRetentionInDays=90
$currentDate=get-date
#get current user (meaning the one we select in windows Scheduler to run the task)
$scriptUser="{0}\{1}" -f $env:USERDOMAIN, $env:USERNAME
#get list of PWA URL OBJECTS which have certain properties we can use later
$pwaUrls=Get-SPProjectWebInstance | % Url
#end date will always be yesterday so we can set it for all PWAs
$endDate=(get-Date).AddDays(-1).Date
$endDateStr=$endDate.ToString("yyyy-MM-dd")
#make sure the root folder for logs exists
If(!(test-path $auditExportRootFolder))
{
    New-Item -ItemType Directory -Force -Path $auditExportRootFolder
}
#process PWAs (at last)
foreach ($pwaUrl in $pwaUrls)
{
    #create folder for Export (if necessary)
    $folderLocalPath=$pwaUrl.Segments[1]
    $fullFolderPath="{0}\{1}" -f $auditExportRootFolder, $folderLocalPath
    If(!(test-path $fullFolderPath))
    {
        New-Item -ItemType Directory -Force -Path $fullFolderPath
    }
    # Make sure the account actually has admin rights in the PWA. Those can be lost e.g. due PWA admin error.
    Grant-SPProjectAdministratorAccess -Url $pwaUrl.AbsoluteUri -UserAccount $scriptUser
    # This part is tricky. Due to maintenance or temporary server failure there is a risk of the script not being run. We want to make sure that the next iteration will export also missing data.
    # We prepare initial start date for our export time period. Seems a little redundant but allows skipping few conditions in the code.
    $startDate=$endDate.AddDays($includeDaysOnFirstRun*-1) #this will change if there are already previous export filed in the PWA's folder
    #If there is any file we  assume it's an export file and that it has interval dates in it's name (yes, I know the saying about assumption and a mother...).
    $newestExport=Get-ChildItem -Path $fullFolderPath | Sort-Object CreationTime -Descending | Select-Object -First 1
    if($newestExport -ne $null)
    {
        $fileName=$newestExport.Name
        $lastCoveredDayDateStr=$fileName.Substring(20,8)
        $lastCoveredDayDate=[datetime]::ParseExact($lastCoveredDayDateStr,"yyyyMMdd",$null)
        if($lastCoveredDayDate -ne $null)
        {
            $startDate=$lastCoveredDayDate.AddDays(1)
        }
    }
    #we proceed only if the end date is not greater than the start date (otherwise it would mean that the script has been run for the second time that day and we've got our parameters wrong anyway).
    if($startDate -le $endDate)
    {
        $startDateStr=$startDate.ToString("yyyy-MM-dd")
        $webServiceUrl=$pwaUrl.AbsoluteUri+$wsSuffix
        #adding user to the filename for troubleshooting purposes
        $filepath="{0}\{1}{2}-{3}-{4}.txt" -f $fullFolderPath,$ExportFilePrefix,$startDate.ToString("yyyyMMdd"),$endDate.ToString("yyyyMMdd"),$env:USERNAME
        $svcPSProxy = New-WebServiceProxy -uri $webServiceUrl -useDefaultCredential
        $svcPSProxy.ReadAllJobStatusSimple("$startDateStr 00:00:01", "$endDateStr 23:59:59", $maxRows, "0", "QueueCompletedTime" ,"Ascending").Status | Export-CSV $filepath -Delimiter ","
    }
    #cleaning older logs
    $oldLogFiles=get-childitem $fullFolderPath | ? {($currentDate - (get-date $_.LastWriteTime)).TotalDays -gt $logRetentionInDays}
    foreach($oldLogFile in $oldLogFiles)
    {
        $oldLogFile.Delete()
    }
}
```

