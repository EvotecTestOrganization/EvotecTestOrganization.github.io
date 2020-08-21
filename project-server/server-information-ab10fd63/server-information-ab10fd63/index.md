# Project Server Project Information displayed on the Project Si

## Original Links

- [x] Original Technet URL [Project Server Project Information displayed on the Project Si](https://gallery.technet.microsoft.com/Server-Information-ab10fd63)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Information-ab10fd63/description)
- [x] Download: [Download Link](Download\project information on project site.js)

## Output from Technet Gallery

This JavaScript file displays the project level fields on the associated Project Site in Project Server 2013 / Project Online. This script will display the following default fields:

- Project Name

- Project Description

- Project Owner

- % Complete

- Work

- Cost

It also displays two custom fields:

- Programme

- RAG PM Status - based on a lookup table with the following values: "On schedule [Green]", "Slipping but can mitigate [Amber]" and "Slipped and cannot mitigate [Red]"

For the script to work "out of the box" you will need to add those fields to your Project Server / Project Online config, otherwise edit the script to remove those fields and associated code or replace those fields / modify the code with fields of your  own. A code snippet can be seen below:

JavaScript

```
<script type="text/javascript">
 var ProjectUID;
 ExecuteOrDelayUntilScriptLoaded(getProjectUIDProperty, "sp.js");
 function getProjectUIDProperty() {
                var ctx = new SP.ClientContext.get_current();
                this.web = ctx.get_web();
```

Example outputs can be seen below:

![](Images\projinfo1.png)

Another image:

![](Images\projinfo2.png)

The blog post below details how to use the script and highlights parts of the script that would need to be edited for your own custom fields etc.

http://pwmather.wordpress.com/2014/06/10/supporting-post-for-projectserver-2013-projectonline-project-fields-displayed-on-project-site-javascript-jquery/

