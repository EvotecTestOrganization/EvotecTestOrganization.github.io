# Project Server 2016: PowerShell to publish projects using SQL and RES

## Original Links

- [x] Original Technet URL [Project Server 2016: PowerShell to publish projects using SQL and RES](https://gallery.technet.microsoft.com/Server-2016-PowerShell-to-50d7d34c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2016-PowerShell-to-50d7d34c/description)
- [x] Download: [Download Link](Download\SOLVIN_EasyPublish_2016.ps1)

## Output from Technet Gallery

This version of a publish projects script is targeted for a Project Server 2016 on premises instance.

It will query the SQL database for a list of projects that should be published. I use SQL for easy selection of projects using various parameters like custom fields or last published date.

Then the script will checkout and publish each of the projects using REST webservice calls. This variant is necessary because the PSI projects webservice was removed in version 2016.

Problem is that while we had been able to publish a project using PSI no matter if it had been checked out or not, this is not possible using REST (or I have not found how ....). So we use only projects that are currently checked in.

Credit goes to Pranav Sharma for his great guide at http://pranavsharma.com/blog

