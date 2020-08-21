# Project Server 2010/2013: Delete projects based on SQL query

## Original Links

- [x] Original Technet URL [Project Server 2010/2013: Delete projects based on SQL query](https://gallery.technet.microsoft.com/Server-20102013-Delete-e1e416bc)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-20102013-Delete-e1e416bc/description)
- [x] Download: [Download Link](Download\SOLVIN_EasyDeleteProjects.ps1)

## Output from Technet Gallery

```
<#
.SYNOPSIS
Delete a specified list of projects in Microsoft Project Server 2010 or 2013
.DESCRIPTION
The list of projects to be deleted is queried from the Reporting database (project database with 2013) by a query connecting to the standard view MSP_EMPProject_User_View
It can be filtered by any column contained in this view
After the list of Project UIDs is retrieved the script makes a connection to the PSI Projects WebService to initiate a delete of all the projects.
The delete requests enter the Project Server queue and will be executed there.
.PARAMETER ProjectServerURL
URL of the Project Server instance to be connected to (example: http://projectserver/pwa
.PARAMETER DatabaseServer
Name of the SQL Server (or database instance) containing the Reporting database (example: SQLSRV1\INSTANCE1)
.PARAMETER ProjectDB
Name of the ProjectServer Database (example: PWA_Reporting)
.PARAMETER WhereClause
WHERE CLAUSE to specify the list of projects to be deleted (optional Parameter). (example: "WHERE [PROJECT STATUS] = 'active' or [ProjectPercentCompleted] = 100"  (double quotes needed)
.EXAMPLE
.\SOLVIN_EasyDeleteProjects.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ProjectDB PWA_Reporting
Delete all projects
.NOTES
You need to have Read permissions to the Project Server Database and Project Server Administrative permissions to run this Script.
#>
#define parameters
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
    $ProjectDB
    ,
    [string]
    $WhereClause
   )
# connect to windows authentication using current username/password
$connection= new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database
$connection.ConnectionString ="server=$DatabaseServer;database=$ProjectDB;trusted_connection=True" # Connectiongstring setting for local machine database with window authentication
Write-host "connection information:"
$connection #List connection information
Write-host "connect to database successful."
$connection.open() #Connecting successful
#########query drop paths############################################################
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands
$SqlQuery = "SELECT [ProjectUID],projectname FROM [dbo].[MSP_EpmProject_UserView] puv $WhereClause " #setting query
$SqlCmd.CommandText = $SqlQuery # get query
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter #
$SqlAdapter.SelectCommand = $SqlCmd
$SqlCmd.Connection = $connection
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$connection.Close()
    $svcPSProxy = New-WebServiceProxy -uri "$ProjectServerURL/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
    $svcPSProxy
    foreach ($row in $DataSet.Tables[0])
    {
        if ($row.ItemArray.Count -gt 0)
        {
            Write-Host "Deleting project" $row[1]
            $projId = [System.Guid]$row[0]
            $svcPSProxy.QueueDeleteProjects([System.Guid]::NewGuid() , "true", $projId, "true")
        }
    }
```

On special request of a lady who wants to do some cleaning....

This script can be used to (bulk) delete projects from a Project Server 2010 or 2013 system.

List of projects comes out of the SQL database and can be tailored with a SQL query.

Project sites will also be deleted. Projects are deleted through the queue from draft and published database/tables. Archive versions will remain untouched.

Be careful !

