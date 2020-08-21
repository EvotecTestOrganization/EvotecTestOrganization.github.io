$svcPSProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/CubeAdmin.asmx?wsdl" -useDefaultCredential  
$cubeGUID = "00007829-4392-48b3-b533-5a5a4797e3c9"
$svcPSProxy.BuildOlapDatabase($cubeGUID)