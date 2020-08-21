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

<h2>Project Information</h2>

<table width="100%" align="left" cellpadding="0" border="1" id="Projectfield">
<thead><th>Project Name</th><th>Description</th><th>Project Owner</th><th>% Complete</th><th>Project Work</th><th>Project Cost</th><th>Programme</th><th>RAG Status</th></thead>
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
function LoadProjectData() {
        		var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/Projects(guid'"+ ProjectUID +"')?"
									+ "$select=ProjectName,ProjectDescription,ProjectOwnerName,ProjectPercentCompleted,ProjectWork,ProjectCost,Programme,RAGPMStatus",   
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
			data.d.results[0].RAGPMStatus = data.d.RAGPMStatus;
			data.d.results[0].Programme = data.d.Programme;
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
											{ "mData": "Programme" },
											{ "mData": "RAGPMStatus" }
										],										
										"aoColumnDefs": [
											{ "mRender": function (data, type, full) {
												return parseFloat(data).toFixed(2) + "%";
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
											},										
											{ "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
												if (sData == 'On schedule [Green]') { 
													$(nTd).css('background-color', 'green').css('color', 'white'); 
														} else if (sData == 'Slipping but can mitigate [Amber]') { 
															$(nTd).css('background-color', 'orange'); 
														} else { 
															$(nTd).css('background-color', 'red').css('color', 'white'); 
														}
												},
											"aTargets": [7]
											}										
										],
										});
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText);
        });
}
</script>