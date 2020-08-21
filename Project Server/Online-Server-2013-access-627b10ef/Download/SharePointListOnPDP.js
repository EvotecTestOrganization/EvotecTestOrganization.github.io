<!--Copyright (C) 2014, jQuery Foundation

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->

	<script type="text/javascript" src="/sites/pwa/Style%20Library/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.runtime.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.js"></script>
    <script type="text/javascript" src="/_layouts/15/ps.js"></script>
<div id="divMessage">
    <br/>
    <span id="spanMessage" style="color: #FF0000;"></span>
</div>
<p id="messages"></p>
	
<div id="buttons">
    <button type='button' id="riskBtn" class='deselectedBtn' onclick="showRisks()" >Display Risks</button>
    <button type='button' id="issueBtn" class='deselectedBtn' onclick="showIssues()">Display Issues</button>
</div>	

<div id="riskDiv" style="display:none">
	<h1>Risk List</h1>
	<div id="riskTable"></div>
</div> 

<div id="issueDiv" style="display:none">
	<h1>Issue List</h1>
    <div id="issueTable"></div>
</div>

<style type="text/css">
.selectedBtn {
	background-color: grey;
	color: white;
	text-decoration: underline;
}
.deselectedBtn {
	background-color: white;
	color: black;
	text-decoration: none;
}
</style>
	
<script type="text/javascript">

$(document).ready(function () {
getProjectUID();
});

var projects;
SP.SOD.executeOrDelayUntilScriptLoaded(GetProjects, "PS.js");

//get project UID from the URL
function getProjectUID(){
	var urlStr = unescape(window.location)
	if (urlStr.toLowerCase().indexOf('projuid')>=0) {
	projUid = urlStr.substr(urlStr.indexOf("=")+1,36) 
		}
	else {
		$("#messages").html("Not available in this context. Not a Project Server Project Detail Page or project associated");
		$("#buttons").hide();
		}
}

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
		showRisks();
}
function onQueryFailed(sender, args) {
	$get("spanMessage").innerText = 'Request failed: ' + args.get_message();
}	
	
function showRisks() {
    $("#issueDiv").hide();
    $("#riskDiv").show();
	$("#riskTable").html('<object width="950" height="800" data= "'+projSiteUrl+'/Lists/Risks/AllItems.aspx?isdlg=1"/>');	
    $("#riskBtn").addClass("selectedBtn").removeClass("deselectedBtn");
    $("#issueBtn").removeClass("selectedBtn");
}

function showIssues() {
    $("#riskDiv").hide();
    $("#issueDiv").show();
	$("#issueTable").html('<object width="950" height="800" data= "'+projSiteUrl+'/Lists/Issues/AllItems.aspx?isdlg=1"/>');
    $("#riskBtn").removeClass("selectedBtn");
    $("#issueBtn").addClass("selectedBtn").removeClass("deselectedBtn");
}
</script>