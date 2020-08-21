<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<!--
Copyright (C) 2008-2014, SpryMedia Ltd.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->

	<script type="text/javascript" src="/sites/pwa/SiteCollectionDocuments/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
   
<h2>Project Details</h2>
<table width="100%" align="left" cellpadding="0" border="1" id="Projectfield">
<thead><th>Project Name</th><th>Description</th><th>Project Owner</th><th>% Complete</th><th>Project Work</th><th>Project Cost</th><th>Project Start</th><th>Project Finish</th></thead>
</table>
<br>
<br>
<h2>Project Milestones</h2>
<table width="50%" align="left" cellpadding="0" cellspacing="0" border="1" class="stripe hover"  id="Milestones">
<thead><th>Milestone Name</th><th>Finish Date</th><th>% Complete</th></thead>
</table>
<br>
<br>
<h2>Active Issues</h2>
<table width="100%" align="left" cellpadding="0" cellspacing="0" border="1" class="stripe hover"  id="Issues">
<thead><th>ID</th><th>Title</th><th>Category</th><th>Discussion</th><th>Owner</th><th>Due Date</th></thead>
</table>
<br>
<br>
<h2>Active Risks</h2>
<table width="100%" align="left" cellpadding="0" cellspacing="0" border="1" class="stripe hover"  id="Risks">
<thead><th>ID</th><th>Title</th><th>Mitigation Plan</th><th>Contingency Plan</th><th>Owner</th><th>Due Date</th></thead>
</table>

<script type="text/javascript"> 

var ProjectUID;

ExecuteOrDelayUntilScriptLoaded(getProjectUIDProperty, "sp.js"); 
 function getProjectUIDProperty() { 
                var ctx = new SP.ClientContext.get_current(); 
                this.web = ctx.get_web(); 
                this.props =  this.web.get_allProperties(); 
                ctx.load(this.web); 
                ctx.load(this.props);                    
                ctx.executeQueryAsync(Function.createDelegate(this, gotProperty), Function.createDelegate(this, failedGettingProperty)); 
            }             
function gotProperty() {                
                 ProjectUID = this.props.get_item('MSPWAPROJUID');
				 LoadProjectData();
            }             
function failedGettingProperty() { 
                alert('Error: ' + args.get_message());
            } 

function convertJSONDate(jsonstring) {
		if (jsonstring == undefined || jsonstring == null)
				return null;

        var fulldatetime = new Date(parseInt(jsonstring.replace('/Date(', '')));
		var day = fulldatetime.getDate();
		var month = fulldatetime.getMonth() +1;
		var year = fulldatetime.getFullYear();
		var fulldate = month + "/" + day + "/" + year;		
			return fulldate;
    }
			
function LoadProjectData() {			
				waitDialogProjData =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Reading Project Data', 'Getting the data for the associated project');
        		var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects(guid'"+ ProjectUID +"')?"
									+ "$select=ProjectName,ProjectDescription,ProjectOwnerName,ProjectPercentCompleted,ProjectWork,ProjectCost,ProjectStartDate,ProjectFinishDate",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });								   
        data.done(function (data,textStatus, jqXHR){
			if (data.d.results == undefined) {	
			data.d.results = new Array();
			data.d.results[0] = new Object();
			data.d.results[0].ProjectDescription = data.d.ProjectDescription;
			data.d.results[0].ProjectOwnerName = data.d.ProjectOwnerName;
			data.d.results[0].ProjectName = data.d.ProjectName;
			data.d.results[0].ProjectPercentCompleted = data.d.ProjectPercentCompleted;
			data.d.results[0].ProjectWork = data.d.ProjectWork;
			data.d.results[0].ProjectCost = data.d.ProjectCost;
			data.d.results[0].ProjectStartDate = data.d.ProjectStartDate;
			data.d.results[0].ProjectFinishDate = data.d.ProjectFinishDate;
			}
		for (var xi=0;xi<data.d.results.length;xi++){
		data.d.results[xi].ProjectStartDate = convertJSONDate(data.d.results[xi].ProjectStartDate);
		data.d.results[xi].ProjectFinishDate = convertJSONDate(data.d.results[xi].ProjectFinishDate);
		}
			
            $('#Projectfield').dataTable(	{
										"bDestroy": true,
										"bAutoWidth": false,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"bSort": false,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "ProjectName" },
											{ "mData": "ProjectDescription" },
											{ "mData": "ProjectOwnerName" },
											{ "mData": "ProjectPercentCompleted" },
											{ "mData": "ProjectWork" },
											{ "mData": "ProjectCost" },
											{ "mData": "ProjectStartDate" },
											{ "mData": "ProjectFinishDate" }
										],										
										"aoColumnDefs": [
											{ "mRender": function (data, type, full) {
												return parseFloat(data).toFixed(0) + "%";
											},
											"aTargets": [3]
											},
											{ "mRender": function (data, type, full) {
												return parseFloat(data).toFixed(2) + " hrs";
											},
											"aTargets": [4]
											},
											{ "mRender": function (data, type, full) {
												return "£" + parseFloat(data).toFixed(2);
											},
											"aTargets": [5]
											}										
										],
										});
										LoadMilestones();
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialogProjData.close();
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project, Milestone, Issue and Risk data will not load");
        });
										
		
function LoadMilestones() {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects(guid'"+ ProjectUID +"')/Tasks()?"
									+ "$Select=TaskName,TaskFinishDate,TaskPercentCompleted&$filter=TaskIsMilestone eq true",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
		for (var xi=0;xi<data.d.results.length;xi++){
		data.d.results[xi].TaskFinishDate = convertJSONDate(data.d.results[xi].TaskFinishDate);
		}
            $('#Milestones').dataTable(	{
										"bDestroy": true,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"order": [[ 1, "asc" ]],
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "TaskName" },
											{ "mData": "TaskFinishDate" },
											{ "mData": "TaskPercentCompleted" }
										],										
										"aoColumnDefs": [
											{ "mRender": function (data, type, full) {
												return parseFloat(data).toFixed(0) + "%";
											},
											"aTargets": [2]
											}										
										],
										});
										LoadIssues();
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialogProjData.close();
            alert("Error retrieving milestones: " + jqXHR.responseText + "\n\n Milestone, Issue and Risk data will not load");
        });

function LoadIssues() {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects(guid'"+ ProjectUID +"')/Issues()?"
        							+ "$Select=ItemRelativeUrlPath,Title,Category,Discussion,Owner,DueDate&$filter=Status eq '(1) Active'",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
		for (var xi=0;xi<data.d.results.length;xi++){
		data.d.results[xi].DueDate = convertJSONDate(data.d.results[xi].DueDate);
		}
            $('#Issues').dataTable(	{
										"bDestroy": true,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "ItemRelativeUrlPath" },
											{ "mData": "Title" },
											{ "mData": "Category" },
											{ "mData": "Discussion" },
											{ "mData": "Owner" },
											{ "mData": "DueDate"}
										]
										});
										LoadRisks();
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialogProjData.close();
            alert("Error retrieving issues: " + jqXHR.responseText + "\n\n Issue and Risk data will not load");
        });		

function LoadRisks() {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects(guid'"+ ProjectUID +"')/Risks()?"
        							+ "$Select=ItemRelativeUrlPath,Title,MitigationPlan,ContingencyPlan,Owner,DueDate&$filter=Status eq '(1) Active'",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
		for (var xi=0;xi<data.d.results.length;xi++){
		data.d.results[xi].DueDate = convertJSONDate(data.d.results[xi].DueDate);
		}
            $('#Risks').dataTable(	{
										"bDestroy": true,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "ItemRelativeUrlPath" },
											{ "mData": "Title" },
											{ "mData": "MitigationPlan" },
											{ "mData": "ContingencyPlan" },
											{ "mData": "Owner" },
											{ "mData": "DueDate" }
										]
										});
										waitDialogProjData.close();										
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
			waitDialogProjData.close();
            alert("Error retrieving risks: " + jqXHR.responseText + "\n\n Risk data will not load");
        });
}
}
}
}		
</script>