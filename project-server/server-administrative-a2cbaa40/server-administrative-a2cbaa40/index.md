# Project Server: Administrative backup on a custom schedul

## Original Links

- [x] Original Technet URL [Project Server: Administrative backup on a custom schedul](https://gallery.technet.microsoft.com/Server-Administrative-a2cbaa40)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Administrative-a2cbaa40/description)
- [x] Download: [Download Link](Download\ProjectArchiveCustomSchedule.ps1)

## Output from Technet Gallery

Project Server achives the projects on a daily basis. One particular project is archived only if it has been updated since previous archive.

There are situations where you may want your archive/administrative backup to run on weekly/monthly basis and to include all projects (no matter if they have been changed) and that's what the script does.

The script checks uf today's date has been defined in the archive schedule list and, if so, updates a text custom field for all projects and then archives the projects. Only projects are updated (no sub-projects etc) but these can be included as well.

The script will throw errors if some of the projects are already check out or are in visibility mode. The solution for the checked out projects would be to combine this script with Chritoph's force check in of all checked out projects

