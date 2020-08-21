# Project Online - Add Related Projects To A Custom Field

## Original Links

- [x] Original Technet URL [Project Online - Add Related Projects To A Custom Field](https://gallery.technet.microsoft.com/Online-Add-Related-e6a69a02)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Online-Add-Related-e6a69a02/description)
- [x] Download: [Download Link](Download\PWARelatedProject.js)

## Output from Technet Gallery

This simple JavaScript solution starter enables you to select projects that are related and add those project names to a project level custom field all from a Project Detail Page. The script will need updating to reference the correct project level field  internal name, but this is covered in the supporting blog post.

A code snippet can be seen below - full code available in the download:

JavaScript

```
//get the project datafunction LoadProjectData() {var data = $.ajax({url: _spPageContextInfo.siteAbsoluteUrl + "/_api/ProjectServer/Projects()?"
                                    + "&$select=Name",
                                    type: "GET",
                                    dataType: "json",
                                    headers: {Accept: "application/json;odata=verbose"}});
        data.done(function (data,textStatus, jqXHR){
                                results = data.d.results;
                                for (var i = 0, len = results.length; i < len; i++) {var result = results[i];
                                    projectData.push(result.Name);
                                }
                                populateSelectOptions();
        });
        data.fail(function (jqXHR,textStatus,errorThrown){
            alert("Error retrieving project data: " + jqXHR.responseText + "\n\n Project data will not load");
        });
};
function populateSelectOptions() {var select = document.getElementById("availableProjects");
```

Here is a link to the supporting blog post that details the requirements to use this solution starter script:

https://pwmather.wordpress.com/2018/05/24/projectonline-add-related-projects-to-a-custom-field-javascript-jquery-ppm-office365-pmot-msproject/

The script is provided "As is" with no warranties etc.

