﻿#######################################################
# Author: Michael Wharton
# Date: 08/30/2016
# Description: Project Server 2016 configuration
#    Creates one or multiple PWA sies
#######################################################
 Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Confirm:$false -Verbose
 Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue  -Verbose
#######################################################
#  Update the following metadata that is used consistantly thru the script
#######################################################
$SqlServerName        = "LAB-2016SP.DOMAIN.LOCAL"
$WebAppURL            = "http://LAB-2016SP.DOMAIN.LOCAL"
$SitePwaURL           = "http://LAB-2016SP.DOMAIN.LOCAL/pwa"
$WebHostHeader        = "LAB-2016SP.DOMAIN.LOCAL"

$WebAppURL            = "http://LAB-2016SP"
$SitePwaURL           = "http://LAB-2016SP/pwa"
$SitePwa2URL          = "http://LAB-2016SP/pwa2/PMO"
$SitePwaOOBURL        = "http://LAB-2016SP/pwaoob"

$WebAppName           = "Project Server 2016"
$ProjectServiceApp    = "Project Service App"
$ProjectServicePool   = "Project Service Pool"
$WSS_ContentDB        = "LABK_PWA_WSS_Content"
# Create credentials
$ServiceSP            = "DOMAIN\ServiceSP"   
$ServicePass          = "password"
$credServiceSP  = New-Object System.Management.Automation.PSCredential -ArgumentList @($ServiceSP,(ConvertTo-SecureString -String $ServicePass -AsPlainText -Force))
################################################################
# create Managed Account
New-SPManagedAccount -Credential $credServiceSP -Verbose
################################################################
# Create Project Service Pool
New-SPServiceApplicationPool -Name $ProjectServiceApp  -Account $ServiceSP -Verbose
################################################################
#  Create Project Server Service and Enable Project Key
$ProjectServiceID = New-SPProjectServiceApplication -Name $ProjectServiceApp -Proxy -ApplicationPool (Get-SPServiceApplicationPool $ProjectServicePool)
Enable-projectserverlicense -Key "23CB6-N4X8Q-WWD7M-6FHCW-9TPVP"
#################################################################
# Create Web Application on root that contains project server collection
#################################################################
$AP = New-SPAuthenticationProvider -Verbose
New-SPWebApplication -Name $WebAppName -port 80 -URL $WebAppURL -DatabaseName $WSS_ContentDB  -ApplicationPool $ProjectServicePool   -ApplicationPoolAccount (Get-SPManagedAccount $ServiceSP) -AuthenticationProvider $AP -Verbose -Confirm:$false
# Create PWA on Root
New-SPSite -Url $WebAppURL -Template "PWA#0" -Name "Project Web App" -OwnerAlias "DOMAIN\mawharton" -Verbose 
Enable-SPFeature PWASITE -Url $WebAppURL -Verbose 
Set-SPProjectPermissionMode -Url $WebAppURL -Mode ProjectServer -Verbose
# Add a few resources and make basic configuration updates such as publish sites
Start $WebAppURL
###################################################
#  Create multiple PWA sites 
$SitePwaURL           = "http://LAB-2016SP/pwa"
$SitePwa2URL          = "http://LAB-2016SP/pwa2"
$SitePwaOOBURL        = "http://LAB-2016SP/pwaoob"
###################################################
# Create Root
New-SPSite -Url $WebAppURL -Template "STS#0" -Name "Root" -OwnerAlias "DOMAIN\mawharton" -Verbose 
# Create PWA Site as managed path
New-SPManagedPath "PWA" -WebApplication $WebAppURL -Explicit
# remove-spmanagedpath "PWA"  -WebApplication $WebAppURL
New-SPSite -Url $SitePwaURL -Template "PWA#0" -Name "Project Web App" -OwnerAlias "DOMAIN\mawharton" -Verbose 
Enable-SPFeature PWASITE -Url $SitePwaURL -Verbose 
Set-SPProjectPermissionMode -Url $SitePwaURL -Mode ProjectServer -Verbose
Start $SitePwaURL
# Create PWA2 as second site
New-SPManagedPath "PWA2" -WebApplication $WebAppURL -Explicit
New-SPSite -Url $SitePWA2URL -Template "PWA#0" -Name "Project Web App2" -OwnerAlias "DOMAIN\mawharton" -Verbose 
Enable-SPFeature PWASITE -Url $SitePWA2URL -Verbose 
Set-SPProjectPermissionMode -Url $SitePWA2URL -Mode ProjectServer -Verbose
Start $SitePWA2URL
# Create PWAOOB as second site (Out-Of-Box)
New-SPManagedPath "PWAOOB" -WebApplication $WebAppURL -Explicit 
New-SPSite -Url $SitePwaOOBURL -Template "PWA#0" -Name "Project Web App OOB" -OwnerAlias "DOMAIN\mawharton" -Verbose 
Enable-SPFeature PWASITE -Url $SitePwaOOBURL -Verbose 
Set-SPProjectPermissionMode -Url $SitePwaOOBURL -Mode ProjectServer -Verbose
Start $SitePwaOOBURL
# Create PWA2 as second site
New-SPManagedPath "PWA2" -WebApplication $WebAppURL
New-SPSite -Url $SitePWA2URL -Template "PWA#0" -Name "Project Web App2" -OwnerAlias "DOMAIN\mawharton" -Verbose 
Enable-SPFeature PWASITE -Url $SitePWA2URL -Verbose 
Set-SPProjectPermissionMode -Url $SitePWA2URL -Mode ProjectServer -Verbose
Start $SitePWA2URL
#################################################
#  List Web Application
#################################################
Get-SPProjectWebInstance | Select URL , adminAccount, ProvisioningResult, Online | Sort-Object URL 
#################################################
#  Delete PWA Site
#################################################
Remove-SPSite -Identity $SitePwaURL  -Confirm:$false -verbose     # Removes PWA site
Remove-SPSite -Identity $SitePwa2URL -Confirm:$false -verbose     # Removes PWA2 site
Remove-SPSite -Identity $SitePwaOOB  -Confirm:$false -verbose     # Removes PWAOOB site
