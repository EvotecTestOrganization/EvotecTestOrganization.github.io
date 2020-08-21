# Project Server 2010 / 2013 - Publish single project by UID

## Original Links

- [x] Original Technet URL [Project Server 2010 / 2013 - Publish single project by UID](https://gallery.technet.microsoft.com/Server-2010-2013-Publish-a8772725)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2010-2013-Publish-a8772725/description)
- [x] Download: [Download Link](Download\PUBLISH BY UID EXAMPLE.PS1)

## Output from Technet Gallery

Windows Shell Script

```
$svcPSProxy = New-WebServiceProxy -uri "http://[your PWA project before/default.asmx]/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$job = [system.guid]::NewGuid()
$svcPSProxy.QueuePublish($job, "put UID hier e.g. 4A2A5C24-E5EF-4196-A227-0A69DCA6CF8F", "true","")
```

In case you want to publish on project server just a single project by using it PROJECTUID UID, this powershell script is a good one.

we used this script to validate effect of publishing on update of some task and project properties in the reporting database.

See the script to update your project server instance and project uid.

The script uses standard project PSI interface

QueuePublish function takes the following parameters

Jobuid , projectuid , fullpublish (true or false) , if true it removes previous data in the pubished database

