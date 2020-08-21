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

	<script type="text/javascript" src="/sites/pwa/SiteCollectionDocuments/JSFiles/jquery-2.1.1.min.js"></script>
	<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.0/js/jquery.dataTables.js"></script>
 
<h2>Project Site Finder</h2>
Project name contains: <input type="text" id="ProjectName" >
<input type="button" value="Find Project" onclick="LoadProjectData($('#ProjectName').val());" >
<br>
<br>
<table width="100%" align="left" cellpadding="0" border="1" class="stripe hover" id="Projectfield">
<thead><th>Project Name</th><th>Description</th><th>Project Owner</th><th>Project Site URL</th></thead>
</table>

<script type="text/javascript"> 
			
function LoadProjectData(ProjectName) {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectData/[en-US]/Projects()?"
									+ "$filter=(substringof('"+ProjectName+"', ProjectName)) and ProjectType ne 7"
									+ "&$select=ProjectName,ProjectDescription,ProjectOwnerName,ProjectWorkspaceInternalUrl",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
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
											{ "mData": "ProjectWorkspaceInternalUrl" }
										],										
										"aoColumnDefs": [
											{ "mRender": function (data, type, full) {
												return '<a href="'+ data +'" target="_new"> '+ data +'  </a>';
											},
											"aTargets": [3]
											}										
										],
										});
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
        });
}	
</script>