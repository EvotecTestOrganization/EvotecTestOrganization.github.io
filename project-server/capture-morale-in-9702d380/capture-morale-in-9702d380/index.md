# Capture Project Team Morale in SharePoint / Project Online / Project Server 2013

## Original Links

- [x] Original Technet URL [Capture Project Team Morale in SharePoint / Project Online / Project Server 2013](https://gallery.technet.microsoft.com/Capture-Morale-in-9702d380)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Capture-Morale-in-9702d380/description)
- [x] Download: [Download Link](Download\project_team_morale.js)

## Output from Technet Gallery

This simple JavaScript file enables you to capture the project team morale from the Project Web App homepage or anyother SharePoint site. It is simple to deploy and use - just need to set up the list first. The link to the blog post below details the steps  required.

A code sample can be seen below:

JavaScript

```
<script type="text/javascript">
 ExecuteOrDelayUntilScriptLoaded(getUser, "sp.js");
var userId
var userName
var currentUser;
//get the current user
function getUser(){
    this.clientContext = new SP.ClientContext.get_current();
    this.oWeb = clientContext.get_web();
    currentUser = this.oWeb.get_currentUser();
    this.clientContext.load(currentUser);
    this.clientContext.executeQueryAsync(
        Function.createDelegate(this,this.onQuerySucceededUser),
        Function.createDelegate(this,this.onQueryFailedUser));
```

Once loaded to the PWA site it will look like the example below:

![](Images\projectmorale.jpg)

Here is a link to the supporting blog post that details the requirements to use this script:

https://pwmather.wordpress.com/2015/12/01/want-to-capture-your-project-team-staff-morale-projectonline-projectserver-sharepoint-ppm-javascript-jquery/

