<!--Copyright (C) 2014, jQuery Foundation
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<!-- 
Created by Paul Mather 
Blog: https://pwmather.wordress.com
Twitter: @pwmather
MVP Profile: https://mvp.microsoft.com/en-us/PublicProfile/5000025
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. THIS IS A SOLUTION STARTER / EXAMPLE CODE AND IS NOT SUITABLE FOR PRODUCTION USE.
-->
	<link  type="text/css" href = "//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel = "stylesheet">
	<script type="text/javascript" src = "//code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript" src = "//code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
	<script type="text/javascript" src ="/_layouts/15/sp.runtime.js"></script>
	<script type="text/javascript" src ="/_layouts/15/sp.js"></script>
	<script type="text/javascript" src ="/_layouts/15/sp.UI.dialog.js"></script>  

<div id="accordion">		
	<h3>Projects</h3>
	<div>
	  <table id="projTableData"></table>			
	</div>
	<h3>Resources / Users</h3>
	<div>
	  <table id="resTableData"></table>			
	</div>
	<h3>Issues</h3>
	<div>
	  <table id="issueTableData"></table>				
	</div>
	<h3>Risks</h3>
	<div>
	  <table id="riskTableData"></table>				
	</div>
</div>
<br>
<div class="button">
	<input type="button" id="btnSave" value="Snapshot" />
</div>
<br>
<p id="messages"></p>

<style>
table {	
    width: 30%; 
}
</style> 

<script type="text/javascript"> 
//update for correct SharePoint list title
var listTitle = "PWASnapshot";

//jQuery UI accordion
$( function() {
	$("#accordion").accordion({
	  heightStyle: "content",
	  collapsible: true,
	  active: false,
	});
} );

//project arrays
var projectData = [];
var completedProjects = [];
var notstartedProjects = [];
var inprogressProjects = [];
var lateactiveProjects = [];

//resource arrays
var resourceData = [];
var activeResources = [];
var genericResources = [];

//issues arrays
var issueData = [];
var activeIssues = [];

//risks arrays
var riskData = [];
var activeRisks = [];

//run on page load 
$(document).ready(function () {
LoadProjectData();
LoadResourceData();
LoadIssueData();
LoadRiskData();
waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Loading Data', 'Loading project, resource, issues and risks data');
});

//get the project data
var urlProj = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
									+ "$filter=ProjectType ne 7"
									+ "&$select=ProjectId,ProjectPercentCompleted,ProjectFinishVariance";
var allProjects = []; 
function LoadProjectData() {
				var data = $.ajax({url: urlProj,   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								allProjects = allProjects.concat(data.d.results);
								if (data.d.__next) {
									urlProj = data.d.__next;
									LoadProjectData();
								} else {								
									//push the project ID, % complete and finish variance into the array  
									for (var i = 0, len = allProjects.length; i < len; i++) {
										var project = allProjects[i];
										projectData.push({
										project: project.ProjectId,
										projectProgress: project.ProjectPercentCompleted,
										projectFinishVariance: project.ProjectFinishVariance
										});
									}								
									DisplayProjectData();
									waitDialog.close();
								}
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialog.close();
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
        });
};

//get the resource data
var urlRes = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Resources()?"
									+ "&$select=ResourceId,ResourceIsActive,ResourceIsGeneric";
var allResources = [];
function LoadResourceData() {
				var data = $.ajax({url: urlRes,   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								allResources = allResources.concat(data.d.results);
								if (data.d.__next) {
									urlRes = data.d.__next;
									LoadResourceData();
								} else {
									//push the resource ID, active and generic into the array 
									for (var i = 0, len = allResources.length; i < len; i++) {
										var resource = allResources[i];
										resourceData.push({
										resource: resource.ResourceId,
										activeResource: resource.ResourceIsActive,
										genericResource: resource.ResourceIsGeneric
										});
									}
									DisplayResourceData();
								}
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialog.close();
            alert("Error retrieving resource data: " + jqXHR.responseText + "\n\n Resource data will not load");
        });
};

//get the issues data
var urlIssues = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Issues()?"
									+ "&$select=IssueId,Status";
var allIssues = [];
function LoadIssueData() {
				var data = $.ajax({url: urlIssues,   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								allIssues = allIssues.concat(data.d.results);
								if (data.d.__next) {
									urlIssues = data.d.__next;
									LoadIssueData();
								} else {
									//push the ID and status into the array
									for (var i = 0, len = allIssues.length; i < len; i++) {
										var issue = allIssues[i];
										issueData.push({
										issue: issue.IssueId,
										issueStatus: issue.Status
										});
									}
									DisplayIssueData();
								}
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialog.close();
            alert("Error retrieving issue data: " + jqXHR.responseText + "\n\n Issue data will not load");
        });
};

//get the risks data
var urlRisks = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Risks()?"
									+ "&$select=RiskId,Status";
var allRisks = [];
function LoadRiskData() {
				var data = $.ajax({url: urlRisks,   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								allRisks = allRisks.concat(data.d.results);
								if (data.d.__next) {
									urlRisks = data.d.__next;
									LoadRiskData();
								} else {
									//push the ID and status into the array
									for (var i = 0, len = allRisks.length; i < len; i++) {
										var risk = allRisks[i];
										riskData.push({
										risk: risk.RiskId,
										riskStatus: risk.Status
										});
									}
									DisplayRiskData();
								}
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialog.close();
            alert("Error retrieving risk data: " + jqXHR.responseText + "\n\n Risk data will not load");
        });
};

//calculate the project counts populate the table
function DisplayProjectData() {	
//completed projects
for (var i = 0; i < projectData.length ; i++) {
    if (projectData[i].projectProgress === 100) {
        completedProjects.push(projectData[i]);
    }
}
//not start projects
for (var i = 0; i < projectData.length ; i++) {
    if (projectData[i].projectProgress === 0) {
        notstartedProjects.push(projectData[i]);
    }
}
//in progress projects	
for (var i = 0; i < projectData.length ; i++) {
    if (projectData[i].projectProgress > 0 && projectData[i].projectProgress < 100) {
        inprogressProjects.push(projectData[i]);
    }
}
//late active projects	
for (var i = 0; i < projectData.length ; i++) {
    if (projectData[i].projectProgress > 0 && projectData[i].projectProgress < 100 && projectData[i].projectFinishVariance > 0) {
        lateactiveProjects.push(projectData[i]);
    }
}
//populate the table
$("#projTableData").append("<tr><td>Total: </td><td>" + projectData.length + "</td></tr><tr><td>Completed: </td><td>" + completedProjects.length + "</td></tr><tr><td>Not Started: </td><td>" + notstartedProjects.length + "</td></tr><tr><td>In Progress: </td><td>" + inprogressProjects.length + "</td></tr><tr><td>Late, In Progress: </td><td>" + lateactiveProjects.length + "</td></tr>");

};

//calculate the resource counts populate the table
function DisplayResourceData() {
//active resources
for (var i = 0; i < resourceData.length ; i++) {
    if (resourceData[i].activeResource === true) {
        activeResources.push(resourceData[i]);
    }
}
//generic resources
for (var i = 0; i < resourceData.length ; i++) {
    if (resourceData[i].genericResource === true) {
        genericResources.push(resourceData[i]);
    }
}
//populate the table
$("#resTableData").append("<tr><td>Total: </td><td>" + resourceData.length + "</td></tr><tr><td>Active: </td><td>" + activeResources.length + "</td></tr><tr><td>Generic: </td><td>" + genericResources.length + "</td></tr>");

};

//calculate the issue counts populate the table
function DisplayIssueData() {
//active resources
for (var i = 0; i < issueData.length ; i++) {
    if (issueData[i].issueStatus === "(1) Active") {
        activeIssues.push(issueData[i]);
    }
}
//populate the table
$("#issueTableData").append("<tr><td>Total: </td><td>" + issueData.length + "</td></tr><tr><td>Active: </td><td>" + activeIssues.length + "</td></tr>");

};

//calculate the risk counts populate the table
function DisplayRiskData() {
//active resources
for (var i = 0; i < riskData.length ; i++) {
    if (riskData[i].riskStatus === "(1) Active") {
        activeRisks.push(riskData[i]);
    }
}
//populate the table
$("#riskTableData").append("<tr><td>Total: </td><td>" + riskData.length + "</td></tr><tr><td>Active: </td><td>" + activeRisks.length + "</td></tr>");

};

//snapshot button
$("#btnSave").click(function () {
	waitDialogUpdate =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Data Snapshot', 'Creating snapshot item in SharePoint list');
	$("#messages").html("");
	snapshotData();
});

//create snapshot item
function snapshotData() {       
    ctx = SP.ClientContext.get_current();   
    var snapshotList = ctx.get_web().get_lists().getByTitle(listTitle);    
    var itemCreationInfo = new SP.ListItemCreationInformation();   
    var listItem = snapshotList.addItem(itemCreationInfo);
	listItem.set_item('Title', "Snapshot item"); 	
    listItem.set_item('TotalProjects', projectData.length);  
	listItem.set_item('CompletedProjects', completedProjects.length);
	listItem.set_item('NotStartedProjects', notstartedProjects.length);
	listItem.set_item('InProgressProjects', inprogressProjects.length);
	listItem.set_item('LateInProgressProjects', lateactiveProjects.length);
    listItem.set_item('TotalResources', resourceData.length); 
	listItem.set_item('ActiveResources', activeResources.length); 
	listItem.set_item('GenericResources', genericResources.length); 
	listItem.set_item('TotalIssues', issueData.length);	
	listItem.set_item('ActiveIssues', activeIssues.length);
	listItem.set_item('TotalRisks', riskData.length);
	listItem.set_item('ActiveRisks', activeRisks.length);
    listItem.update();   
    ctx.load(listItem);   
    ctx.executeQueryAsync(listItemSucceeded, listItemFailed);   
}
  
function listItemSucceeded()   
{   
    waitDialogUpdate.close();
	$("#messages").html("item added to the snapshot list");
}
  
function listItemFailed(sender, args)   
{   
    waitDialogUpdate.close();
	alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());   
} 
</script>