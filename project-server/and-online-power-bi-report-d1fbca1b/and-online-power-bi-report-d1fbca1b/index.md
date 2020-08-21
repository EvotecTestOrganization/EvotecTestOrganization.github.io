# Project and Project Online Power BI Report Pack

## Original Links

- [x] Original Technet URL [Project and Project Online Power BI Report Pack](https://gallery.technet.microsoft.com/and-Online-Power-BI-Report-d1fbca1b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/and-Online-Power-BI-Report-d1fbca1b/description)
- [x] Download: [Download Link](Download\PWMatherProject_and_ProjectOnlineReportPack.pbit)

## Output from Technet Gallery

This Power BI file contains reports for Microsoft's Office 365 Project application that is built on the CDS and Project Online. This example report pack enables customers who use both Project (CDS) and Project Online to view data from both applications in  one report.

The report connections will need to be updated to access the target Project CDS environment. Set the CDSUrl parameter to the default Dynamics CDS org as this is where Project is deployed. To find the correct URL access Dynamics homepage (home.dynamics.com)  and access Project, the URL need will similar to this https://orgXXXXXXXXX.dynamics.com. The account used as the data source will need read access to the entities used in the report pack:

- Bookable Resource

- Project

- Project Task

- Resource Assignment

- User

Create a new access role and assign to the user account used to access the report as required.

There is also a PWAUrl parameter that will need setting to the PWA URL. The account used as the data source will need access to the Project Reporting API - when promted, click Organizational account and sign in.

This is the first version of the report pack for the new service, I plan to update this as the Project appliction evolves.

