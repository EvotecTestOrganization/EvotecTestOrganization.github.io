# Create Project Server 2010 Project Professional 2010 accounts with PowerShell

## Original Links

- [x] Original Technet URL [Create Project Server 2010 Project Professional 2010 accounts with PowerShell](https://gallery.technet.microsoft.com/Create-Server-2010-dfb0fbba)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Create-Server-2010-dfb0fbba/description)
- [x] Download: [Download Link](Download\CreateProjPro2010accounts.ps1)

## Output from Technet Gallery

This is a PowerShell script that will create the Project Server Project Professional 2010 account. The script works by creating a new registry key with the required string values. This is just an example to show how system administrators could automate  the creation of the Project Server account. As this script is only an example, please test thoroughly on a test workstation before deploying on a production environment.

A code snippet can be seen below:

```
#Creates the Project Professional 2010 Project Server Account
$keyPath = "hkcu:\Software\Microsoft\Office\14.0\MS Project\Profiles\"
#Update account name
$accountName = "PaulMathersTest"
$guid = [System.Guid]::NewGuid()
#Update PWA URL
$pwaURL = "http://vm353/pwa"
New-Item -Path "$keyPath$accountName"
New-ItemProperty -Path "$keyPath$accountName" -Name Name -PropertyType String -Value $accountName
New-ItemProperty -Path "$keyPath$accountName" -Name GUID -PropertyType String -Value "{$guid}"
New-ItemProperty -Path "$keyPath$accountName" -Name Path -PropertyType String -Value $pwaURL
```

 Two variables will need to be updated before executing this script.

For further details on this script please see the following blog post:

http://pwmather.wordpress.com/2013/01/15/create-projectserver-2010-msproject-2010-accounts-with-powershell-ps2010-sp2010-msoffice/

Please backup the registry before making any changes

