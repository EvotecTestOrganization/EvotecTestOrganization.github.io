# Display Project Online ideas list data

## Original Links

- [x] Original Technet URL [Display Project Online ideas list data](https://gallery.technet.microsoft.com/Display-Online-ideas-list-c59c8cc7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Display-Online-ideas-list-c59c8cc7/description)
- [x] Download: [Download Link](Download\Display_Project_Ideas_data.js)

## Output from Technet Gallery

This JavaScript file enables you to view the Project Ideas list data on a page in the Project Web App site and provides a hyperlink to the projects that have been created from a list item. It is simple to deploy and use, just create a page in the PWA site,  update the JavaScript file so that the listName variable has the correct project ideas list title, upload the JavaScript file and add it to the page using a content editor web part. The link to the blog post below details the steps required.

A code snippet can be seen below:

JavaScript

```
<table width="100%" align="left" cellpadding="0" border="1" class="stripe hover" id="ProjectIdeasTable">
<thead><th>Item ID</th><th>Item Title</th><th>Project GUID and link to Project</th></thead>
</table>
<script type="text/javascript">
//update project ideas list title
var listName = 'ProjectIdeas';
$(document).ready(function(){
```

 Once loaded to the PWA site it will look like the example below but with the list data from your project ideas list:

![](Images\projectideasview.png)

Here is a link to the supporting blog post that details the requirements to use this script:

https://pwmather.wordpress.com/2016/07/22/projectonline-project-ideas-list-view-with-project-guid-office365-sharepoint-javascript-jquery/

