#Creates the Project Professional 2010 Project Server Account
$keyPath = "hkcu:\Software\Microsoft\Office\14.0\MS Project\Profiles\"
#Update account name
$accountName = "PaulMathersTest"
$guid = [System.Guid]::NewGuid()
#Update PWA URL
$pwaURL = "http://vm353/pwa"
New-Item -Path "$keyPath$accountName"
New-ItemProperty -Path "$keyPath$accountName" -Name Name -PropertyType String -Value $accountName
New-ItemProperty -Path "$keyPath$accountName" -Name GUID -PropertyType String -Value "{$guid}"
New-ItemProperty -Path "$keyPath$accountName" -Name Path -PropertyType String -Value $pwaURL