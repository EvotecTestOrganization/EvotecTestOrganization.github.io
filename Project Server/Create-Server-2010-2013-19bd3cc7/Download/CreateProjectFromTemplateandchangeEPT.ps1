#Get details for new project
$ProjName = Read-Host -Prompt "Enter the Name of the Project"
$ProjTempName = Read-Host -Prompt "Enter the Name of the Project Template"
$ProjEPTName = Read-Host -Prompt "Enter the Name of the EPT"
Write-host "The Project is called $ProjName"
#Create empty GUID
$EPMTYGUID = [system.guid]::empty
#Project PSI Web Service 
$svcPSProjProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
#Get the Project Template UID from the ReadProjectStatus Method
$projTempGuid = $svcPSProjProxy.ReadProjectStatus("$EPMTYGUID","WorkingStore",$ProjTempName, "0").Project | format-table proj_uid -hidetableheaders | out-string -stream
#Create the new project using the CreateProjectFromTemplate method
$NewProjGUID = $svcPSProjProxy.CreateProjectFromTemplate("$projTempGuid", $ProjName)
#Create a new GUID
$G = [System.Guid]::NewGuid()
#Publish the new project using the QueuePublish method
$svcPSProjProxy.QueuePublish("$G", "$NewProjGUID", "true","")
Write-host -ForegroundColor Green "********* $ProjName has now been created *********"
#update EPT for newly created project
#Create empty GUID
$EPMTYGUID = [system.guid]::empty 
#Workflow PSI Web Service
$svcPSWFProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/Workflow.asmx?wsdl" -useDefaultCredential
#Get the EPT UID from the ReadEnterpriseProjectTypeList Method
$EPTguid = $svcPSWFProxy.ReadEnterpriseProjectTypeList().EnterpriseProjectType | where {$_.ENTERPRISE_PROJECT_TYPE_NAME -eq "$ProjEPTName"} | format-table ENTERPRISE_PROJECT_TYPE_UID -hidetableheaders | out-string -stream
#Create a new GUID
$sessionGuid = [system.guid]::NewGuid()
#Check out project using the CheckOutProject method 
$svcPSProjProxy.CheckOutProject("$NewProjGUID", $sessionGuid, "")
#Update the project EPT using the UpdateProjectWorkflow method 
$svcPSWFProxy.UpdateProjectWorkflow("$NewProjGUID", "$EPTguid")
#Create two new GUIDs
$sessionGuid = [system.guid]::NewGuid()
$jobGuid = [system.guid]::NewGuid()
#Check in the project using the QueueCheckInProject method
$svcPSProjProxy.QueueCheckInProject( $jobGuid, "$NewProjGUID", "true", $sessionGuid, "")
Write-host -ForegroundColor Green "********* $ProjName has now been updated with the specified EPT *********"