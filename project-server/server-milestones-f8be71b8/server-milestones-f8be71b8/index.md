# Project Server Project Milestones displayed on the Project Si

## Original Links

- [x] Original Technet URL [Project Server Project Milestones displayed on the Project Si](https://gallery.technet.microsoft.com/Server-Milestones-f8be71b8)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Milestones-f8be71b8/description)
- [x] Download: [Download Link](Download\project milestones on project site.js)

## Output from Technet Gallery

This JavaScript file displays the project milestones on the associated Project Site in Project Server 2013 / Project Online. The script will display the Milestone name, Finish Date and % complete. A code snippet can be seen below:

JavaScript

```
<script type="text/javascript">
 var ProjectUID;
 ExecuteOrDelayUntilScriptLoaded(getProjectUIDProperty, "sp.js");
 function getProjectUIDProperty() {
                var ctx = new SP.ClientContext.get_current();
```

The script does require some jQuery libraries to work - these are detailed on the blog post below. The idea of this script is to add the script to the project site via a content editor web part. For details see the blog post below:

http://pwmather.wordpress.com/2014/05/12/projectserver-project-milestones-on-the-project-site-projectonline-ps2013-sharepoint-javascript-jquery-sp2013-office365/

The output can be seen below:

![](Images\image1.png)

