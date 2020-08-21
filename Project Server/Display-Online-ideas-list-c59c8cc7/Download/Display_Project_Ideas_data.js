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

	<script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
 
<h2>Project Ideas List</h2>

<table width="100%" align="left" cellpadding="0" border="1" class="stripe hover" id="ProjectIdeasTable">
<thead><th>Item ID</th><th>Item Title</th><th>Project GUID and link to Project</th></thead>
</table>

<script type="text/javascript"> 

//update project ideas list title
var listName = 'ProjectIdeas';
			
$(document).ready(function(){
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/Web/Lists/GetByTitle('" + listName +"')/Items()?"
									+ "$Select=Id,Title,MSPWAPROJUID",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
				$('#ProjectIdeasTable').dataTable(	{
										"bDestroy": true,
										"bAutoWidth": false,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"bSort": true,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "Id" },
											{ "mData": "Title" },
											{ "mData": "MSPWAPROJUID" }
										],										
										"aoColumnDefs": [
											{ "mRender": function (data, type, row) {
												return '<a href= ' + _spPageContextInfo.siteAbsoluteUrl + '/Lists/'+ listName +'/DispForm.aspx?Id='+ row.Id +' target="_new"> '+ data +'  </a>';
											},
											"aTargets": [1]
											},
											{ "mRender": function (data, type, row) {
												if (row.MSPWAPROJUID != null){
													return 'Click to access the Project: <a href= ' + _spPageContextInfo.siteAbsoluteUrl + '/Project%20Detail%20Pages/Schedule.aspx?ProjUid='+ data +'&ret=0" target="_new"> '+ data +'  </a>';
												} else {
													return 'Project not created';
												}
											},
											"aTargets": [2]
											}										
										],
										});
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving list data: " + jqXHR.responseText + "\n\n Project ideas list data will not load");
        });
});	
</script>