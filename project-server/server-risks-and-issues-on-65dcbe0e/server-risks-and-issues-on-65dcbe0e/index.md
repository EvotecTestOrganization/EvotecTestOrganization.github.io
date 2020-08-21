# Project Server Risks and Issues on a Project Detail Pag

## Original Links

- [x] Original Technet URL [Project Server Risks and Issues on a Project Detail Pag](https://gallery.technet.microsoft.com/Server-Risks-and-Issues-on-65dcbe0e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Risks-and-Issues-on-65dcbe0e/description)
- [x] Download: [Download Link](Download\riskandissuesonPDP.js)

## Output from Technet Gallery

This JavaScript file will display the assiciated Risks and Issues on a Project Detail Page in Project Server 2013 / Project Online. By default the script only uses the default columns from the Project Server / Project Online Issues and Risks Project  Site lists so that the script will work for all Project Server 2013 / Project Online deployments. The script can easily be updated to include other columns if needed. A code snippet can be seen below:

JavaScript

```
function GetProjects() {
        var projContext = PS.ProjectContext.get_current();
        projects = projContext.get_projects();
        projContext.load(projects, 'Include(Name, Id, ProjectSiteUrl)');
        projContext.executeQueryAsync(onQuerySucceeded, onQueryFailed);
    }
    function onQuerySucceeded(sender, args) {
```

The script does require some jQuery libraries to work - these are detailed on the blog post below. The idea of this script is to create a new Project Detail Page then add the script to the page via a content editor web part. For details see the blog  post below:

http://pwmather.wordpress.com/2014/04/11/want-to-see-risks-and-issues-on-a-projectonline-projectserver-project-detail-page-ps2013-sharepointonline-sp2013-office365-javascript-jquery/

