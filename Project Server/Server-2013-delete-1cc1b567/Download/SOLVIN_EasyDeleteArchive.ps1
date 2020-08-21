<# 
 
.SYNOPSIS 
Delete a specified list of projects in Microsoft Project Server 2013 
 
.DESCRIPTION 
The list of projects to be deleted is queried from the Archive and Reporting database by a query connecting to the standard view MSP_EMPProject_User_View 
It can be filtered by any column contained in this view or a column in the Archive Projects table (e.g. date of the version) 
After the list of Project UIDs is retrieved the script makes a connection to the PSI Projects WebService to initiate a delete of all the projects. 
The delete requests enter the Project Server queue and will be executed there. 
 
.PARAMETER ProjectServerURL     
URL of the Project Server instance to be connected to (example: http://projectserver/pwa 
 
.PARAMETER DatabaseServer 
Name of the SQL Server (or database instance) containing the Reporting database (example: SQLSRV1\INSTANCE1) 
 
.PARAMETER ReportingDB 
Name of the ProjectServer Database (example: PWA_Reporting) 
 
.PARAMETER WhereClause 
WHERE CLAUSE to specify the list of projects to be deleted (optional Parameter). (example: "WHERE [PROJECT STATUS] = 'active' or [ProjectPercentCompleted] = 100"  (double quotes needed) 
 
.EXAMPLE 
.\SOLVIN_EasyDeleteArchive.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting 
Delete all archive versions 
 
.EXAMPLE 
.\SOLVIN_EasyDeleteArchive.ps1 -FullPublish "false" -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting -WhereClause "WHERE vp.mod_date <'2010-01-01'" 
Delete all versions from before that date 
 
.NOTES 
You need to have Read permissions to the Project Server Database and Project Server Administrative permissions to run this Script. 
 
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
 
#####################################################################  
 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands  
 
$SqlQuery = "SELECT [ProjectUID],proj_uid,projectname,PROJ_VERSION_DATE FROM [dbo].[MSP_EpmProject_UserView] puv inner join ver.msp_projects vp on puv.projectuid=vp.proj_version_uid $WhereClause " #setting query   
 
$SqlCmd.CommandText = $SqlQuery # get query  
 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter #  
 
$SqlAdapter.SelectCommand = $SqlCmd 
 
$SqlCmd.Connection = $connection  
 
$DataSet = New-Object System.Data.DataSet  
 
$SqlAdapter.Fill($DataSet)   
 
$connection.Close()  
 
    $svcPSProxy = New-WebServiceProxy -uri "$ProjectServerURL/_vti_bin/PSI/Archive.asmx?wsdl" -useDefaultCredential 
    $svcPSProxy 
 
    foreach ($row in $DataSet.Tables[0]) 
    {  
        if ($row.ItemArray.Count -gt 0) 
        { 
            Write-Host "Deleting project" $row[2] "version from " $row[3] 
            #parameters are documented in wrong order. we need to have the archive id first and then the project id 
            $projId = [System.Guid]$row[1] 
            $archiveId = [System.Guid]$row[0] 
            $svcPSProxy.QueueDeleteArchivedProject([System.Guid]::NewGuid() , $projId, $archiveId) 
        } 
    } 
