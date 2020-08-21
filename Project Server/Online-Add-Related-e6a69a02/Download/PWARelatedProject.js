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
	<script type="text/javascript" src="//code.jquery.com/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.js"></script>
	<script type="text/javascript" src="/_layouts/15/sp.UI.dialog.js"></script>
<h2>Related Projects</h2>
<section class="projects">
    <div>
        <select id="availableProjects" size="10" multiple></select>
    </div>
    <div>
        <input type="button" id="btnAllRight" value=">>" title="Add All" />
		<input type="button" id="btnRight" value=">" title="Add" />
        <input type="button" id="btnLeft" value="<" title="Remove" />
		<input type="button" id="btnAllLeft" value="<<" title="Remove All" />
    </div>
    <div>
        <select id="relatedProjects" size="10" multiple></select>
    </div>
</section>
    <div class="actionbuttons">
        <input type="button" id="btnSave" value="Save" />
        <input type="button" id="btnCanel" value="Clear" />
    </div>
<p id="messages"></p>
<style>
SELECT, INPUT[type="text"] {
    width: 300px;
}
.projects {
    overflow: auto;
}
.projects> div {
    float: left;
    padding: 2px;
}
.projects > div + div {
    width: 150px;
    text-align: center;
}
</style> 

<script type="text/javascript"> 

var projectData = [];
var selectedProjectData = [];
var projUid;

// update for the correct internal custom field name
var projectCFInternalName = "Custom_0b7b4a31105ae81180d900155d0c9009";

//run on page load 
$(document).ready(function () {
LoadProjectData();
getProjectUID();
});

//get the project data
function LoadProjectData() {
				var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects()?"
									+ "&$select=Name",
									type: "GET",
									dataType: "json",
									headers: {Accept: "application/json;odata=verbose"	}       
								   });
        data.done(function (data,textStatus, jqXHR){
								results = data.d.results;
								for (var i = 0, len = results.length; i < len; i++) {
									var result = results[i];
									projectData.push(result.Name);
								}
								populateSelectOptions();								
		});
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
        });
};

function populateSelectOptions() {
	var select = document.getElementById("availableProjects");
	for(var i = 0; i < projectData.length; i++) {
    select.options[i] = new Option(projectData[i], i);
	}
}

//list buttons
$("#btnAllRight").click(function () {
    var selectedItem = $("#availableProjects option");
		if (selectedItem.length == 0) {
            alert('No projects to move');
        }
    $("#relatedProjects").append(selectedItem);
});

$("#btnRight").click(function () {
    var selectedItem = $("#availableProjects option:selected");
		if (selectedItem.length == 0) {
            alert('No projects to move');
        }
    $("#relatedProjects").append(selectedItem);
});

$("#btnAllLeft").click(function () {
    var selectedItem = $("#relatedProjects option");
		if (selectedItem.length == 0) {
            alert('No projects to move');
        }
    $("#availableProjects").append(selectedItem);
});

$("#btnLeft").click(function () {
    var selectedItem = $("#relatedProjects option:selected");
		if (selectedItem.length == 0) {
            alert('No projects to move');
        }
    $("#availableProjects").append(selectedItem);
});

//action buttons
$("#btnSave").click(function () {
	var x = document.getElementById("relatedProjects");
	for (var i = 0; i < x.options.length; i++) {
     if(x.options[i]){
			selectedProjectData.push(x.options[i].text); 
      }
  }
 waitDialog =  SP.UI.ModalDialog.showWaitScreenWithNoClose('Updating Project Custom Field', 'Custom field updated and project publish and check in jobs submitted to the queue');
 checkOutProject();
});

$("#btnCanel").click(function () {
    var selectedItem = $("#relatedProjects option");
    $("#availableProjects").append(selectedItem);
});

//get project UID from the URL
function getProjectUID(){
	var urlStr = unescape(window.location)
	if (urlStr.toLowerCase().indexOf('projuid')>=0) {
	projUid = urlStr.substr(urlStr.indexOf("=")+1,36) 
		}
	else {
		$("#messages").html("Not available in this context. Not a Project Server Project Detail Page or project associated");
		$(".projects").hide();
		$(".actionbuttons").hide();
		}
}

//check project out
function checkOutProject() {
	var checkoutUrl = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects('" + projUid + "')/checkOut";
	
	$.ajax({
	  url: checkoutUrl,
	  type: "POST",
	  contentType: "application/json;odata=verbose",
	 headers: {
	 "accept": "application/json;odata=verbose",
	 "X-RequestDigest": $("#__REQUESTDIGEST").val(),
	 "X-HTTP-Method":"POST",
	 "If-Match": "*"
	 },
	 success: function () {
		updateProjectCF();
	 },
	 error: function (err) {
		waitDialog.close();
		alert(JSON.stringify(err));
	  }
	 });
}

//update CF
function updateProjectCF() {	
	var updateUrl = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects('" + projUid + "')/Draft/UpdateCustomFields";
	var valueCF = selectedProjectData.toString();
	var body = {
	"customFieldDictionary":[{"Key":projectCFInternalName, "Value":valueCF,"ValueType":"Edm.String"}]
	};
	
	$.ajax({
	  url: updateUrl,
	  type: "POST",
	  contentType: "application/json;odata=verbose",
	  data: JSON.stringify(body),
	 headers: {
	 "accept": "application/json;odata=verbose",
	 "X-RequestDigest": $("#__REQUESTDIGEST").val(),
	 "X-HTTP-Method":"POST"
	 },
	 success: function () {
		publishcheckInProject();
	 },
	 error: function (err) {
		waitDialog.close();
		alert(JSON.stringify(err));
	  }
	 });
}

//publish and check project in
function publishcheckInProject() {	
	var publishUrl = _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects('" + projUid + "')/draft/publish(true)";
	
	$.ajax({
	  url: publishUrl,
	  type: "POST",
	  contentType: "application/json;odata=verbose",
	 headers: {
	 "accept": "application/json;odata=verbose",
	 "X-RequestDigest": $("#__REQUESTDIGEST").val(),
	 "X-HTTP-Method":"POST",
	 "If-Match": "*"
	 },
	 success: function () {
		waitDialog.close();
	 },
	 error: function (err) {
		waitDialog.close();
		alert(JSON.stringify(err));
	  }
	 });
}
</script>