# Update Project Server- Project Custom Field and Lookup Value Using PowerShell

## Original Links

- [x] Original Technet URL [Update Project Server- Project Custom Field and Lookup Value Using PowerShell](https://gallery.technet.microsoft.com/Update-Server-Custom-Field-00ab99a9)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Update-Server-Custom-Field-00ab99a9/description)
- [x] Download: [Download Link](Download\UpdateProjectLookupfromCSV.ps1)

## Output from Technet Gallery

Based on the script provided by [PWMather](https://social.technet.microsoft.com/profile/pwmather/activity), on [Update Project Online Project Custom Field Value Using PowerShell](https://gallery.technet.microsoft.com/Update-Online-Custom-Field-12f034f4) with CSV

The Approach he provided only addresses a single field with a single line of text data type.

This is fine, as it does what is required, but i wanted to be able to update Lookup fields as well as bulk updating Multiple filed at the same time.

Note1: Dont forget to locate the internal name for the custom field at http://domain/pwa/\_api/ProjectServer/CustomFields

Note2: Be mindful of Null values in your CSV

A code snippet can be seen below (full code in the download):

```
try {
        $projectName = $_.ProjectName
        [Array]$MyArray1 = $_.Dept
        [Array]$MyArray3 = $_.multiselect1,$_.multiselect2,$_.multiselect3
        $project = $projContext.Projects | select Id, Name | where {$_.Name -eq $projectName}
        if($project -ne $null){
            $proj = $projContext.Projects.GetByGuid($project.Id)
            $draftProject = $proj.CheckOut()
            $draftProject.SetCustomFieldValue($Dept,$MyArray1)
            $draftProject.SetCustomFieldValue($Cost,$_.Cost)
            $draftProject.SetCustomFieldValue($multiselect,$MyArray3)
            $draftProject.SetCustomFieldValue($State,$_.State)
            $draftProject.Publish($true) | Out-Null
            $projContext.ExecuteQuery()
            Write-host -ForegroundColor Green "'$projectName' has been updated"
            }
        else {
            Write-host -ForegroundColor Yellow "'$projectName' not found with $_.Dept , $_.State , $_.ProjectStatus , $_.multiselect1 , $_.multiselect2 , $_.multiselect3 "
            }
        }
    catch{
        write-host -ForegroundColor Red "Add error occurred whilst attempting to update project: '$projectName'. The error details are: $($_)"
        }
```

This example works for both Project Online/On Premise 2013/2016

