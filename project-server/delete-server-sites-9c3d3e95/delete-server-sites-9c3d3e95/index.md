# Delete Project Server Project Sites

## Original Links

- [x] Original Technet URL [Delete Project Server Project Sites](https://gallery.technet.microsoft.com/Delete-Server-Sites-9c3d3e95)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Delete-Server-Sites-9c3d3e95/description)
- [x] Download: [Download Link](Download\Projectsitedeletionforspecifiedprojectintextfile.ps1)

## Output from Technet Gallery

This PowerShell script will delete the project sites for the associated project. The projects are inputted from a text file. A code snippet can be seen below:

```
#Fully test on a test PWA instance first
#For projects that you wish to delete the project site, add the exact project names to a text file and reference the text file location below
$projectList = Get-Content C:\Users\paulmather\Desktop\projectsitesstodelete.txt
#Update the uri with the correct PWA URL for your PWA instance and run with an account that has access to the projects listed in the text file
$svcPSProxy = New-WebServiceProxy -uri "http://vm753/PWA/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$svcWSSProxy = New-WebServiceProxy -uri "http://vm753/PWA/_vti_bin/PSI/WssInterop.asmx?wsdl" -useDefaultCredential
$emptyGUID = [system.guid]::empty
```

Use this script with care as it will remove any project site and project site content for any project name added to the text file - that data will be gone and not recoverable.

This script works for Project Server 2010 and 2013, only requirement is that the script is run with an account that has admin access.

The script will need to be updated with the correct PWA URL for the Web Service Proxies and corrrect path and file name for the project name text file. For further details on this script please see the following post:

https://pwmather.wordpress.com/2015/06/26/projectserver-ps2010-ps2013-delete-project-site-using-powershell-sp2013-sp2010/

Fully test this script on a test / non-production PWA instance before running on any production environment. As a precaution, take full database backups (PWA and SharePoint Content) before running the script on the production environment so that you can roll back if needed.

The script is provided "As is" with no warranties etc.

