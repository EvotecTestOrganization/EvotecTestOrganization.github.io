# Project Server Queue Monitor

## Original Links

- [x] Original Technet URL [Project Server Queue Monitor](https://gallery.technet.microsoft.com/Server-Queue-Monitor-01bcdb74)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Queue-Monitor-01bcdb74/description)
- [x] Download: [Download Link](Download\Monitor-ProjectServerQueue.ps1)

## Output from Technet Gallery

This script can be used as a scheduled task to monitor the Project Server Job Queue for unsuccessful jobs.  The admin will receive an email when a minimum number of unsuccessful jobs is reached.  This allows a Project Server admin to be notified  of any issues with the queue without having to manually check in PWA.

More details on my blog: https://smsagent.wordpress.com/2015/01/06/monitoring-the-project-server-job-queue-with-powershell/

!UPDATE! 20-Jan-2015.  Updated the SQL query to also query for jobs without a completion date, as these can indicate a problem with the queue.

