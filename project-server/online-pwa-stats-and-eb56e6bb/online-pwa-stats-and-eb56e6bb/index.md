# Project Online - PWA Stats and Snapsho

## Original Links

- [x] Original Technet URL [Project Online - PWA Stats and Snapsho](https://gallery.technet.microsoft.com/Online-PWA-Stats-and-eb56e6bb)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-PWA-Stats-and-eb56e6bb/description)
- [x] Download: [Download Link](Download\PWAStats.js)

## Output from Technet Gallery

This simple JavaScript solution starter enables you to view certain stats for your PWA data such as Total Projects, In Progress, Late In Progress, Active Issues, Active Risks etc. It also enables the data to be captured in a SharePoint list on the PWA site  to enable simple trend reporting. The script will need updating to reference the correct SharePoint Snapshot list, but this is covered in the supporting blog post.

A code snippet can be seen below - full code available in the download:

JavaScript

```
//run on page load
$(document).ready(function () {
LoadProjectData();
LoadResourceData();
LoadIssueData();
LoadRiskData();
waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Loading Data', 'Loading project, resource, issues and risks data');
});
//get the project data
var urlProj = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
                                    + "$filter=ProjectType ne 7"
                                    + "&$select=ProjectId,ProjectPercentCompleted,ProjectFinishVariance";
var allProjects = [];
function LoadProjectData() {
                var data = $.ajax({url: urlProj,
                                    type: "GET",
```

Here is a link to the supporting blog post that details the requirements to use this solution starter script:

https://pwmather.wordpress.com/2018/07/02/projectonline-pwa-stats-with-snapshot-javascript-jquery-ppm-office365-pmot-msproject/

The script is provided "As is" with no warranties etc.

