# Create Project Server 2010 / 2013 project from a template and update the EP

## Original Links

- [x] Original Technet URL [Create Project Server 2010 / 2013 project from a template and update the EP](https://gallery.technet.microsoft.com/Create-Server-2010-2013-19bd3cc7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Create-Server-2010-2013-19bd3cc7/description)
- [x] Download: [Download Link](Download\CreateProjectFromTemplateandchangeEPT.ps1)

## Output from Technet Gallery

This PowerShell script will create a project from the specified project template then update that project to associate it with the correct EPT. By default, when creating projects from templates using the Create Project From Template PSI method, the  projects will be associated with the defaut EPT. The script will prompt for the new project name, the project template name and the EPT name.

A code snippet can be seen below:

```
#Get details for new project
$ProjName = Read-Host -Prompt "Enter the Name of the Project"
$ProjTempName = Read-Host -Prompt "Enter the Name of the Project Template"
$ProjEPTName = Read-Host -Prompt "Enter the Name of the EPT"
Write-host "The Project is called $ProjName"
#Create empty GUID
$EPMTYGUID = [system.guid]::empty
#Project PSI Web Service
$svcPSProjProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
#Get the Project Template UID from the ReadProjectStatus Method
```

The script will need to be updated with the correct PWA URL for the WebServiceProxy. For further details on this script please see the following post:

http://pwmather.wordpress.com/2013/08/30/create-a-projectserver-ps2010-ps2013-project-from-a-template-and-update-the-ept-sp2013-sp2010-powershell/

