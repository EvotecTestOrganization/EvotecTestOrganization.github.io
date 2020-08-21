$svcPSProxy = New-WebServiceProxy -uri "http://[your PWA project before/default.asmx]/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
 
$job = [system.guid]::NewGuid()
$svcPSProxy.QueuePublish($job, "put UID hier e.g. 4A2A5C24-E5EF-4196-A227-0A69DCA6CF8F", "true","")
         