# Custom and Native field bulk update, Project Onlin

## Original Links

- [x] Original Technet URL [Custom and Native field bulk update, Project Onlin](https://gallery.technet.microsoft.com/Custom-and-Native-field-29cb2e42)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Custom-and-Native-field-29cb2e42/description)
- [x] Download: [Download Link](Download\ProjectOnlineBulkUpdate.zip)

## Output from Technet Gallery

This pair of scripts can be used to query your instance of project web app and return your native and custom fields (along with some system information that supports them) and then uses that information in combination with a CSV of the updates you want to  make in order to run a bulk update.

This is based on the great start that from [PWMather](https://social.technet.microsoft.com/profile/pwmather/ "Paul Mather, TechNet") to [Update Project Online Project Custom Field Value Using PowerShell](https://gallery.technet.microsoft.com/Update-Online-Custom-Field-12f034f4) and [Quadri Yusuff](https://social.technet.microsoft.com/profile/quadri%20yusuff/ "Quadri Yusuff, TechNet") to [Update Project Server- Project Custom Field and Lookup Value Using PowerShell](https://gallery.technet.microsoft.com/Update-Server-Custom-Field-00ab99a9 "Update Project Server- Project Custom Field and Lookup Value Using PowerShell"), along with [Hammad Arif](https://social.technet.microsoft.com/profile/hammad%20arif/ "Hammad Arif, TechNet") who's [best documented how to find the required DLLs](https://gallery.technet.microsoft.com/Publish-All-Projects-in-ad8ee80e). What was missing from those and is included here is the automatic lookup / translation of the custom field values to the internal names and object types needed to pass through to the api, and also the removal  of many hard-coded values related to the fields you're trying to update.

# Instructions

1. You'll need to download the required CSOM DLLs as referenced at the top of each script:Locate them at:  nuget https://www.nuget.org/packages/Microsoft.SharePointOnline.CSOM

2. Create a CSV including the attributes you want to update, along with the project name. The project name is what's used to lookup the project. A good starting point would be to have a view of the project center with the names of the fields you want to update, then export that view to excel. Make your changes, then save it as a CSV. If you don't want to update a certain field, just remove it from the CSV.

3. Open both scripts and change the values of the paths for where the script can find the DLLs, your CSV, and the URL to your PWA instance and the name of your account with the access.

4. Run the "Get Lookup Tables and Entries" script, which will write to the screen and keep in memory $allFields which is used by the second script, BulkUpdate.

5. Run the "Bulk Update" Script.

# Notes

- For native fields, I only allowed the Description and ProjectIdentifier fields to be updated - there might be a few other that behave nicely, but I havne't tried them out. If you know you can update them, just add them to the list of $allowedNativeFields on line 17.

- For custom fields, I haven't tested the inclusion of custom fields that have more than one value (though a tree structure does work)

# Known issues

1. I haven't put in checks for required fields... if you're trying to run a bulk update against a project with a required field that's null and you haven't included that attribute/value in your CSV, that project will fail to check-in and publish.

2. There's something with timing that I haven't quite worked out - if you get a series of errors unrelated to a missing required field, it's likely something in the script processed too quickly. Just run the bulk update script a second time. That's always worked for me.

Code Snippet

```
# Get the Custom Fields
$url = $PWAURL +"/_api/ProjectServer/CustomFields"
    [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $securePass);
    $webrequest = [System.Net.WebRequest]::Create($url)
    $webrequest.Credentials = $spocreds
    $webrequest.Accept = "application/json;odata=verbose"
    $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
    $response = $webrequest.GetResponse()
    $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
    $data = $reader.ReadToEnd()
    $results = ConvertFrom-Json -InputObject $data
    $CustomFields = $results.d.results
        $CustomFields | %{
        $CustomField = New-Object -TypeName System.Object
        $CustomField | Add-Member -Type NoteProperty -Name Name -Value $_.Name
        $CustomField | Add-Member -Type NoteProperty -Name FieldType -Value "Custom"
        $CustomField | Add-Member -Type NoteProperty -Name InternalName -Value $_.InternalName
        # Find lookup table
        $url = $_.LookupTable.__deferred.uri
```

