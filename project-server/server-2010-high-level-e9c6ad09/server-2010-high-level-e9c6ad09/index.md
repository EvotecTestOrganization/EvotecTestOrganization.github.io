# Project Server 2010 / 2013 High-level Audit Export exampl

## Original Links

- [x] Original Technet URL [Project Server 2010 / 2013 High-level Audit Export exampl](https://gallery.technet.microsoft.com/Server-2010-High-level-e9c6ad09)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2010-High-level-e9c6ad09/description)
- [x] Download: [Download Link](Download\QueuejobstatusAudit.ps1)

## Output from Technet Gallery

This PowerShell script accesses the Project Server queue data and exports this into a text file in the specified location. Execute the script on a daily schedule using the Windows Task Scheduler to capture high-level audit details for Project Server. The  script will need to be updated with the correct export location (filename variable) and the correct PWA URL in the WebServiceProxy.

A code snippet can be seen below:

```
$Today = Get-Date
$Yesterday = $Today.AddDays(-1).ToString("yyyy-MM-d")
$Filename = "C:\PSAuditExport\QueueExport-"
$filetype = ".txt"
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwa/_vti_bin/PSI/QueueSystem.asmx?wsdl" -useDefaultCredential
$svcPSProxy.ReadAllJobStatusSimple("$Yesterday 00:00:01", "$Yesterday 23:59:59", "200", "0", "QueueCompletedTime" ,"Ascending").Status | Export-CSV $Filename$Yesterday$filetype -Delimiter "|"
```

 For details on using this script please see the following post:

http://pwmather.wordpress.com/2012/03/05/projectserver-2010-2007-high-level-audit-export-via-powershell-msproject-ps2010-epm/

