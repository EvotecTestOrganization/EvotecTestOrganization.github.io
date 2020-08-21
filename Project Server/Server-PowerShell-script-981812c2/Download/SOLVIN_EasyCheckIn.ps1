<#

.SYNOPSIS
Forces a Checkin of all projects in Microsoft Project Server 2010

.DESCRIPTION
The list of currently checkedout projects is queried from the Draft database.
After the list of Project UIDs is retrieved the script makes a connection to the PSI Projects WebService to initiate Force Checkin of all the projects.
The Checkin requests enter the Project Server queue and will be executed there.

.PARAMETER ProjectServerURL	
URL of the Project Server instance to be connected to (example: http://projectserver/pwa

.PARAMETER DatabaseServer
Name of the SQL Server (or database instance) containing the Draft database (example: SQLSRV1\INSTANCE1)

.PARAMETER DraftDB
Name of the Draft Database (example: PWA_Draft)

.EXAMPLE
.\SOLVIN_EasyCheckin.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -DraftDB PWA_Draft
Force CheckIn all projects currently checked out

.NOTES
You need to have Read permissions to the Draft Database and Project Server Administrative permissions to run this Script.

#>


#######define parameters
PARAM(
    [parameter(Mandatory=$true)]
	[string] 
	$ProjectServerURL 
	,
	[parameter(Mandatory=$true)]
	[string] 
	$DatabaseServer 
	,
	[parameter(Mandatory=$true)]
	[string] 
	$DraftDB 
   )

#connect to database with current userid / password

$connection= new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database 

$connection.ConnectionString ="server=$Databaseserver;database=$DraftDB;trusted_connection=True" # Connectiongstring setting for local machine database with window authentication 

Write-host "connection information:" 

$connection #List connection information 

Write-host "connect to database successful." 

$connection.open() #Connecting successful 

#########query drop paths############################################################ 

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands 

$SqlQuery = "SELECT [Proj_UID] FROM [dbo].[MSP_projects] WHERE proj_checkoutby is not null and proj_type in (0,5,6)" #setting query "get drop paths"  

$SqlCmd.CommandText = $SqlQuery # get query 

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter # 

$SqlAdapter.SelectCommand = $SqlCmd

$SqlCmd.Connection = $connection 

$DataSet = New-Object System.Data.DataSet 

$SqlAdapter.Fill($DataSet)  

$connection.Close() 

	$svcPSProxy = New-WebServiceProxy -uri "$ProjectServerURL/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential

	foreach ($row in $DataSet.Tables[0])
	{ 
		if ($row.ItemArray.Count -gt 0)
	    {
			Write-Host "Checkin Project " + $row[0]
			$projId = [System.Guid]$row[0]
			$svcPSProxy.QueueCheckInProject([System.Guid]::NewGuid() , $projId, "true",[System.Guid]::NewGuid(),"SOLVIN Easy CheckIn")
		}
	}
