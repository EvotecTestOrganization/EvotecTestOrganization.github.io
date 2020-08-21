# Project Server / Project Online Project Cost and Work Report Exampl

## Original Links

- [x] Original Technet URL [Project Server / Project Online Project Cost and Work Report Exampl](https://gallery.technet.microsoft.com/Server-Online-Cost-and-83bbff27)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Online-Cost-and-83bbff27/description)
- [x] Download: [Download Link](Download\Projects Cost and Work - Charts.js)

## Output from Technet Gallery

This JavaScript file enables the user to see project cost and work on a column chart in Project Online / Project Server 2013. The example script can be added to a page in the PWA site collection using a content editor web part. A code snippet can be seen  below:

JavaScript

```
<h2>Project Cost and Work</h2>
Select the EPT: <select id="idEPT"></select> <!--<input type="button" id="idApplyButton" value="Display Projects" >-->
<h3>Project Cost Chart</h3>
<div id="costChart" style="min-width: 400px; height: 600px; margin: 0 auto"></div>
<h3>Project Work Chart</h3>
<div id="workChart" style="min-width: 400px; height: 600px; margin: 0 auto"></div>
<script type="text/javascript">
$(document).ready(function () {
LoadEPTs();
});
function LoadEPTs() {
```

 The script requires jQuery to work and also makes use of a charting library called Highcharts.**Highcharts is not free for commercial use**, see the link below:

http://shop.highsoft.com/faq/non-commercial#what-is-non-commercial

If you do use this library in scripts or applications that you sell / anything commercial you will need to purchase the correct licence to do so.

Other charting libraries can be used, just update the code as required based on the chosen chart library.

For more details on this script see the blow post below:

http://pwmather.wordpress.com/2015/02/25/projectonline-projectserver-project-cost-and-work-report-javascript-jquery-office365-sharepoint-bi-ppm/

A screenshot of the report can be seen below:

![](Images\report.png)

The script is provided "As is" with no warranties etc.

