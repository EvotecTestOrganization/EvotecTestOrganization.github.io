# PS script to check if a Project is not Published and act accordingly

## Original Links

- [x] Original Technet URL [PS script to check if a Project is not Published and act accordingly](https://gallery.technet.microsoft.com/PS-script-to-check-if-a-is-658eb260)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/PS-script-to-check-if-a-is-658eb260/description)
- [x] Download: [Download Link](Download\ProjectsWithPendingChanges.ps1)

## Output from Technet Gallery

This PowerShell script uses the Project Server Interface (PSI), that is available from Project Server 2003 and future versions (2007, 2010, 2013, Online), to check if the Project Plan is Saved and Published or just only Saved.

It does this comparing the column PROJ\_LAST\_SAVED from datasets retrieved from the Publish and Draft databases, or on newer versions from Publish and Draft Schemas of the Database.

Since this script uses PSI to obtain the data, is fully supported in terms of upgrades.

When the script finds a Project Plan out of sync it will trigger an alert for the administrator.

Can be run from the Customer Machine or from the Server.

This script is important to run before any operation to ensure that all changes are on the Publish Database.

