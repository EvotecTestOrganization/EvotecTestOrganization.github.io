# Automate the Management of Checked-out Projects in Project Server

## Original Links

- [x] Original Technet URL [Automate the Management of Checked-out Projects in Project Server](https://gallery.technet.microsoft.com/Automate-the-Management-of-23a1d5d3)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Automate-the-Management-of-23a1d5d3/description)
- [x] Download: [Download Link](Download\Handle-CheckedoutProjects.ps1)

## Output from Technet Gallery

This script will automate the management of checked-out Projects in Project Server.  It will check the Project Server database for a list of currently checked-out Projects, then send an email to each person who has a Project checked-out longer than  x days (7 by default).  If the Project has been checked-out longer than y days (28 by default), then we force the check-in of the Project and notify the person who had it checked out by email.

This script can be run as a scheduled task to automate the management of checked-out Projects.

Full details on my blog: https://smsagent.wordpress.com/2015/02/17/automating-the-management-of-checked-out-projects-in-project-server/

