# Check entities from multiple Project Online PWA instances

## Original Links

- [x] Original Technet URL [Check entities from multiple Project Online PWA instances](https://gallery.technet.microsoft.com/Check-entities-from-a1cb87e4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Check-entities-from-a1cb87e4/description)
- [x] Download: [Download Link](Download\ListCustomFieldsfrommultiplePWAInstances.ps1)

## Output from Technet Gallery

This PowerShell script will use the Project CSOM API to return a list of Enterprise Custom Fields from mutiple PWA instances. The user running the script specifies the number of PWA instances to check then enters the URL, Username and password for each.  The fields will then be displayed in the console but it could easily be updated to output these to a file.

A code snippet can be seen below:

```
#Add in libraries
#Project CSOM
Add-Type -Path 'C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.ProjectServer.Client.dll'
#add SharePoint Online DLL
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'
$NoPWAInstances = Read-Host "how many instances to check?"
$PWAIntances = 1
```

For the script to work, references will need to be updated to point to the correct DLLs. The script has only been tested using PowerShell 3.0, other versions of PowerShell may not work - see the note in the blog post below.

A supporting blog post can be seen here:

https://pwmather.wordpress.com/2015/11/04/check-entities-from-multiple-projectonline-pwa-instances-using-powershell-and-csom-office365/

The script is provided "As is" with no warranties etc.

