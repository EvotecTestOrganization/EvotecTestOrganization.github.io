# Monitor Project Server Queue from data

## Original Links

- [x] Original Technet URL [Monitor Project Server Queue from data](https://gallery.technet.microsoft.com/Monitor-Server-Queue-from-44555dc1)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Monitor-Server-Queue-from-44555dc1/description)
- [x] Download: Not available.

## Output from Technet Gallery

SQL

```
-- CODE BY PLANSIS.NL
SELECT DISTINCT QPG.GRP_QUEUE_ID as 'Queue ID',
 case when qpg.GRP_QUEUE_STATE = 8 then 'Blocked Due To A Failed Job'
  when qpg.GRP_QUEUE_STATE = 9 then 'Cancelled'
  when qpg.GRP_QUEUE_STATE = 5 then 'Failed And Blocking Correlation'
  when qpg.GRP_QUEUE_STATE = 6 then 'Failed But Not Blocking Correlation'
  when qpg.GRP_QUEUE_STATE = 2 then 'Getting Queued'
  when qpg.GRP_QUEUE_STATE = 3 then 'Processing'
  when qpg.GRP_QUEUE_STATE = 7 then 'Skipped For Optimization'
  when qpg.GRP_QUEUE_STATE = 4 then 'Success'
  when qpg.GRP_QUEUE_STATE = 1 then 'Waiting To Be Processed'
  when qpg.GRP_QUEUE_STATE = 10 then 'Waiting to be Processed (On Hold)'
  when qpg.GRP_QUEUE_STATE = 12 then 'Waiting to be Processed (Ready for Launch)'
  when qpg.GRP_QUEUE_STATE = 11 then 'Waiting to be Processed (Sleeping)'
 End as 'Job State',
  case
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 1 then 'Project Save from Project Professional '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 2 then 'Active Directory Sync (Enterprise Resource Pool)'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 3 then 'Active Directory Sync (Group)'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 5 then 'Archive Custom Fields '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 6 then 'Archive Global Project '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 7 then 'Archive Resources '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 8 then 'Archive System Settings '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 9 then 'Archive Project Web App Views '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 4 then 'Archive Security Categories '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 10 then 'Priority Bump '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 11 then 'Internal (CBS Project Rendezvous) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 12 then 'OLAP Database Build '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 13 then 'Internal (CBS Timesheet Rendezvous) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 15 then 'Project Site Create '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 16 then 'Project Site Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 18 then 'Notifications '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 19 then 'Archive Project '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 20 then 'Archive and Delete Project'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 21 then 'Project Checkin '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 22 then 'Project Create '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 23 then 'Project Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 24 then 'Project Publish '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 25 then 'Project Rename '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 28 then 'Project Update from PSI '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 29 then 'Project Update Team '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 30 then 'Project Publish Notifications '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 31 then 'Queue Cleanup '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 32 then 'Reporting (Attribute Settings Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 33 then 'Reporting (Base Calendar Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 34 then 'Reporting (Custom Field Metadata Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 35 then 'Reporting (Entity User View Refresh) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 36 then 'Reporting (Fiscal Periods Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 37 then 'Reporting (Lookup Table Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 38 then 'Reporting (Project Delete) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 39 then 'Reporting (Project Publish) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 49 then 'Reporting (Project Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 41 then 'Reporting (Resource Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 40 then 'Reporting (Resources Capacity Range Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 42 then 'Reporting (Timesheet Adjust) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 43 then 'Reporting (Timesheet Class Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 44 then 'Reporting (Timesheet Delete) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 45 then 'Reporting (Time Reporting Period Delete) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 46 then 'Reporting (Time Reporting Period Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 47 then 'Reporting (Timesheet Save) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 48 then 'Reporting (Timesheet Status Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 50 then 'Resource Plan Checkin '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 51 then 'Resource Plan Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 52 then 'Resource Plan Publish '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 53 then 'Resource Plan Save '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 55 then 'Restore Custom Fields '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 56 then 'Restore Global Project '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 26 then 'Restore Project '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 59 then 'Restore Project Web App Views '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 57 then 'Restore Resources '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 54 then 'Restore Security Categories '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 58 then 'Restore System Settings '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 60 then 'Status Update Rules (Process All) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 61 then 'Status Update Rules (Auto-run Rules) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 62 then 'Status Update Rules (Run All Rules) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 63 then 'Status Update Rules (Run Single Rule) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 64 then 'Status Update '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 65 then 'Internal (Timer1) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 66 then 'Internal (Timer10) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 67 then 'Internal (Timer2) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 68 then 'Internal (Timer3) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 69 then 'Internal (Timer4) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 70 then 'Internal (Timer5) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 71 then 'Internal (Timer6) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 72 then 'Internal (Timer7) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 73 then 'Internal (Timer8) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 74 then 'Internal (Timer9) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 75 then 'Internal (Timer Message) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 76 then 'Internal (Timer Rendezvous Notify) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 77 then 'Internal (Timer Rendezvous Project ) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 78 then 'Internal (Timer Rendezvous Timesheet) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 79 then 'Timesheet Message '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 80 then 'Timesheet Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 81 then 'Timesheet Recall '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 82 then 'Timesheet Review '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 83 then 'Timesheet Submit '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 84 then 'Timesheet Update '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 85 then 'Reporting (Global Data Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 86 then 'Project Site Membership Synchronization '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 87 then 'User Synchronization for Project Web App App Root Site and Project Sites '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 88 then 'Reporting Database Refresh '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 89 then 'Update Scheduled Project '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 90 then 'Start Workflow '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 91 then 'Analysis Delete'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 92 then 'Analysis Create'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 93 then 'Analysis Update'
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 94 then 'Planner Portfolio Selection Scenario Create '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 95 then 'Planner Portfolio Selection Scenario Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 96 then 'Optimizer Portfolio Selection Scenario Create '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 97 then 'Optimizer Portfolio Selection Scenario Delete '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 98 then 'Timesheet Line Approval '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 100 then 'Project Detail Pages Update Project Impact Values '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 101 then 'Exchange Server Task Sync '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 102 then 'Reporting (Attribute Departments Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 103 then 'Reporting (Timesheet Project Aggregation) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 104 then 'Reporting (Timesheet Assignments Upgrade) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 105 then 'Project Workflow Check-in '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 106 then 'Change Workflow '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 107 then 'Project Publish Summary '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 108 then 'Reporting (OLAP Database Settings Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 109 then 'Reporting (Workflow Metadata Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 110 then 'Reporting (Enterprise Project Type and Workflow Information Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 111 then 'Reporting (Enterprise Project Type Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 112 then 'Reporting (Project Summary Publish) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 113 then 'Reporting (Committed Portfolio Selection Scenarios Decision Sync) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 114 then 'Project Workflow Commit '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 115 then 'Reporting (Timesheet Assignments Refresh) '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 116 then 'Update Project Site Path '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 117 then 'User Synchronization (Add Operation) for Project Web App App Root Site and Project Sites '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 118 then 'User Synchronization (Delete Operation) for Project Web App App Root Site and Project Sites '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 119 then 'Timesheet Update Resource '
  when qpg.GRP_QUEUE_MESSAGE_TYPE = 120 then 'Update Scheduled Project '
 End as 'Job Type',
 P.PROJ_NAME ,
 RES.RES_NAME as 'Resource Name',
 QPG.GRP_QUEUE_PRIORITY as 'Queue Priority',
 QPG.PERCENT_COMPLETE as 'Percent Complete',
 QPG.CREATED_DATE as 'Entry Time',
 QPG.COMPLETED_DATE as 'Completed Time'
 ,datediff(s, QPG.[CREATED_DATE] ,QPG.processing_date) as WAITTIME_SEC
 ,datediff(s, QPG.processing_date ,QPG.[COMPLETED_DATE]) as DURATION_SEC
 from dbo.MSP_QUEUE_PROJECT_GROUP_FULL_VIEW QPG (NOLOCK)
 left outer join dbo.MSP_PROJECT_RESOURCES_PUBLISHED_VIEW RES (NOLOCK) on qpg.RES_UID = RES.RES_UID
 left outer join dbo.MSP_PROJECTS P on QPG.JOB_INFO_UID = P.PROJ_UID
 -- [Comment] use code below to apply extra filters such as Job status (see GRP_QUEUE_STATE codes)
 --Where QPG.GRP_QUEUE_STATE <> 4
 --and (DATEDIFF(hour,QPG.COMPLETED_DATE,GETDATE()) < 24 and DATEDIFF(hour,QPG.CREATED_DATE,GETDATE()) < '$TimeInHours'))
 --or (QPG.COMPLETED_DATE is null)
 ORDER BY qpg.COMPLETED_DATE Desc
```

Project Server 2010 and 2013 has a built in webpage to filter and view the project server queue jobs. But what if you want to keep this data for analysis or automated wornings?

The query below will let you get to the same data you see on the queue's webpage. The data comes from views in the DRAFT database. The major trick is to know that INFO\_UID is actually your PROJECT\_UID. Using this query you can easily filter on specific states  or messages (see the codes) . Use it to spot projects that take long to pubish. You can also spot errors that come from [GRP\_QUEUE\_ERROR\_INFO] field.

