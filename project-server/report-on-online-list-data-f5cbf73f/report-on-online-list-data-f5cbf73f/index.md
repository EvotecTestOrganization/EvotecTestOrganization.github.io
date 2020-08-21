# Report on Project Online Project Site list data

## Original Links

- [x] Original Technet URL [Report on Project Online Project Site list data](https://gallery.technet.microsoft.com/Report-on-Online-list-data-f5cbf73f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Report-on-Online-list-data-f5cbf73f/description)
- [x] Download: [Download Link](Download\CrossProjectSiteListData.js)

## Output from Technet Gallery

This simple JavaScript solution starter enables you to report on data from Project Site lists. It uses the SharePoint REST API so it is possible to update the script so that custom columns can be included or design the report around a custom list on the  Project Site. The link to the blog post below details the steps required to start using the solution starter.

A code snippet can be seen below - full code available in the download:

JavaScript

```
<script type="text/javascript">
var projectData = [];
var projectSiteListItems = [];
var projsiteUrl;
var projectAccess;
var projObject;
//run on page load to get a list of EPTs to populate the selection list
$(document).ready(function () {
LoadEPTs();
});
function LoadEPTs() {
        waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Loading', 'Getting the list report data. This will close when the data is loaded...');
        var selectArray = [];
        var uniqvalues = [];
                var data = $.ajax({u
```

Here is a link to the supporting blog post that details the requirements to use this solution starter script:

https://pwmather.wordpress.com/2017/05/05/want-to-report-across-projectonline-project-sites-for-sharepoint-list-data-ppm-javascript-office365-rest-odata/

