	$svcPSProxy = New-WebServiceProxy -uri "http://YourEPMWebApp/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential 
	$EPMTYGUID = [system.guid]::empty
	$sqlConnection = new-object System.Data.SqlClient.SqlConnection "server=YourEPMDB;database=ProjectServerReporting;Integrated Security=SSPI"
	$sqlConnection.Open()
	#Create a command object
	$sqlCommand = $sqlConnection.CreateCommand()
	$sqlCommand.CommandText = "	SELECT ProjectUID,ProjectName,EnterpriseProjectTypeName
								FROM MSP_EpmProject_UserView EPU 
								INNER JOIN MSP_EpmEnterpriseProjectType ET 
								ON EPU.EnterpriseProjectTypeUID =ET.EnterpriseProjectTypeUID 
								WHERE ET.EnterpriseProjectTypeName IN ('A','B','C')"
	#Execute the Command
	$sqlReader = $sqlCommand.ExecuteReader()
	$Datatable = New-Object System.Data.DataTable
	$DataTable.Load($SqlReader)
	# Close the database connection
	$sqlConnection.Close()
		$DataTable|%{
		$G = [System.Guid]::NewGuid() 
		$G1 = [Guid]$_.ProjectUID
		$now = Get-Date -Format g
		Write-host "Project:" $_.ProjectName " publish is starting at " $now 
		$svcPSProxy.QueuePublish("$G", $G1, "true","")
	}           


