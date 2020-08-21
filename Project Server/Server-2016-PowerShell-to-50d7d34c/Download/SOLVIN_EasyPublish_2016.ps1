<#

.SYNOPSIS
Publishes a specified list of projects in Microsoft Project Server 2016

.DESCRIPTION
The list of projects to be published is queried from the Project Server database by a query connecting to the standard view MSP_EMPProject_User_View
It can be filtered by any column contained in this view.
After the list of Project UIDs is retrieved the script makes a connection to the Projectserver REST WebServices to initiate a Publish of all the projects.
The publish requests enter the Project Server queue and will be executed there.

.PARAMETER ProjectServerURL	
URL of the Project Server instance to be connected to (example: http://projectserver/pwa

.PARAMETER DatabaseServer
Name of the SQL Server (or database instance) containing the Reporting database (example: SQLSRV1\INSTANCE1)

.PARAMETER ProjectDB
Name of the Database containing the PWA site (example: WSS_Content_PWA)

.PARAMETER WhereClause
WHERE CLAUSE to specify the list of projects to be published (optional Parameter). There is already a WHERE CLAUSE hard coded into the script to exclude checked out projects so just use and AND or OR statement
(example: "AND ( [PROJECT STATUS] = 'active' or [ProjectPercentCompleted] = 100 )"  (double quotes needed)

.EXAMPLE
.\SOLVIN_EasyPublish.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ProjectDB WSS_Content_PWA
Full publish all projects already Published and currently checked in

.EXAMPLE
.\SOLVIN_EasyPublish.ps1 -FullPublish "false" -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -ProjectDB WSS_Content_PWA -WhereClause "AND ProjectPercentCompleted != 100"
Incremental publish of all projects that are not completed and currently checked in

.NOTES
You need to have Read permissions to the Project Database and Project Server Administrative permissions to run this Script. Do not use the Project Server service account for executing the query because it might be denied read access to the database.
Credit to Pranav Sharma http://www.pranavsharma.com/blog/2014/06/12/use-powershells-invoke-restmethod-with-the-sharepoint-2013-rest-api/ for his extremely helpful REST functions.
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
	$ProjectDB
    ,	
	[string]
	$WhereClause
   )
<#
  Copyright (c) Microsoft Corporation. All rights reserved. Licensed under the MIT license.
  See LICENSE in the project root for license information.
#>

$debug=$false
$headers = @{accept ="application/json; odata=verbose"}
$formDigest = $null
$url=$projectServerURL

function SetFormDigest() {
    $response = PostRequest ("/_api/contextinfo") $null
    $formDigest = $response.d.GetContextWebInformation.FormDigestValue
    $headers.Add("X-RequestDigest", $formDigest);
    if ($debug) {
        Write-Host "Form Digest: " $formDigest
    }
}
 
function Request ($endpoint, $body, $method) {
    if ($debug) {
        Write-Host "Endpoint: $endpoint, Method: $method, Cred:" $cred.UserName -BackgroundColor Green -ForegroundColor Black
        Write-Host "Header Keys:" $headers.Keys -BackgroundColor DarkGreen -ForegroundColor Gray
        Write-Host "Header Values:" $headers.Values -BackgroundColor DarkGreen -ForegroundColor Gray
        Write-Host "Body Keys:" $body.Keys -BackgroundColor DarkGreen -ForegroundColor Gray
        Write-Host "Body Values:" $body.Values -BackgroundColor DarkGreen -ForegroundColor Gray
    }
    return Invoke-RestMethod -Uri ($url+$endpoint) -Headers $headers -Method $method -Body $body -usedefaultcredential -ContentType "application/json;odata=verbose"
}
 
function GetRequest ($endpoint, $body) {
    return Request $endpoint $body ([Microsoft.PowerShell.Commands.WebRequestMethod]::Get)
}
 
function PostRequest ($endpoint, $body) {
    return Request $endpoint $body ([Microsoft.PowerShell.Commands.WebRequestMethod]::Post)
}


function PublishProject($projId) {
    Write-Host "Checking out project $projid"
    $response = PostRequest ("/_api/ProjectServer/Projects('$projid')/Draft/Publish(true)") $null 
}

function CheckoutProject($projId) {
    Write-Host "Publishing project $projid"
    $response = PostRequest ("/_api/ProjectServer/Projects('$projid')/Checkout()") $null 
}

	
# connect to windows authentication using current username/password 

$connection= new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database 
$connection.ConnectionString ="server=$DatabaseServer;database=$ProjectDB;trusted_connection=True" # Connectionstring setting for local machine database with window authentication 
Write-host "connection information:" 
$connection #List connection information 
Write-host "connect to database successful." 
$connection.open() #Connecting successful 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands 
$SqlQuery = "SELECT [ProjectUID],[projectname] FROM [pjrep].[MSP_EpmProject_UserView] puv inner join pjdraft.msp_projects dp on puv.projectuid=dp.proj_uid where dp.proj_checkoutby is NULL $WhereClause " #setting query
$SqlCmd.CommandText = $SqlQuery # get query 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter # 
$SqlAdapter.SelectCommand = $SqlCmd
$SqlCmd.Connection = $connection 
$DataSet = New-Object System.Data.DataSet 
$SqlAdapter.Fill($DataSet)  
$connection.Close() 



SetFormDigest 
    
   
	foreach ($row in $DataSet.Tables[0])
	{ 
		if ($row.ItemArray.Count -gt 0)
	    {
			Write-Host ""
            Write-Host "Working on project " $row[1]
            $projId = [System.Guid]$row[0]
            CheckoutProject($projid)
            PublishProject($projid)
		}
	}

