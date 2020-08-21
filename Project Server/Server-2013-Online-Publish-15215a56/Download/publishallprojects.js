	<script type="text/javascript" src="/PWA/SiteAssets/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.runtime.debug.js"></script>
    <script type="text/javascript" src="/_layouts/15/sp.debug.js"></script>
    <script type="text/javascript" src="/_layouts/15/ps.debug.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.UI.dialog.js"></script>

<div id="divButton" style="text-align:left">
	Click the button to publish all projects that you have access to: <input type="button" value="Publish Projects" onclick="GetProjects()" >
</div>	
<div id="divMessage" style="text-align:center">
    <br />
    <h1 id="spanMessage"></h1>
</div>

<script type="text/javascript">
var projContext;
var projects;
var waitDialog; 

function GetProjects() {
	
   projContext = PS.ProjectContext.get_current();
 
   projects = projContext.get_projects();
 
   projContext.load(projects);

   projContext.executeQueryAsync(onQuerySucceeded, onQueryFailed);
   
   waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Publishing', 'Getting the list of projects and publishing. This will close when the projects have been sent for publishing...');
}
 
function onQuerySucceeded(response) {
   var enumerator = projects.getEnumerator();
   while (enumerator.moveNext()) {
      var project = enumerator.get_current();

      var draftProject = project.checkOut();
 
      var publishJob = draftProject.publish(true);
 
      projContext.waitForQueueAsync(publishJob, 30, QueueJobSent);	  
   }
} 

function QueueJobSent(response) {

   if (response == 4) {
		waitDialog.close();
   }
}
 
function onQueryFailed(sender, args) {
   $('#spanMessage').text('Request failed: ' + args.get_message());
}
</script>