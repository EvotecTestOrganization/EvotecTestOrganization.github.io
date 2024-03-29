USE [ProjectServerReporting]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SendTimesheetAlert]
AS
BEGIN
DECLARE @to varchar ( 70)
DECLARE @cc varchar ( 70)
DECLARE @recipient_name varchar ( 50)
DECLARE @weekdate varchar ( 11)
DECLARE @message varchar (1000)
DECLARE getResourceInfo CURSOR
FOR
--Fetching those resource who have not created timesheets for last week.
SELECT ERU.ResourceEmailAddress,ERU.ResourceName,ERU2.ResourceEmailAddress AS TimesheetManagerEmailAddress,
DATEADD(wk, DATEDIFF(wk, 6, CURRENT_TIMESTAMP), 6) As EndDate FROM	MSP_EpmResource_UserView ERU
INNER JOIN MSP_EpmResource_UserView ERU2 on ERU2.ResourceUID = ERU.ResourceTimesheetManagerUID
WHERE	
ERU.ResourceUID NOT IN 
	(SELECT	MSP_TimesheetResource.ResourceUID FROM MSP_Timesheet INNER JOIN MSP_TimesheetResource 
		ON MSP_Timesheet.OwnerResourceNameUID = MSP_TimesheetResource.ResourceNameUID 
		WHERE (MSP_Timesheet.PeriodUID =(SELECT PeriodUID FROM MSP_TimesheetPeriod
										 WHERE  Enddate BETWEEN DATEADD(WEEK,-1,CURRENT_TIMESTAMP) AND CURRENT_TIMESTAMP)))
AND ERU.ResourceType = 2 
AND ERU.ResourceIsActive = 1 
AND ERU.ResourceNTAccount IS NOT NULL 
AND ERU.ResourceIsGeneric = 0
UNION ALL
--Fetching those resources whose Timesheets are in 'In Progress' state for last week.
SELECT ERU.ResourceEmailAddress, ERU. ResourceName,ERU2.ResourceEmailAddress AS TimesheetManagerEmailAddress, 
CONVERT ( VARCHAR ( 11), EndDate) EndDate
FROM MSP_TimesheetPeriod_OlapView TPO inner join MSP_Timesheet_OlapView TOU on
TPO. PeriodUID  = TOU. PeriodUID 
INNER JOIN MSP_TimesheetResource_OlapView TRO on TOU. OwnerResourceNameUID = TRO. ResourceNameUID
INNER JOIN MSP_EpmResource_UserView ERU on TRO. ResourceUID = ERU. ResourceUID
INNER JOIN MSP_EpmResource_UserView ERU2 on ERU2.ResourceUID = ERU.ResourceTimesheetManagerUID
WHERE TimeSheetStatusId = 0 
AND   Enddate BETWEEN DATEADD(WEEK,-1,CURRENT_TIMESTAMP) AND CURRENT_TIMESTAMP
AND ERU.ResourceIsActive = 1
AND ERU.ResourceIsGeneric = 0
AND ERU.ResourceType = 2
AND ERU.ResourceNTAccount IS NOT NULL

OPEN getResourceInfo
FETCH NEXT FROM getResourceInfo
INTO @to, @recipient_name, @cc,@weekdate
WHILE @@FETCH_STATUS = 0
BEGIN
Select @message =  '<font face="calibri" color="black" size="3">Hi&nbsp'+@recipient_name+','+'<br><br>You have not submitted your EPM Timesheet for the week ending -<br/>'+@weekdate+'<br/><br>Thanks<br/>EPM Admin</font face>'
EXEC msdb. dbo. sp_send_dbmail
@profile_name ='MailProfile1', 
@recipients = @to,
@copy_recipients = @cc,
@subject = 'EPM Timesheet Delayed Alert' ,
@body = @message ,
@body_format = 'HTML',
@importance = 'High'
FETCH NEXT FROM getResourceInfo
INTO @to,@recipient_name, @cc,@weekdate
END
CLOSE getResourceInfo
DEALLOCATE getResourceInfo
END

