# Project Online / Project Server PDP tabs

## Original Links

- [x] Original Technet URL [Project Online / Project Server PDP tabs](https://gallery.technet.microsoft.com/Online-Server-PDP-tabs-c8012555)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Server-PDP-tabs-c8012555/description)
- [x] Download: [Download Link](Download\PWAPDPTabs.js)

## Output from Technet Gallery

This simple JavaScript solution starter enables you to display your Project Online Project Detail Pages (PDP) web parts on tabs. The code will need updating to work for your Project Online configuration as you will have different PDPs on the page. It is  very simple to update.

A code snippet can be seen below - full code available in the download:

JavaScript

```
$(document).ready(function () {
$("#MSOZoneCell_WebPartWPQ4").hide();
$("#MSOZoneCell_WebPartWPQ3").appendTo("#details");
$("#MSOZoneCell_WebPartWPQ4").appendTo("#info");
});
$(function() {
        $('#tabs').tabs();
            });
```

Here is a link to the supporting blog post that details the requirements to use this solution starter script:

https://pwmather.wordpress.com/2018/03/04/projectonline-projectserver-display-project-detail-page-web-parts-using-tabs-ppm-msproject-javascript-jquery/

The script is provided "As is" with no warranties etc.

