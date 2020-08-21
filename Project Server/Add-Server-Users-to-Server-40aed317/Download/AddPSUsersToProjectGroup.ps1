function Add-PSUsersToProjectServerGroup
{
	param ($pwaUrl, $sGroupUID,$sUserToAdd)
	try {
		#Get RES_UID values to add 
		$values = Get-Content $sUserToAdd 
		$svcPSProxy = New-WebServiceProxy -uri "$pwaUrl/_vti_bin/PSI/Security.asmx?wsdl" -UseDefaultCredential
		$secGroup = $svcPSProxy.ReadGroup($sGroupUID)
		 
		foreach($value in $values) 
			{ 
				$secGroupRow = $secGroup.GroupMembers.NewGroupMembersRow()
				$secGroupRow.RES_UID = [System.Guid] $value
				$secGroupRow.WSEC_GRP_UID = $sGroupUID
				$secGroup.GroupMembers.AddGroupMembersRow($secGroupRow) 
			} 
		$error.clear() 
		Try 
			{ 
				$svcPSProxy.SetGroups($secGroup) 
			} 
		Catch  
			{ 
				write-host "Error updating the group, see the error below:" -ForeGroundColor Red -BackGroundColor White 
				write-host "$error" -ForeGroundColor Red 
			} 
		If ($error.count -eq 0)
		{ 
				Write-host "The group $sGroupUID has been updated with the values from the text file specified" -ForeGroundColor Green 
			} 
		Else 
			{ 
				Write-host "The group $sGroupUID has not been updated with the values from the text file specified, please see error" -ForeGroundColor Red -BackGroundColor White 
			} 
		$error.clear() 		


	}
		catch [System.Exception]
	{
		write-host -f red $_.Exception.ToString() 
	}
}


#Required Parameters
$pwaUrl = "<PWA URL>" 
$sGroupUID="<Group UID, e.g. a6d72f6e-820b-e511-9424-00155d0a0c10"
$sUserToAdd = ".\UserUIDs.txt"

Add-PSUsersToProjectServerGroup -pwaUrl $pwaUrl -sGroupUID $sGroupUID -sUserToAdd $sUserToAdd