# Capture Project Online user last logon

## Original Links

- [x] Original Technet URL [Capture Project Online user last logon](https://gallery.technet.microsoft.com/Capture-Online-user-last-43621a21)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Capture-Online-user-last-43621a21/description)
- [x] Download: [Download Link](Download\PWAUsage.js)

## Output from Technet Gallery

This simple JavaScript file enables you to capture the PWA users last logon time from the Project Web App homepage. It is simple to deploy and use - you just need to set up the list first. The link to the blog post below details the steps required.

A code snippet can be seen below:

JavaScript

```
<script type="text/javascript">
 ExecuteOrDelayUntilScriptLoaded(getUser, "sp.js");
var PWAUsageListName = 'PWAUsageList' //update for correct list name
var browser
var userId
var userName
var currentUser
//get the current user
function getUser(){
```

 Here is a link to the supporting blog post that details the requirements to use this script:

https://pwmather.wordpress.com/2016/09/30/want-to-capture-the-last-logon-time-for-the-projectonline-pwa-users-ppm-javascript-office365-sharepoint/

