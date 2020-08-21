#######################################################
# Author: Michael Wharton
# Date: 08/31/2015 
# Description: Provision Project Server 2016 Beta
#   The following must be done prior to provisioning Project Server
#   1. Install Windows Server 20012 R2 and update patches
#   2. Intall SQL Server 2014
#   3. Install SharePoint 2016
#   4. SharePoint 2016 Products Configuration Wizard
#######################################################
 Set-ExecutionPolicy "Unrestricted"
 Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
#######################################################
#  Provisioning Project Server 2016
#######################################################
#   1. Create Managed Account as SharePoint Account
#   2. Create Application Pool
#   3. Create web applications
#   4. Create Root Site collection
#   5. Create Another database for PWA (ProjectServiceDB)
#   6. Create PWA Site using ProjectServiceDB
#   7. Provision Project Server App by enabling the PWA feature
################################################################
$SqlServerName        = "Beta2016B.LAB.LOCAL"
$SharePointServerName = "Beta2016B.LAB.LOCAL"
$WebAppURL    = "http://beta2016b.LAB.local"
$SiteRootURL  = "http://beta2016b.LAB.local/"
$SitePwaURL   = "http://beta2016b.LAB.local/sites/pwa"
$WebAppName         = "Project Server 2016"
$ProjectServiceApp  = "Project Service App"
$ProjectServicePool = "Project Service Pool"
$WebContentDB       = "Beta_PWA_WSS_CONTENT"
$ProjectWebAppDB    = "Beta_ProjectWebApp"
$setupAdmin  = "LAB\mawharton"
$setupPass   = "yourpassword#1"
$ServiceSP   = "LAB\ServiceSP"
$ServicePass = "yourpassword#1"
################################################################
# Create credentials
$credSetupAdmin = New-Object System.Management.Automation.PSCredential -ArgumentList @($SetupAdmin,(ConvertTo-SecureString -String $SetupPass   -AsPlainText -Force))
$credServiceSP  = New-Object System.Management.Automation.PSCredential -ArgumentList @($ServiceSP ,(ConvertTo-SecureString -String $ServicePass -AsPlainText -Force))
################################################################
# Create Managed Account
New-SPManagedAccount -Credential $credServiceSP -Verbose
################################################################
# Create App Pool
New-SPServiceApplicationPool -Name $ProjectServicePool -Account $ServiceSP -Verbose
################################################################
# Create Web Application
$AP = New-SPAuthenticationProvider -Verbose
New-SPWebApplication -Name $WebAppName -port 80 -URL $WebAppURL -DatabaseName $WebContentDB -DatabaseServer $SqlServerName -ApplicationPool $ProjectServicePool -ApplicationPoolAccount (Get-SPManagedAccount $ServiceSP) -AuthenticationProvider $AP -Verbose
################################################################
# Create Root SiteCollection
New-SPSite $SiteRootURL -OwnerAlias $SetupAdmin  -Name "ROOT" -Template "STS#0" -Verbose
# Note *****   Set permission on top-level web site to Domain User  Visitors Read
#      *****    The Members, Owners and Visitors group not found 
START $SiteRootURL
################################################################
# Create managed path PWA
New-SPContentDatabase -Name $ProjectWebAppDB -DatabaseServer $sqlservername  -WebApplication $webAppname 
# Create PWA Site collection
New-SPSite $SitePWAURL -ContentDatabase $ProjectWebAppDB -OwnerAlias $setupAdmin  -Name "Project Web App" -Template "pwa#0"
################################################################
# Create Project Service App ---  Service must be created before PWA feature can be enabled
New-SPProjectServiceApplication –Name $ProjectServiceApp  –ApplicationPool $ProjectServicePool –Proxy -Verbose
################################################################
# Enable the Project Service feature
Enable-SPFeature pwasite -Url $SitePWAURL
################################################################
# Set Project Permission mode to Project server
Set-SPProjectPermissionMode -Url $SitePWAURL -Mode ProjectServer
################################################################
# Start up PWA
START $SitePWAURL