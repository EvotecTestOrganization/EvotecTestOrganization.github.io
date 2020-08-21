	<script type="text/javascript" src="/PWA/SiteAssets/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/PWA/SiteAssets/knockout-3.1.0.js"></script>
	<script type="text/javascript" src="/PWA/SiteAssets/ko.sp-1.0.min.Ex.js"></script>  
	<script type="text/javascript" src="/_layouts/15/sp.runtime.debug.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.debug.js"></script>
    <script type="text/javascript" src="/_layouts/15/ps.debug.js"></script>

<script type=text/javascript>
var urlStr = unescape(window.location)
if (urlStr.toLowerCase().indexOf('projuid')>=0) {
var projUid = urlStr.substr(urlStr.indexOf("=")+1,36)
}
else {
document.write("Not available in this context. Not a Project Server Project Detail Page or project associated");
}
</script>
   
<div id="divMessage">
    <br/>
    <span id="spanMessage" style="color: #FF0000;"></span>
</div>

<style type="text/css">
.tableGrid th { width:2%; padding:4; border:1px solid; }
.tableGrid td { padding:2; border:1px solid; } 
.tableGrid tr:nth-child(even) {
	background: #E5E4E2;
}
.tableGrid tr:nth-child(odd) {
background: #FFFFFF;
}
</style>

<h1>Risk Data</h1>
 <br />
   
 <div id="riskDiv">
     <table class="tableGrid">
         <thead>
             <tr>
                 <th>Risk Title</th>
                 <th>Due Date</th>
				 <th>Status</th>
                 <th>Cost</th>
                 <th>Probability</th>
                 <th>Impact</th>
                 <th>Assigned To</th>  
             </tr>
         </thead>
         <tbody data-bind="template: { name: 'risktable', foreach: Items }" />
     </table>
 </div> 
 <br />
<h1>Issue Data</h1>
 <br />
 <div id="issueDiv">
     <table class="tableGrid">
         <thead>
             <tr>
                 <th>Issue Title</th>
                 <th>Due Date</th>
				 <th>Status</th>
                 <th>Priority</th>
				 <th>Assigned To</th>
                 <th>Modified By</th>  
             </tr>
         </thead>
         <tbody data-bind="template: { name: 'issuetable', foreach: Items }" />
     </table>
 </div> 

<script type="text/javascript">

    var projects;
    SP.SOD.executeOrDelayUntilScriptLoaded(GetProjects, "PS.js");

    function GetProjects() {

        var projContext = PS.ProjectContext.get_current();

        projects = projContext.get_projects();

        projContext.load(projects, 'Include(Name, Id, ProjectSiteUrl)');

        projContext.executeQueryAsync(onQuerySucceeded, onQueryFailed);
    }
    function onQuerySucceeded(sender, args) {

        var projectEnumerator = projects.getEnumerator();
		var proj;
        while (projectEnumerator.moveNext()) {
            var project = projectEnumerator.get_current();

				if (project.get_id() == projUid) {
                  proj = project;
				}
		}
           	projSiteUrl = proj.get_projectSiteUrl();

			ko.applyBindings(new KoSpModal1(), riskDiv);                                     
            ko.applyBindings(new KoSpModal2(), issueDiv);
    }
    function onQueryFailed(sender, args) {
        $get("spanMessage").innerText = 'Request failed: ' + args.get_message();
    }
</script>

 <script type="text/html" id="risktable">
     <tr>
         <td data-bind="text:Title"></td>
         <td data-bind="spDate:DueDate,defaultValue:' NA'"></td>
		 <td data-bind="spChoice:Status"></td>
         <td data-bind="spNumber:Cost,dataFormat:'£0.00',defaultValue:'£0.00'"></td>
         <td data-bind="spNumber:Probability,dataFormat:'0.00 %',defaultValue:'0.00 %'"align="center"></td>
         <td data-bind="spNumber:Impact,dataFormat:'0.00'"align="center"></td>
         <td data-bind="spUser:AssignedTo"></td>
     </tr>
 </script>
 <script type="text/javascript">
     function KoSpModal1() {
         var self = this;
		 self.Items = ko.observableArray([]);
         $.getJSON(projSiteUrl + "/_vti_bin/listdata.svc/Risks?$expand=Status,AssignedTo&$select=Title,DueDate,Status,Cost,Probability,Impact,AssignedTo",
             function (data) {
                 if (data.d.results) {
                     self.Items(ko.toJS(data.d.results));
                 }
             }
       )
     }
 </script>
  <script type="text/html" id="issuetable">
     <tr>
         <td data-bind="text:Title"></td>
         <td data-bind="spDate:DueDate,defaultValue:' NA'"></td>
		 <td data-bind="spChoice:Status"></td>
         <td data-bind="spChoice:Priority"></td>
		 <td data-bind="spUser:AssignedTo"></td>
         <td data-bind="spUser:ModifiedBy"></td>
     </tr>
 </script>
 <script type="text/javascript">
     function KoSpModal2() {
         var self = this;
         self.Items = ko.observableArray([]);
         $.getJSON(projSiteUrl + "/_vti_bin/listdata.svc/Issues?$expand=Status,Priority,AssignedTo,ModifiedBy&$select=Title,DueDate,Status,Priority,AssignedTo,ModifiedBy",
             function (data) {
                 if (data.d.results) {
                     self.Items(ko.toJS(data.d.results));
                 }
             }
       )
     }
 </script>