$Today = Get-Date
$Yesterday = $Today.AddDays(-1).ToString("yyyy-MM-d")
$Filename = "C:\PSAuditExport\QueueExport-"
$filetype = ".txt"
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwa/_vti_bin/PSI/QueueSystem.asmx?wsdl" -useDefaultCredential 
$svcPSProxy.ReadAllJobStatusSimple("$Yesterday 00:00:01", "$Yesterday 23:59:59", "200", "0", "QueueCompletedTime" ,"Ascending").Status | Export-CSV $Filename$Yesterday$filetype -Delimiter "|"