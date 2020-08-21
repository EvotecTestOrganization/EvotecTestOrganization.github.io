# Project Power BI Report Pack

## Original Links

- [x] Original Technet URL [Project Power BI Report Pack](https://gallery.technet.microsoft.com/Power-BI-Report-Pack-4506f183)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Power-BI-Report-Pack-4506f183/description)
- [x] Download: [Download Link](Download\PWMatherProjectReportPack.pbit)

## Output from Technet Gallery

This Power BI file contains reports for Microsoft's Office 365 Project application that is built on the CDS. The report connections will need to be updated to access the target Project CDS environment. Set the CDSUrl parameter to the default Dynamics CDS  org as this is where Project is deployed. To find the correct URL access Dynamics homepage (home.dynamics.com) and access Project, the URL need will similar to this https://orgXXXXXXXXX.dynamics.com. The account used as the data source will need read  access to the entities used in the report pack:

- Bookable Resource

- Project

- Project Task

- Project Task Dependency

- Project Bucket

- Project Team Member

- Resource Assignment

- User

Create a new access role and assign to the user account used to access the report as required.

This is the first version of the report pack for the new service, I plan to update this as the Project appliction evolves.

