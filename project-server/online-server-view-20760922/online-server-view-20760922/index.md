# Project Online / Project Server - View Resource Calendar Exceptions

## Original Links

- [x] Original Technet URL [Project Online / Project Server - View Resource Calendar Exceptions](https://gallery.technet.microsoft.com/Online-Server-View-20760922)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Server-View-20760922/description)
- [x] Download: [Download Link](Download\ResourceExceptions.js)

## Output from Technet Gallery

This JavaScript file enables the user to see the Resource Calendar Exceptions in Project Online / Project Server 2013. The example script can be added to a page in the PWA site collection using a content editor web part. A code snippet can be seen below:

JavaScript

```
<h2>Resource Calendar Exception Checker</h2>
Select the Resource: <select id="idRES"></select>
<table width="100%" align="left" cellpadding="0" border="1" class="stripe hover" id="ResExceptions" style="display:none">
<thead><th>Exception Name</th><th>Start Date</th><th>Finish Date</th><th>Recurrence Type</th><th>Recurrence Frequency</th><th>Duration (Days)</th></thead>
</table>
<script type="text/javascript">
$(document).ready(function () {
LoadResources();
```

The script does require some jQuery libraries to work - these are detailed on the blog post below. The idea of this script is to add the script to the PWA site via a content editor web part. For details see the blog post below:

[http://pwmather.wordpress.com/2015/05/01/projectonline-projectserver-view-resource-calendar-exceptions-javascript-jquery-office365-sharepoint/](https://pwmather.wordpress.com/2015/05/01/projectonline-projectserver-view-resource-calendar-exceptions-javascript-jquery-office365-sharepoint/)

A screenshot of the output can be seen below:

![](Images\resexcep.png)

The script is provided "As is" with no warranties etc.

