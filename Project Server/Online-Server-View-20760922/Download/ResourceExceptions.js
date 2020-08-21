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

	<script type="text/javascript" src="/sites/pwa/Style%20Library/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
 
<h2>Resource Calendar Exception Checker</h2>
Select the Resource: <select id="idRES"></select> 

<br> 
<br>
<table width="100%" align="left" cellpadding="0" border="1" class="stripe hover" id="ResExceptions" style="display:none">
<thead><th>Exception Name</th><th>Start Date</th><th>Finish Date</th><th>Recurrence Type</th><th>Recurrence Frequency</th><th>Duration (Days)</th></thead>
</table>

<script type="text/javascript"> 


$(document).ready(function () {
LoadResources();
});

function LoadResources() {
		var selectArray = [];
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/EnterpriseResources()?"
									+ "&$Select=Name,Id"
									+ "&$orderby=Name",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
									var ResourcesData = data.d.results;
									var select = document.getElementById("idRES");								
                                    for (var i = 0; i < ResourcesData.length; i++) {
										var sname = ResourcesData[i].Name;
										var sid = ResourcesData[i].Id;									
									    selectArray.push(sname);
										selectArray.push(sid);
										select.options[select.options.length] = new Option(sname,sid,false,false);
									}
									var RES = getSelectedKey("idRES");
									LoadResourceData(RES);
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving Resources: " + jqXHR.responseText + "\n\n Drop down will not be populated");
        });
};

function getSelectedKey(selid) {
    var sel = document.getElementById(selid);
    if (sel.selectedIndex == -1) {
        return null;
    }
    return sel.options[sel.selectedIndex].value; 	
}

document.getElementById('idRES').addEventListener('change', function() {
        var RES = getSelectedKey("idRES");
        LoadResourceData(RES);
      }, false);
			
function LoadResourceData(RES) {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/EnterpriseResources('" +RES+ "')/ResourceCalendarExceptions()?"
									+ "&$select=Name,Start,Finish,RecurrenceType,RecurrenceFrequency",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
				$('#ResExceptions').dataTable(	{
										"bDestroy": true,
										"bAutoWidth": false,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"bSort": false,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "Name" },
											{ "mData": "Start" },
											{ "mData": "Finish" },
											{ "mData": "RecurrenceType" ,
												mRender: function(data, type, row){
													if (row.RecurrenceType == 0) {
														return 'Daily';
													} else if (row.RecurrenceType == 1) {
														return 'Daily';
													} else if (row.RecurrenceType == 2) {
														return 'Weekly';
													} else if (row.RecurrenceType == 3) {
														return 'Monthly';
													} else  {
														return 'Yearly';
													}
												}
											},
											{ "mData": "RecurrenceFrequency" },
											{ "mData": "Duration" ,
												mRender: function(data, type, row){
													var startDate = new Date(row.Start);
													var finishDate = new Date(row.Finish);
													var diff = finishDate.getTime() - startDate.getTime();
													var days = diff/(1000 * 60 * 60 * 24)+1;
													if (row.RecurrenceFrequency > 1 || row.RecurrenceFrequency == 1 && row.RecurrenceType == 2 || row.RecurrenceFrequency == 1 && row.RecurrenceType == 4 && days > 1)  {		
														return 'Multiple occurrences';
													} else  {
														return days;
													}
												}											
											}											
										],
										});
										$("#ResExceptions").show();
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving resource data: " + jqXHR.responseText + "\n\n Resource exceptions will not load");
        });
}	
</script>