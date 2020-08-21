<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<!-- Highcharts
 This script makes the use of a JavaScript charting library called Highcharts. Highcharts is not free for commercial use. For details see the link below:
 http://shop.highsoft.com/faq/non-commercial#what-is-non-commercial
-->
	<script type="text/javascript" src="/sites/pwa/Shared%20Documents/jquery-2.1.1.min.js"></script>
	<script src="//code.highcharts.com/highcharts.js"></script>
	<script src="//code.highcharts.com/modules/exporting.js"></script>
 
<h2>Project Cost and Work</h2>
Select the EPT: <select id="idEPT"></select> <!--<input type="button" id="idApplyButton" value="Display Projects" >-->
<br>
<h3>Project Cost Chart</h3>
<div id="costChart" style="min-width: 400px; height: 600px; margin: 0 auto"></div>

<h3>Project Work Chart</h3>
<div id="workChart" style="min-width: 400px; height: 600px; margin: 0 auto"></div>

<script type="text/javascript"> 

$(document).ready(function () {
LoadEPTs();
});
function LoadEPTs() {
		var selectArray = [];
		var uniqvalues = [];
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
									+ "$filter=ProjectType ne 7"
									+ "&$select=EnterpriseProjectTypeName"
									+ "&$orderby=EnterpriseProjectTypeName",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
									var EntProjTypes = data.d.results;
									var select = document.getElementById("idEPT");
									select.options.length = 0;								
                                    for (var i = 0; i < EntProjTypes.length; i++) {
									var sname = EntProjTypes[i].EnterpriseProjectTypeName;
									if (uniqvalues[sname] == undefined){
										var ix = selectArray.length;
										uniqvalues[sname]=sname;										
										selectArray.push(sname);
										select.options[ix] = new Option(sname,ix,false,false);
									}
									}
									var EPT = getSelectedText("idEPT");
									LoadProjectData(EPT);
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project EPTs: " + jqXHR.responseText + "\n\n Drop down will not be populated");
        });
};

function getSelectedText(selid) {
    var sel = document.getElementById(selid);

    if (sel.selectedIndex == -1) {
        return null;
    }
    return sel.options[sel.selectedIndex].text;
}

document.getElementById('idEPT').addEventListener('change', function() {
        var EPT = getSelectedText("idEPT");
        LoadProjectData(EPT);
      }, false);
			
function LoadProjectData(EPT) {				
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
									+ "$filter=EnterpriseProjectTypeName eq '"+EPT+"' and ProjectType ne 7"
									+ "&$select=ProjectName,ProjectCost,ProjectActualCost,ProjectWork,ProjectActualWork",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								var ChartDataProjectName = [], results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									ChartDataProjectName.push(result.ProjectName);
								}
								var CostChartDataProjectCost = [], results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									CostChartDataProjectCost.push(parseFloat(result.ProjectCost));
								}
								var CostChartDataProjectActualCost = [], results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									CostChartDataProjectActualCost.push(parseFloat(result.ProjectActualCost));
								}
								var WorkChartDataProjectWork = [], results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									WorkChartDataProjectWork.push(parseFloat(result.ProjectWork));
								}
								var WorkChartDataProjectActualWork = [], results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									WorkChartDataProjectActualWork.push(parseFloat(result.ProjectActualWork));
								}
								$(function () {
									$('#costChart').highcharts({
										chart: {
											type: 'column'
										},
										title: {
											text: 'Project Cost and Actual Cost'
										},
										xAxis: {
											categories: ChartDataProjectName,
											labels: {
												rotation: -75,
													style: {
														fontSize: '9px',
														fontFamily: 'Verdana, sans-serif'
													}
											}
										},
										yAxis: {
											title: {
											text: 'Project Cost (£)'
											}
										},
										legend: {
											enabled: false
										},
										credits: {
											enabled: true
										},
										series: [{
											name: 'Cost',
											data: CostChartDataProjectCost,
										},
										{
											name: 'Actual Cost',
											data: CostChartDataProjectActualCost,
										}
										],										
									});
									
									$('#workChart').highcharts({
										chart: {
											type: 'column'
										},
										title: {
											text: 'Project Work and Actual Work'
										},
										xAxis: {
											categories: ChartDataProjectName,
											labels: {
												rotation: -75,
													style: {
														fontSize: '9px',
														fontFamily: 'Verdana, sans-serif'
													}
											}
										},
										yAxis: {
											title: {
											text: 'Project Work (hrs)'
											}
										},
										legend: {
											enabled: false
										},
										credits: {
											enabled: true
										},
										series: [{
											name: 'Work',
											data: WorkChartDataProjectWork,
										},
										{
											name: 'Actual Work',
											data: WorkChartDataProjectActualWork,
										}],										
									});
									
								});		
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
        });
}
</script>