# Bulk create Project Server Project Sites

## Original Links

- [x] Original Technet URL [Bulk create Project Server Project Sites](https://gallery.technet.microsoft.com/Bulk-create-Server-Sites-784f7b29)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Bulk-create-Server-Sites-784f7b29/description)
- [x] Download: [Download Link](Download\BulkCreateProjectSites.ps1)

## Output from Technet Gallery

This PowerShell script will bulk create a project site for the associated project using the correct site template set on the EPT for all projects without an associated project site. This script does require PowerShell 3.0 or later. A code snippet  can be seen below:

```
###create sites for projects without a site
###update the uri with the correct PWA URL for your farm
$svcPSProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
$svcWSSProxy = New-WebServiceProxy -uri "http://vm753/pwa/_vti_bin/PSI/WssInterop.asmx?wsdl" -useDefaultCredential
$emptyGUID = [system.guid]::empty
$wssServerUID =  $svcWSSProxy.ReadWssSettings().WSSadmin.Wadmin_current_sts_server_uid
```

This script works for Project Server 2010 and 2013, only requirement is that the script is run with an account that has admin access and you are running it from a PowerShell 3.0 console or later.

The script will need to be updated with the correct PWA URL for the Web Service Proxies. For further details on this script please see the following post:

http://pwmather.wordpress.com/2014/03/05/projectserver-ps2010-ps2013-bulk-project-site-creation-using-powershell-3-0-or-later-sp2013-sp2010/

