# Auto notify to last week timesheets defaulter -PS2010

## Original Links

- [x] Original Technet URL [Auto notify to last week timesheets defaulter -PS2010](https://gallery.technet.microsoft.com/Auto-notify-to-last-week-a637ad53)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Auto-notify-to-last-week-a637ad53/description)
- [x] Download: [Download Link](Download\SP_SendTimesheetAlert.sql)

## Output from Technet Gallery

Ever need this kind of requirement to combine both type of resources (one who have not submitted and the other ones who have not created timesheets for last week) and notify them, use this script.

This stored procedure can be attached with SQL server agent job to execute it on first morning of new week so that all the concerned resources of last week will get a notification email with Timesheet Manager in cc.

**How to use** -

1. Download the script and change the database name to your PS environment’s reporting DB. Please note that DB profile to trigger database email should be pre-configured so that you can change the parameter name @profile\_name to as per your system.

2. Note **sp\_send\_dbmail** is a system defined stored procedure which is used by SQL Server to send email.

3. For more detail to configure database mail profile, account etc., you can find detailed instructions from [here](http://www.codeproject.com/Articles/485124/Configuring-Database-Mail-in-SQL-Server)

4. Once stored procedure script is ready with correct parameters values, execute it so that SP is stored in your system.

5. Now Go to SQL Server Agent and create new job to execute this script at scheduled time.Visit [here](https://msdn.microsoft.com/en-gb/library/ms187910%28v=sql.105%29.aspx) to check the instructions on how to create SQL agent jobs.

Note-Above steps need to be performed on Database server of your Project Server application.

Hope it helps

