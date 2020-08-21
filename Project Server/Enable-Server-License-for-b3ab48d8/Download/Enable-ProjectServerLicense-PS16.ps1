# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#                                                                     #
#        Created By: Avinash Kumar [avigr8_hak@hotmail.com]           #
#                                                                     #
#        Note: Below command is to enable ProjectServerLicense        #
#              in Project Server 2016                                 #
#                                                                     #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  


# Load SharePoint PowerShell Snapin
Add-PSSnapin Microsoft.SharePoint.PowerShell

# Clear Screen
cls

Write-Host "Created By: Avinash Kumar [avigr8_hak@hotmail.com]"
Write-Host "--------------------------------------------------" 

# Project Server License - put your Project Server license key below
$ProjectServerKey="PutYourProjectServerKeyHere"

#check ProjectServerLicense
$isPSLicenseEnabled=ProjectServerLicense

If ($isPSLicenseEnabled -eq "Project Server 2016 : Disabled") {
    
    Write-Host "Enabling Project Server License"
    Enable-ProjectServerLicense -Key $ProjectServerKey
    
    Write-Host "License - Enabled"
}
Else {
    Write-Host "Project Server License is already enabled."
    Get-ProjectServerLicense
}

Write-Host "-------------------- thank you -------------------"

#      You can write me here [avigr8_hak@hotmail.com]

