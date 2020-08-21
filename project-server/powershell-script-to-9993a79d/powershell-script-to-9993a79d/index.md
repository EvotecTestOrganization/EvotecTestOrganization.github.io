# Project Server 2016 Configurator Script (Auto Installer)

## Original Links

- [x] Original Technet URL [Project Server 2016 Configurator Script (Auto Installer)](https://gallery.technet.microsoft.com/PowerShell-Script-to-9993a79d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/PowerShell-Script-to-9993a79d/description)
- [x] Download: [Download Link](Download\Project Server 2016 Configurator Script.zip)

## Output from Technet Gallery

# PowerShell Script to Configure Project Server 2016

## Introduction

**Project Server 2016 Configurator Script (Auto Installer)" **will help you to configure the Project Server 2016 easily through the below functions.

![](Images\ps-2016.jpg)

#1 - Register Managed Accounts.

#2 - Enable Project Server 2016 License.

#3 - Create Project Server Application Service Application Pool.

#4 - Create a Project Server 2016 service application.

#5 - Create a web Application.

#6 - Create Top Level site Collection.

#7 - Lock Down web application Content Database.

#8 - Create a PWA Content Database.

#9 - Lock Down PWA Content Database.

#10 - Provision the PWA Site Collection.

#11 - Enable PWA FeatureStart PWA Instance.

#12 - Start PWA Instance.

## Prerequisites

1. You have already installed SharePoint Server 2016 Enterprise Edition.

2. You have created the below service accounts:

    - PSWebAppPool** **is a domain user that used to run the application pool for the web application that will host the PWA site collection.

    - PSSrvAppPool** **is a domain user that used to run the associated application pool of the project server service application.

For more details check

- [Project Server 2016 Configuration](https://social.technet.microsoft.com/wiki/contents/articles/37674.project-server-2016-configuration.aspx#Create_SharePoint_and_Project_Server_Service_Accounts).

- [PowerShell Script to Configure Project Server 2016.](https://social.technet.microsoft.com/wiki/contents/articles/38009.powershell-script-to-configure-project-server-2016.aspx)

## Functions

**#1 - Register Managed Accounts.**

![](Images\add-managed-account-using-powershell.png)

**#2 - Enable Project Server 2016 License.**

![](Images\enable-projectserver-license.png)

** **

**#3 - Create Project Server Application Service Application Pool.**

![](Images\create-project-server-application-service-application-pool.png)

** **

**#4 - Create a Project Server 2016 service application.**

![](Images\create-project-server-application-service.png)

** **

**#5 - Create a web Application.**

![](Images\create-aweb-application.png)

** **

**#6 - Create Top Level site Collection.**

![](Images\create-top-level-site-collection.png)

** ![](Images\start-web-application.png)**

** **

**#7 - Lock Down web application Content Database.**

![](Images\lock-down-web-application-content-database.png)

** **

**#8 - Create a PWA Content Database.**

![](Images\create-a-new-pwa-content-database.png)

** **

**#9 - Lock Down PWA Content Database.**

![](Images\lockdown-pwa-content-database.png)

**#10 - Provision the PWA Site Collection.**

![](Images\provision-pwa-instance.png)

**#11 - Enable PWA FeatureStart PWA Instance.**

**![](Images\enable-pwa-feature.png)**

**#12 - Start PWA Instance**

**![](Images\start-pwa-instance.png)**

**

**

