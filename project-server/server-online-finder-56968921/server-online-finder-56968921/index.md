# Project Server / Project Online Project Site Finder

## Original Links

- [x] Original Technet URL [Project Server / Project Online Project Site Finder](https://gallery.technet.microsoft.com/Server-Online-Finder-56968921)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Online-Finder-56968921/description)
- [x] Download: [Download Link](Download\Project Site Finder.js)

## Output from Technet Gallery

This JavaScript file enables the user to quickly find / navigate to the Project Site in Project Server 2013 / Project Online. The script can be added to the PWA site collection, for example on the PWA homepage for easy access. A code snippet can be  seen below:

JavaScript

```
<script type="text/javascript" src="/sites/pwa/SiteCollectionDocuments/JSFiles/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
```

The script does require some jQuery libraries to work - these are detailed on the blog post below. The idea of this script is to add the script to the PWA site via a content editor web part. For details see the blog post below:

http://pwmather.wordpress.com/2014/12/01/projectonline-projectserver-project-site-finder-javascript-jquery-office365-sharepoint/

A screenshot of the output can be seen below:

Type part of the project name and click "Find Project"

![](Images\projsitefinder.png)

The script is provided "As is" with no warranties etc.

