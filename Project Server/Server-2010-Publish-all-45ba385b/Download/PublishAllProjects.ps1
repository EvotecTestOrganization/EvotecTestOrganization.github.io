$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwatest/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
$EPMTYGUID = [system.guid]::empty
$ProjectList = $svcPSProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore","", "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
foreach ($projectUid in $projectList) 
{
	if ($projectUid -ne "")
	{ 
$G = [System.Guid]::NewGuid() 
$svcPSProxy.QueuePublish("$G", $projectUid, "true","")}}