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

<h1>Project Milestones</h1>

<table width="50%" align="left" cellpadding="0" cellspacing="0" border="1" class="stripe hover"  id="Milestones">
<thead><th>Milestone Name</th><th>Finish Date</th><th>% Complete</th></thead>
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
				 LoadMilestones();
            }             
function failedGettingProperty() { 
                alert('Error: ' + args.get_message());
            } 

function LoadMilestones() {
        		var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects('"+ ProjectUID +"')/Tasks()?"
									+ "$Select=Name,Finish,PercentComplete&$filter=IsMilestone eq true",   
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
            $('#Milestones').dataTable(	{
										"bDestroy": true,
										"bFilter": false,
										"bInfo": false,
										"bProcessing": true,
										"bPaginate": false,
										"aaData": data.d.results,
										"aoColumns": [
											{ "mData": "Name" },
											{ "mData": "Finish" },
											{ "mData": "PercentComplete" }
										]
										});
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving milestones: " + jqXHR.responseText);
        });
}
</script>