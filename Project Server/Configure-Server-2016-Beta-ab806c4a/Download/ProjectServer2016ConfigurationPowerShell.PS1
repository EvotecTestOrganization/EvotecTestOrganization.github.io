?#######################################################
# Author: Michael Wharton
# Date: 12/30/2015
# Description: Project Server 2016 Beta V2 Configuration
#   The following must be done prior to provisioning Project Server
#   1. Install Windows Server 20012 R2 and update patches
#   2. Install SQL Server 2014
#   3. Install SharePoint 2016
#   4. Created only the SharePoint Farm as Single Server mini role and do not run wizard
#
#   Start "https://technet.microsoft.com/en-us/library/cc197280(v=office.16).aspx"
#######################################################
 Set-ExecutionPolicy "Unrestricted"
 Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
#######################################################
#  Provisioning Project Server 2016
#   1. Create Managed Account as SharePoint Account
#   2. Create Application Pool
#   3. Create Project Server App
#   4. Create Web applications
#   5. Create Root Site collection
#   6. Create Managed Path
#   7. Create PWA Site Collection
################################################################
#  Update the following parameters with your values
################################################################
$SqlServerName        = "Beta2016b"
$SharePointServerName = "Beta2016b"
$WebAppURL            = "http://Beta2016b"
$SiteRootURL           = "http://Beta2016b/"
$SitePwaURL            = "http://Beta2016b/pwa"
$WebAppName           = "Project Server 2016"
$ProjectServiceApp    = "Project Service App"
$ProjectServicePool   = "Project Service Pool"
$ProjectWebAppDB      = "Beta2_ProjectWebApp"
$FarmAdminAcct        = "domain\FarmAdmin"   # FarmAdmin Acct
$SetupAcct            = "domain\mawharton"   # Setup Acct --- Running from this account
$ServiceSP            = "domain\ServiceSP"   # Service Acct
$ServicePass          = "password"
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
# Create Web Application
$AP = New-SPAuthenticationProvider -Verbose
New-SPWebApplication -Name $WebAppName -port 80 -URL $WebAppURL -DatabaseName $ProjectWebAppDB -DatabaseServer $SqlServerName -ApplicationPool $ProjectServicePool -ApplicationPoolAccount (Get-SPManagedAccount $ServiceSP) -AuthenticationProvider $AP -Verbose
################################################################
# Create Root SiteCollection - optional - not required but just a good SharePoint practice
New-SPSite $SiteRootURL -OwnerAlias $SetupAcct -Name "ROOT" -Template "STS#0" -SecondaryOwnerAlias $FarmAdminAcct -Verbose
START $SiteRootURL
################################################################
# Create managed path PWA
New-SPManagedPath -WebApplication $WebAppName -Explicit "/PWA"
# Create PWA Site collection
New-SPSite $SitePwaURL   -ContentDatabase $ProjectWebAppDB -OwnerAlias $SetupAcct -Name "Project Web App" -Template "pwa#0" -Language 1033 -SecondaryOwnerAlias  $FarmAdminAcct -Verbose
# Enable PWA features
Enable-SPFeature PWASITE -Url $SitePwaURL -Verbose
Enable-spfeature -identity PWABIODataReports -Url $SitePwaURL  -Force
Set-SPProjectPermissionMode -Url $SitePwaURL -Mode ProjectServer -Verbose  # optional
# Start up Project Server App Web site
Start  $SitePwaURL
################################################################

