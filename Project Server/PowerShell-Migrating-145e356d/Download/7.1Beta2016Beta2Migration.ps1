#######################################################
# Author: Michael Wharton
# Date: 01/01/2016
# Description: Project Server 2016 Migration for 2016 Preview Beta 2 
#
# Link to Project Server Migration notes
# Start "https://technet.microsoft.com/EN-US/library/gg502590(v=office.16).aspx"
#######################################################
 Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Confirm:$false -Verbose
 Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue  -Verbose
#######################################################
#  Before attempting a migration from Project Server 2013 to 2016
#  Verify that the following are enabled
#  1) SharePoint Farm is configurated and working
#  2) SharePoint Sites and site collections can be created
#  3) Restore SharePoint 2013 Content and ProjectWebApp databases
#######################################################
$SqlServerName        = "ServerName"              #-->  replace with SQL Server name
$WebAppURL            = "http://ServerName"       #-->  replace with SharePoint Server name
$SitePwaURL           = "http://serverName/pwa"   #-->  replace with SharePoint Server name
$WebAppName           = "Project Server 2016"
$ProjectServiceApp    = "Project Service App"
$ProjectServicePool   = "Project Service Pool"
$WSS_ContentDB        = "Temp_WSS_Content"
$ServiceSP            = "domain\ServiceSP"  #-->  replace with service account name
$ServicePass          = "password"          #-->  replace with service account password
$WSS_Content2013      = "2013WSS_Content"   #--> replace name with migrated SharePoint 2013 Content database
$ProjectWebApp2013    = "2013ProjectWebApp" #--> replace name with migrated ProjectWebApp database
################################################################
# Create credentials
$credServiceSP  = New-Object System.Management.Automation.PSCredential -ArgumentList @($ServiceSP,(ConvertTo-SecureString -String $ServicePass -AsPlainText -Force))
################################################################
# create Managed Account
New-SPManagedAccount -Credential $credServiceSP -Verbose
################################################################
# Create Project Service Pool
 New-SPServiceApplicationPool -Name $ProjectServicePool -Account $ServiceSP -Verbose
################################################################
#  Create Project Server Service and Enable Project Key
$ProjectServiceID = New-SPProjectServiceApplication -Name "Project Service App" -Proxy -ApplicationPool (Get-SPServiceApplicationPool $ProjectServicePool)
Enable-projectserverlicense -Key "Y2WC2-K7NFX-KWCVC-T4Q8P-4RG9W"
################################################################
#  Project and SharePoint content migration starts at this point
#  Restore Project Server 2013 databases on SQL Server
#  1) 2013 WSS_Content
#  2) 2013 ProjectWebApp
################################################################
# Create Web Application that contains project server collection
$AP = New-SPAuthenticationProvider -Verbose
New-SPWebApplication -Name $WebAppName -port 80 -URL $WebAppURL -DatabaseName $WSS_ContentDB -DatabaseServer $SqlServerName -ApplicationPool $ProjectServicePool -ApplicationPoolAccount (Get-SPManagedAccount $ServiceSP) -AuthenticationProvider $AP -Verbose -Confirm:$false
# Mount WSS_Content converts to SharePoint 2016 
Mount-SPContentDatabase -Name $WSS_Content2013 -WebApplication $WebAppName -Verbose
# Review issues found with database
# It's possible that some error may block the upgrade or that you wish to be fix some of the issue before moving to production
Test-SPContentDatabase -Name $WSS_Content2013 -WebApplication $WebAppName  
# Enable SharePoint features for PWA and BI
# Enable-SPFeature PWASITE -Url $SitePwaURL -Verbose   # note: PWA feature should already be enable in the migrated database
Enable-spfeature -identity PWABIODataReports -Url $SitePwaURL  -Force
# Migrate ProjectWebApp 2013 to 2016
Migrate-SPProjectDatabase -SiteCollection $SitePwaURL -DatabaseServer $SqlServerName -DatabaseName $ProjectWebApp2013 -Overwrite -Confirm:$false -Verbose 
# Migrate Resource Plans
Migrate-SPProjectResourcePlans -URL $SitePwaURl -Verbose
# Test the Project Instance for issues
Get-SPProjectWebInstance
Get-SPProjectWebInstance | Test-SPProjectWebInstance
Test-SPProjectServiceApplication -Identity $ProjectServiceApp
# Start up Project Server App Web site
Start  $SitePwaURL
################################################################
# General Cleanup - optional
# The initial contentdatabase created during the New-SPWebApplication isn't need and can be dismounted
Get-SPContentdatabase -DatabaseName $WSS_ContentDB -DatabaseServer $SqlServerName -ConnectAsUnattachedDatabase:$false | Dismount-SPContentDatabase -Confirm:$false  -Verbose
################################################################
