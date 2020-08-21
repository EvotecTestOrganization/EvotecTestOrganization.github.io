<#

.SYNOPSIS
    Checks the Project Server Queue for unsuccessful Project jobs

.DESCRIPTION
    This script will check the Project Server Queue for any unsuccessful Project jobs in the specified time-period, and send an email if more than then minimum specified number of 
    unsuccessful jobs is reached.  The email contains a simple summary of the details of each unsuccessful job.  The script can be run as a repeating scheduled task to provide
    continuous monitoring of the Project Server Queue.
    It works by querying the Project Server Draft database directly and does not use the PSI Web Services.  It does not query for Timesheet queue jobs, only Project jobs.
    
.PARAMETER TimeInHours
    The number of hours past in which to check the queue jobs.  The default is the last 24 hours.

.PARAMETER MinJobCount
    The minimum number of unsuccessful jobs.  If the number of unsuccessful jobs reaches this number or higher, an email will be sent.  The default is 5.

.EXAMPLE
    .\Monitor-ProjectServerQueue.ps1
    This will check the Project Server Queue jobs for the last 24 hours and if there are 5 or more unsuccessful jobs, an email will be sent.

.EXAMPLE
    .\Monitor-ProjectServerQueue.ps1 -TimeInHours 48 -MinJobCount 10
    This will check the Project Server Queue jobs for the last 48 hours and if there are 10 or more unsuccessful jobs, an email will be sent.

.NOTES
    Script name: Monitor-ProjectServerQueue.ps1
    Author:      Trevor Jones
    Version:     1.1
    Contact:     @trevor_smsagent
    DateCreated: 2015-01-06
    *Change History*
        v1.1     (2015-01-20) - Added a line to the SQL query to also query for jobs that do not have a completion date, as this can be an indicator of a problem with the queue.
                                Updated query to pull only jobs where the created and completed dates or within the minimum time period. This avoids sending multiple emails where there
                                are a number of older jobs that have been manually cancelled but are still visible in the queue by their recent completion date.
        v1.0     (2015-01-06) - Initial version
.LINK
    https://smsagent.wordpress.com/2015/01/06/monitoring-the-project-server-job-queue-with-powershell/

#>


[CmdletBinding()]
    param
        (
        [Parameter(Mandatory=$False, HelpMessage="The number of hours past in which to check the queue jobs")]
            [int]$TimeInHours = "24",
        [Parameter(Mandatory=$False, HelpMessage="The minimum number of unsuccessful jobs")]
            [int]$MinJobCount = "5"
        )

 
# Database info
$dataSource = “mysqlserver\myinstance”
$database = “PS_2010_PWA_DRAFT_DB”

# Mail settings
$smtpserver =  "mysmtpserver"
$MailSubject = "Project Server Queue Unsuccessful Jobs"
$MailRecipients = "joe.bloggs@mycompany.com"
$FromAddress = "ProjectServer@mycompany.com"

# Location of temp file for email message body (will be removed after)
$msgfile = 'c:\temp\mailmessage.txt'

$ErrorActionPreference = "Stop"

#region Functions
function New-Table (
$Title,
$Topic1,
$Topic2,
$Topic3,
$Topic4,
$Topic5,
$Topic6,
$Topic7,
$Topic8

)
{ 
       Add-Content $msgfile "<style>table {border-collapse: collapse;font-family: ""Trebuchet MS"", Arial, Helvetica, sans-serif;}"
       Add-Content $msgfile "h2 {font-family: ""Trebuchet MS"", Arial, Helvetica, sans-serif;}"
       Add-Content $msgfile "th, td {font-size: 1em;border: 1px solid #87ceeb;padding: 3px 7px 2px 7px;}"
       Add-Content $msgfile "th {font-size: 1.2em;text-align: left;padding-top: 5px;padding-bottom: 4px;background-color: #87ceeb;color: #ffffff;}</style>"
       Add-Content $msgfile "<h2>$Title</h2>"
       Add-Content $msgfile "<p><table>"
       Add-Content $msgfile "<tr><th>$Topic1</th><th>$Topic2</th><th>$Topic3</th><th>$Topic4</th><th>$Topic5</th><th>$Topic6</th><th>$Topic7</th><th>$Topic8</th></tr>"
}

function New-TableRow (
$col1, 
$col2,
$col3,
$col4,
$col5,
$col6,
$col7,
$col8

)
{
Add-Content $msgfile "<tr><td>$col1</td><td>$col2</td><td>$col3</td><td>$col4</td><td>$col5</td><td>$col6</td><td>$col7</td><td>$col8</td></tr>"
}

function New-TableEnd {
Add-Content $msgfile "</table></p>"}
#endregion

# Open a SQL connection
cls
try 
    {
        Write-host "Opening a connection to '$database' on '$dataSource'"
        # ConnectionString for integrated authentication
            $connectionString = “Server=$dataSource;Database=$database;Integrated Security=SSPI;”
        # ConnectionString for SQL authentication
            #$connectionString = "Server=$dataSource;Database=$database;uid=ProjServer_Read;pwd=Pa$$w0rd;Integrated Security=false"
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString
        $connection.Open()
    }
 catch
    { write-host "$($_.Exception.Message)" -ForegroundColor Red }

# Set the SQL query
$query = "

SELECT DISTINCT QPG.GRP_QUEUE_ID as 'Queue ID',
case when qpg.GRP_QUEUE_STATE = 8 then 'Blocked Due To A Failed Job'
 when qpg.GRP_QUEUE_STATE = 9 then 'Cancelled'
 when qpg.GRP_QUEUE_STATE = 5 then 'Failed And Blocking Correlation'
 when qpg.GRP_QUEUE_STATE = 6 then 'Failed But Not Blocking Correlation'
 when qpg.GRP_QUEUE_STATE = 2 then 'Getting Queued'
 when qpg.GRP_QUEUE_STATE = 3 then 'Processing'
 when qpg.GRP_QUEUE_STATE = 7 then 'Skipped For Optimization'
 when qpg.GRP_QUEUE_STATE = 4 then 'Success'
 when qpg.GRP_QUEUE_STATE = 1 then 'Waiting To Be Processed'
 when qpg.GRP_QUEUE_STATE = 10 then 'Waiting to be Processed (On Hold)'
 when qpg.GRP_QUEUE_STATE = 12 then 'Waiting to be Processed (Ready for Launch)'
 when qpg.GRP_QUEUE_STATE = 11 then 'Waiting to be Processed (Sleeping)'
End as 'Job State',

case when qpg.GRP_QUEUE_MESSAGE_TYPE = 2 then 'Active Directory Sync (Enterprise Resource Pool)'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 3 then 'Active Directory Sync (Group)'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 92 then 'Analysis Create'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 91 then 'Analysis Delete'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 93 then 'Analysis Update'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 20 then 'Archive and Delete Project'
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 5 then 'Archive Custom Fields '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 6 then 'Archive Global Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 19 then 'Archive Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 9 then 'Archive Project Web App Views '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 7 then 'Archive Resources '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 4 then 'Archive Security Categories '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 8 then 'Archive System Settings '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 106 then 'Change Workflow '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 101 then 'Exchange Server Task Sync '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 11 then 'Internal (CBS Project Rendezvous) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 13 then 'Internal (CBS Timesheet Rendezvous) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 75 then 'Internal (Timer Message) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 76 then 'Internal (Timer Rendezvous Notify) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 77 then 'Internal (Timer Rendezvous Project ) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 78 then 'Internal (Timer Rendezvous Timesheet) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 65 then 'Internal (Timer1) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 66 then 'Internal (Timer10) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 67 then 'Internal (Timer2) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 68 then 'Internal (Timer3) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 69 then 'Internal (Timer4) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 70 then 'Internal (Timer5) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 71 then 'Internal (Timer6) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 72 then 'Internal (Timer7) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 73 then 'Internal (Timer8) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 74 then 'Internal (Timer9) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 18 then 'Notifications '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 12 then 'OLAP Database Build '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 96 then 'Optimizer Portfolio Selection Scenario Create '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 97 then 'Optimizer Portfolio Selection Scenario Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 94 then 'Planner Portfolio Selection Scenario Create '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 95 then 'Planner Portfolio Selection Scenario Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 10 then 'Priority Bump '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 21 then 'Project Checkin '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 22 then 'Project Create '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 23 then 'Project Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 100 then 'Project Detail Pages Update Project Impact Values '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 24 then 'Project Publish '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 30 then 'Project Publish Notifications '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 107 then 'Project Publish Summary '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 25 then 'Project Rename '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 1 then 'Project Save from Project Professional '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 15 then 'Project Site Create '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 16 then 'Project Site Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 86 then 'Project Site Membership Synchronization '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 28 then 'Project Update from PSI '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 29 then 'Project Update Team '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 105 then 'Project Workflow Check-in '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 114 then 'Project Workflow Commit '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 31 then 'Queue Cleanup '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 102 then 'Reporting (Attribute Departments Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 32 then 'Reporting (Attribute Settings Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 33 then 'Reporting (Base Calendar Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 113 then 'Reporting (Committed Portfolio Selection Scenarios Decision Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 34 then 'Reporting (Custom Field Metadata Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 110 then 'Reporting (Enterprise Project Type and Workflow Information Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 111 then 'Reporting (Enterprise Project Type Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 35 then 'Reporting (Entity User View Refresh) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 36 then 'Reporting (Fiscal Periods Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 85 then 'Reporting (Global Data Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 37 then 'Reporting (Lookup Table Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 108 then 'Reporting (OLAP Database Settings Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 38 then 'Reporting (Project Delete) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 39 then 'Reporting (Project Publish) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 112 then 'Reporting (Project Summary Publish) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 49 then 'Reporting (Project Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 41 then 'Reporting (Resource Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 40 then 'Reporting (Resources Capacity Range Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 45 then 'Reporting (Time Reporting Period Delete) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 46 then 'Reporting (Time Reporting Period Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 42 then 'Reporting (Timesheet Adjust) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 115 then 'Reporting (Timesheet Assignments Refresh) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 104 then 'Reporting (Timesheet Assignments Upgrade) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 43 then 'Reporting (Timesheet Class Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 44 then 'Reporting (Timesheet Delete) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 103 then 'Reporting (Timesheet Project Aggregation) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 47 then 'Reporting (Timesheet Save) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 48 then 'Reporting (Timesheet Status Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 109 then 'Reporting (Workflow Metadata Sync) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 88 then 'Reporting Database Refresh '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 50 then 'Resource Plan Checkin '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 51 then 'Resource Plan Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 52 then 'Resource Plan Publish '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 53 then 'Resource Plan Save '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 55 then 'Restore Custom Fields '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 56 then 'Restore Global Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 26 then 'Restore Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 59 then 'Restore Project Web App Views '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 57 then 'Restore Resources '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 54 then 'Restore Security Categories '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 58 then 'Restore System Settings '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 90 then 'Start Workflow '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 64 then 'Status Update '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 61 then 'Status Update Rules (Auto-run Rules) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 60 then 'Status Update Rules (Process All) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 62 then 'Status Update Rules (Run All Rules) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 63 then 'Status Update Rules (Run Single Rule) '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 80 then 'Timesheet Delete '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 98 then 'Timesheet Line Approval '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 79 then 'Timesheet Message '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 81 then 'Timesheet Recall '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 82 then 'Timesheet Review '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 83 then 'Timesheet Submit '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 84 then 'Timesheet Update '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 119 then 'Timesheet Update Resource '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 116 then 'Update Project Site Path '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 120 then 'Update Scheduled Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 89 then 'Update Scheduled Project '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 117 then 'User Synchronization (Add Operation) for Project Web App App Root Site and Project Sites '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 118 then 'User Synchronization (Delete Operation) for Project Web App App Root Site and Project Sites '
 when qpg.GRP_QUEUE_MESSAGE_TYPE = 87 then 'User Synchronization for Project Web App App Root Site and Project Sites '
End as 'Job Type',

RES.RES_NAME as 'Resource Name',
QPG.GRP_QUEUE_PRIORITY as 'Queue Priority',
QPG.PERCENT_COMPLETE as 'Percent Complete',
QPG.CREATED_DATE as 'Entry Time',
QPG.COMPLETED_DATE as 'Completed Time'

from dbo.MSP_QUEUE_PROJECT_GROUP_FULL_VIEW QPG (NOLOCK)

left outer join dbo.MSP_PROJECT_RESOURCES_PUBLISHED_VIEW RES (NOLOCK) on qpg.RES_UID = RES.RES_UID
Where (QPG.GRP_QUEUE_STATE <> 4 
and (DATEDIFF(hour,QPG.COMPLETED_DATE,GETDATE()) < '$TimeInHours' and DATEDIFF(hour,QPG.CREATED_DATE,GETDATE()) < '$TimeInHours'))
or (QPG.COMPLETED_DATE is null)
ORDER BY qpg.COMPLETED_DATE Desc
"

# Execute the SQL query and store results in a table 
Write-host "Executing SQL query..."
try
    {
        $command = $connection.CreateCommand()
        $command.CommandText = $query
        $result = $command.ExecuteReader()
        $table = new-object “System.Data.DataTable”
        $table.Load($result)
    }
catch
    { write-host "$($_.Exception.Message)" -ForegroundColor Red }

# Close the connection
$connection.Close()

write-host "$($table.Rows.Count) unsuccessful job/s found"

# If minimum number of unsuccessful jobs reached...
if ($table.Rows.Count -ge $MinJobCount)
    {
        # Create file
        New-Item $msgfile -ItemType file -Force | Out-Null

        # Add html header
        Add-Content $msgfile "<style>h2 {font-family: ""Trebuchet MS"", Arial, Helvetica, sans-serif;}</style>"
        Add-Content $msgfile "<h3>There are currently $($table.Rows.Count) unsuccessful Project jobs in the Project Server Queue in the last $($TimeInHours) hours.</h3>"
        Add-Content $msgfile "<p></p>"
        
        # Create a new html table
        New-Table -Title "Project Server Queue Unsuccessful Jobs" -Topic1 "Queue ID" -Topic2 "Job State" -Topic3 "Job Type" -Topic4 "Resource Name" -Topic5 "Queue Priority" -Topic6 "Percent Complete" -Topic7 "Entry Time" -Topic8 "Completed Time"
        
        # Populate table rows with each unsuccessful job
        foreach ($row in $table.rows)
            {
                $QueueID = $row.'Queue ID' | Out-String
                $JobState = $row.'Job State' | Out-String
                $JobType = $row.'Job Type' | Out-String
                $ResourceName = $row.'Resource Name' | Out-String
                $QueuePriority = $row.'Queue Priority' | Out-String
                $PercentComplete = $row.'Percent Complete' | Out-String
                $EntryTime = $row.'Entry Time' | Out-String
                $CompletedTime = $row.'Completed Time' | Out-string
        
                New-TableRow -col1 $QueueID -col2 $JobState -col3 $JobType -col4 $ResourceName -col5 $QueuePriority -col6 $PercentComplete -col7 $EntryTime -col8 $CompletedTime
            }
        # Add html table to file
        New-TableEnd

        # Set email body content
        $mailbody = Get-Content $msgfile

        # Send email
        try
            {
                Send-MailMessage -Body "$mailbody" -From $FromAddress -to $MailRecipients -SmtpServer $smtpserver -Subject $MailSubject -BodyAsHtml 
            }
        catch
            { write-host "$($_.Exception.Message)" -ForegroundColor Red }
        
        # Delete tempfile 
        Remove-Item $msgfile
    }