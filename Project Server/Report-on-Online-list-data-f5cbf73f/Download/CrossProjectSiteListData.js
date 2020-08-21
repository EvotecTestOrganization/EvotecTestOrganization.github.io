<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
	<script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.UI.dialog.js"></script>
 
<h2>Project Site List Report</h2>
Select the EPT: <select id="idEPT"></select> <!--<input type="button" id="idApplyButton" value="Display Projects" >-->
<br>
<br>
<!--Update table headings for correct columns -->
<div id="listTableData">
	<table id="tableSPData"><thead><tr id="tableSPDataHeaderRow"><th>Project Name</th><th>Project Owner</th><th>Item ID</th><th>Title</th><th>Priority</th><th>Status</th></tr></thead>
</div>

<div id="idNoData" style="display:none">
<p><strong>There is no list data for the projects included in the selected EPT <br>Please select another EPT</strong></p>
</div>

<style>
table {	
    width: 90%; 
}

table th {
    background-color: gray;
    color: white;
}

table td, th {
    border: solid 1px gray;
    color: gray;
}
</style>

<script type="text/javascript"> 

var projectData = [];
var projectSiteListItems = [];
var projsiteUrl;
var projectAccess;
var projObject;

//run on page load to get a list of EPTs to populate the selection list
$(document).ready(function () {
LoadEPTs();
});
function LoadEPTs() {
		waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Loading', 'Getting the list report data. This will close when the data is loaded...');
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
									//push the unique EPTs into the array
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
			waitDialog.close();
        });
};

function getSelectedText(selid) {
    var sel = document.getElementById(selid);

    if (sel.selectedIndex == -1) {
        return null;
    }
    return sel.options[sel.selectedIndex].text;
}

//on selection change, get project data and clear arrays and table
document.getElementById('idEPT').addEventListener('change', function() {
		waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Loading', 'Getting the list report data. This will close when the data is loaded...');
        var EPT = getSelectedText("idEPT");
        LoadProjectData(EPT);
		projectData = [];
		projectSiteListItems = [];
		$("#tableSPData td").remove();
		$("#idNoData").hide();
		$("#tableSPData").show();
      }, false);

//get the project site URL,Project Name	and Project Owner 
function LoadProjectData(EPT) {
				var encodedEPT = encodeURIComponent(EPT);
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
									+ "$filter=EnterpriseProjectTypeName eq '"+encodedEPT+"' and ProjectType ne 7 and ProjectWorkspaceInternalUrl ne null"
									+ "&$select=ProjectName,ProjectWorkspaceInternalUrl,ProjectOwnerName",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								//push the project name, owner and project site URL into the array  
								results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									projectData.push({
									project: result.ProjectName,
									projectSiteUrl: result.ProjectWorkspaceInternalUrl,
									projectOwner: result.ProjectOwnerName
									});
								}
								projectAccess = 0;
								GetListData();																			
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
			waitDialog.close();
        });
};
//get the SP list data and populate the table
function GetListData() {
if (projectAccess >= projectData.length) {
		$.each(projectSiteListItems, function (index, value) {
			//Update for the correct columns - order should match the order defined in the HTML table
			$("#tableSPData").append("<tr><td>" + value.projName + "</td><td>" + value.projOwner + "</td><td>" + value.itemId + "</td><td><a href='" + value.siteURL + "/Lists/Issues/DispForm.aspx?ID="+ value.itemId +"'target='_blank'>" + value.itemTitle + "</td><td>" + value.itemPriority + "</td><td>" + value.itemStatus + "</td></tr>");
			});
		Formatting();
		waitDialog.close();
		if (projectSiteListItems[0] === undefined) {
			$("#tableSPData").hide();
			$("#idNoData").show();
			}
		return;		
	} 
		projObject = projectData[projectAccess];
				//Update the REST call for the correct list and columns
				var data = $.ajax({url: projObject.projectSiteUrl + "/_api/Web/Lists/GetByTitle('Issues')/Items()?$Select=Id,Title,Priority,Status",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){ 
								results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									projectSiteListItems.push({
										projName: projObject.project,
										siteURL: projObject.projectSiteUrl,
										projOwner: projObject.projectOwner,
										itemId: result.Id,
										itemTitle: result.Title,
										itemPriority: result.Priority,
										itemStatus: result.Status
										});		
								}
								++projectAccess;
								GetListData(); 
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving SharePoint data: " + jqXHR.responseText + "\n\n SharePoint data will not load");
			waitDialog.close();
        });
};
//example to set conditional formatting on cells based on cell value
function Formatting() {
$("#tableSPData td").each(function () {
	if ($(this).text() == '(1) High') {
		$(this).css({'color':'white','background-color': 'tomato'});
		}
	});
};
</script>