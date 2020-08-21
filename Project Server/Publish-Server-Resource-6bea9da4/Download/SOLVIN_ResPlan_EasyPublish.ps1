<#

.SYNOPSIS
Publishes a specified list of projects in Microsoft Project Server 2010 or 2013

.DESCRIPTION
The list of projects to be published is queried from the Reporting database by a query connecting to the standard view MSP_EMPProject_User_View
It can be filtered by any column contained in this view.
After the list of Project UIDs is retrieved the script makes a connection to the PSI Projects WebService to initiate a ublish of all the resourceplans.
The publish requests enter the Project Server queue and will be executed there.

.PARAMETER ProjectServerURL	
URL of the Project Server instance to be connected to (example: http://projectserver/pwa

.PARAMETER DatabaseServer
Name of the SQL Server (or database instance) containing the Reporting database (example: SQLSRV1\INSTANCE1)

.PARAMETER ReportingDB
Name of the Reporting Database (example: PWA_Reporting)

.PARAMETER WhereClause
WHERE CLAUSE to specify the list of projects to be published (optional Parameter). (example: "WHERE [PROJECT STATUS] = 'active' or [ProjectPercentCompleted] = 100"  (double quotes needed)
You should always include "ResourcePlanUtilizationType is not NULL AND [EnterpriseProjectTypeUID] is not NULL" in the WHERE clause to get only projects that have a resourceplan and to filter out "Administrative Times"

.EXAMPLE
.\SOLVIN_ResPlan_EasyPublish.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting -whereclause "WHERE ResourcePlanUtilizationType is not NULL AND [EnterpriseProjectTypeUID] is not NULL "
Publish all projects already Published

.EXAMPLE
.\SOLVIN_ResPlan_EasyPublish.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting -WhereClause "WHERE ProjectPercentCompleted != 100 AND [EnterpriseProjectTypeUID] is not NULL AND ResourcePlanUtilizationType is not NULL"
Publish of all resource plans of projects that are not completed

.NOTES
You need to have Read permissions to the Reporting Database and Project Server Administrative permissions to run this Script.

#>


#define parameters
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
	$ReportingDB
    ,	
	[string]
	$WhereClause
   )
	
# connect to windows authentication using current username/password 

$connection= new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database 

$connection.ConnectionString ="server=$DatabaseServer;database=$ReportingDB;trusted_connection=True" # Connectiongstring setting for local machine database with window authentication 

Write-host "connection information:" 

$connection #List connection information 

Write-host "connect to database successful." 

$connection.open() #Connecting successful 

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands 

$SqlQuery = "SELECT [ProjectUID],[ProjectName] FROM [dbo].[MSP_EpmProject_UserView]  $WhereClause " #setting query""

$SqlCmd.CommandText = $SqlQuery # get query 

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter # 

$SqlAdapter.SelectCommand = $SqlCmd

$SqlCmd.Connection = $connection 

$DataSet = New-Object System.Data.DataSet 

$SqlAdapter.Fill($DataSet)  

$connection.Close() 

	$svcPSProxy = New-WebServiceProxy -uri "$ProjectServerURL/_vti_bin/PSI/ResourcePlan.asmx?wsdl" -useDefaultCredential

	foreach ($row in $DataSet.Tables[0])
	{ 
		if ($row.ItemArray.Count -gt 0)
	    {
			Write-Host "Publishing Resource Plan of Project " + $row[0] + $row[1]
			$projId = [System.Guid]$row[0]
			$svcPSProxy.CheckOutResourcePlans($projId)
			Start-Sleep -s 2
			$svcPSProxy.QueuePublishResourcePlan($projId,[System.Guid]::NewGuid()  )
			$svcPSProxy.QueueCheckInResourcePlans($projId ,$false,[System.Guid]::NewGuid())
			Start-Sleep -s 5
		}
	}
