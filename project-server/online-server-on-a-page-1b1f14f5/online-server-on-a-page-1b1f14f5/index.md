# Project Online / Project Server 'Project on a page'

## Original Links

- [x] Original Technet URL [Project Online / Project Server 'Project on a page'](https://gallery.technet.microsoft.com/Online-Server-on-a-page-1b1f14f5)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Server-on-a-page-1b1f14f5/description)
- [x] Download: [Download Link](Download\Projectonapage on project site.js)

## Output from Technet Gallery

This JavaScript file displays project information on the associated Project Site in Project Server 2013 / Project Online. The script will display project information, project milestones, active issues and active risks on one page. A code snippet  can be seen below:

JavaScript

```
<script type="text/javascript" src="/sites/pwa/SiteCollectionDocuments/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
```

The script does require some jQuery libraries to work - these are detailed on the blog post below. The idea of this script is to reference the script file on project site via a content editor web part and link to the uploaded file. Don't place the code  directly on the project site or page, always reference the central file as it is easier to fix if you have any issues. For details see the blog post below:

http://pwmather.wordpress.com/2014/10/26/project-on-a-page-for-microsoft-projectonline-ps2013-javascript-jquery-office365-sharepoint/

Also for this to work for Project Server On-prem the milestone query will need to be updated to use JSOM REST (/api/ProjectServer/) as the ProjectData ODATA feed has a bug with filtering for boolean fields. The query will need to be updated to  use the REST fields - these are named different to the ODATA equivalents.

The output can be seen below - better screen shots on the blogs post:

![](/scriptcenter/site/view/file/127567/1/ProjectReport.png)![](Images\projectreport1.png)

The script is provided "As is" with no warranties etc.

