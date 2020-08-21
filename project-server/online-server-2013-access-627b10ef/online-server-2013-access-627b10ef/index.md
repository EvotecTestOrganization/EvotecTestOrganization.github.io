# Project Online / Project Server 2013/16/19 - access SharePoint lists on a PDP

## Original Links

- [x] Original Technet URL [Project Online / Project Server 2013/16/19 - access SharePoint lists on a PDP](https://gallery.technet.microsoft.com/Online-Server-2013-access-627b10ef)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Server-2013-access-627b10ef/description)
- [x] Download: [Download Link](Download\SharePointListOnPDP.js)

## Output from Technet Gallery

This simple JavaScript file enables the user to access the SharePoint Issues and Risks lists in Project Online / Project Server 2013. The example script is added to a Project Detail Page in the PWA site collection using a content editor web part. A code snippet can be seen below:

JavaScript

```
<div id="divMessage">
    <br/>
    <span id="spanMessage" style="color: #FF0000;"></span>
</div>
<p id="messages"></p>
<div id="buttons">
    <button type='button' id="riskBtn" class='deselectedBtn' onclick="showRisks()" >Display Risks</button>
    <button type='button' id="issueBtn" class='deselectedBtn' onclick="showIssues()">Display Issues</button>
</div>
```

The script does require a jQuery library to work - these are detailed on the blog post below. The idea of this script is to add the script to the PWA Project Detail Page via a content editor web part. For details see the blog post below:

http://pwmather.wordpress.com/2015/05/12/projectonline-projectserver-2013-access-sharepoint-lists-on-pdps-javascript-jquery-office365/

A screenshot of the output can be seen below:

![](Images\riskpdp.png)

The script is provided "As is" with no warranties etc.

