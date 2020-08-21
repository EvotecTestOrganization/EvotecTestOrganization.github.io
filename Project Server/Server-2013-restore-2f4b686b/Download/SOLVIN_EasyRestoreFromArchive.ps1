<# 
 
.SYNOPSIS 
Restores a specified list of projects from archive to draft tables in Microsoft Project Server 2013
 
.DESCRIPTION 
The list of projects to be restored is queried from the Project Server database by a query connecting to the standard ver.msp_projects table. 
It can be filtered by any column contained in the Archive Projects table (e.g. date of the version) 
After the list of Project UIDs is retrieved the script makes a connection to the PSI Projects WebService to initiate a restore of all the projects. 
The restore requests enter the Project Server queue and will be executed there. 
 
.PARAMETER ProjectServerURL     
URL of the Project Server instance to be connected to (example: http://projectserver/pwa 
 
.PARAMETER DatabaseServer 
Name of the SQL Server (or database instance) containing the database (example: SQLSRV1\INSTANCE1) 
 
.PARAMETER ReportingDB 
Name of the ProjectServer Database (example: PWA_Reporting) 
 
.PARAMETER WhereClause 
WHERE CLAUSE to specify the list of projects to be restored (optional Parameter). (example: "WHERE proj_name like '%Test%' "  (double quotes needed) 
 
.EXAMPLE 
.\SOLVIN_EasyRestoreFromArchive.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting -WhereClause "WHERE proj_name like '%Test%'" 
Restore the last version of all projects containing "Test" in the name
 
.EXAMPLE 
.\SOLVIN_EasyRestoreFromArchive.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ReportingDB PWA_Reporting -WhereClause "WHERE maxdate <'2015-01-01'" 
Restore the last version of all projects that have been last written to archive before that date
 
.NOTES 
You need to have Read permissions to the Project Server Database and Project Server Administrative permissions to run this Script. 
Integrated SQL query will read only the newest version of each project and will limit to projects that still exist in the draft database. Can be modified as needed.
 
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
 
$SqlQuery = "select archiv.proj_name,max.maxdate,max.proj_version_uid,archiv.proj_uid  from
(
select proj_version_uid,max(proj_version_date) as maxdate from ver.msp_projects 
group by proj_version_uid
)as max
inner join ver.msp_projects as archiv
on max.proj_version_uid=archiv.proj_version_uid and max.maxdate=archiv.proj_version_date
inner join draft.msp_projects as draft on draft.proj_uid=archiv.proj_version_uid
 $WhereClause " #setting query   
 
$SqlCmd.CommandText = $SqlQuery # get query  
 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter #  
 
$SqlAdapter.SelectCommand = $SqlCmd 
 
$SqlCmd.Connection = $connection  
 
$DataSet = New-Object System.Data.DataSet  
 
$SqlAdapter.Fill($DataSet)   
 
$connection.Close()  
 
    $svcPSProxy = New-WebServiceProxy -uri "$ProjectServerURL/_vti_bin/PSI/Archive.asmx?wsdl" -useDefaultCredential 
     
    foreach ($row in $DataSet.Tables[0]) 
    {  
        if ($row.ItemArray.Count -gt 0) 
        { 
            Write-Host "Restoring project" $row[0] "version from " $row[1] 
            $projId = [System.Guid]$row[3] 
            $archiveId = [System.Guid]$row[2] 
            $svcPSProxy.QueueRestoreProject([System.Guid]::NewGuid() , $archiveId, $projId) 
        } 
    } 
