# Project Server 2013 / Project Online Publish all projects

## Original Links

- [x] Original Technet URL [Project Server 2013 / Project Online Publish all projects](https://gallery.technet.microsoft.com/Server-2013-Online-Publish-15215a56)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-2013-Online-Publish-15215a56/description)
- [x] Download: [Download Link](Download\publishallprojects.js)

## Output from Technet Gallery

This JavaScript file can be added to a Project Web App page to enable the user to publish all projects they have access to in one go. This will work for Project Server 2013 and Project Online. A code snippet can be seen below:

JavaScript

```
<script type="text/javascript">
var projContext;
var projects;
var waitDialog;
function GetProjects() {
   projContext = PS.ProjectContext.get_current();
   projects = projContext.get_projects();
   projContext.load(projects);
   projContext.executeQueryAsync(onQuerySucceeded, onQueryFailed);
```

The script does require jQuery and references to SharePoint JavaScript libraries to work - these are detailed on the blog post below. The idea of this script is to create a new page in the Project Web App then add the script to the page via a content editor web part. For details see the blog post below:

http://pwmather.wordpress.com/2014/04/17/projectserver-projectonline-publish-all-projects-javascript-jquery-sharepointonline-office365-ps2013/

