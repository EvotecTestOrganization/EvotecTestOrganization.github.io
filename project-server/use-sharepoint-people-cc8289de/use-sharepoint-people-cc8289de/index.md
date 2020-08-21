# Use SharePoint people pickers on Project Server or Online PDPs

## Original Links

- [x] Original Technet URL [Use SharePoint people pickers on Project Server or Online PDPs](https://gallery.technet.microsoft.com/Use-SharePoint-people-cc8289de)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Use-SharePoint-people-cc8289de/description)
- [x] Download: [Download Link](Download\PdpPeoplePicker.js)

## Output from Technet Gallery

# **PDP People Picking**

Project Server PDPs (Project Detail Pages) have the facility to host Project level enterprise custom fields for users to edit.  Out-of-the-box Project Server supports Cost, Date, Duration, Flag, Number and Text - but not fields of type Person.

With the supplied Javascript, you can transform any 'Single Line Of Text' field into a SharePoint people picker.

![](Images\peoplepickingonpdp.png)

Simply take the supplied javascript and put it into a Content Editor webpart on the PDP and customise the first line to contain the Display Name of the single line of text field you have placed elsewhere on the page.

For example, if the the custom field on the PDP is called "Project Sponsor" then configure the first line of the javascript as:

JavaScript

```
//Set the following to be an array of fields you would like to change into a people-picker
var targetFields = ['Project Sponsor'];
```

If you have more than one field on the PDP that you want to transform, you can specify each one like this:

####

JavaScript

```
//Set the following to be an array of fields you would like to change into a people-picker
var targetFields = ['Field 1', 'Field 2'];
```

## Known Limitations

This code saves the picked person back into the custom field as text, so say you have two "Bob Smith" users with the same display name, this code would be unable to resolve the difference between them.

## Detailed Install Instructions

First make sure your PDP has a single line of text field in the Project Details Webpart ready to go.

![](Images\pdppp-1.png)

On the Page Tab, Select Edit Page

![](Images\pdppp-2.png)

Add a Content Editor, or Script Editor Webpart

![](Images\pdppp-3.png)

Click into the content area of the webpart, and click the Edit Source button

![](Images\pdppp-4.png)

Type in some empty script tags

![](Images\pdppp-5.png)

Paste the Javascript provided in the download into the middle of the script tags, and customise the first line.

![](Images\pdppp-6.png)

Press okay, and stop editing the page

![](Images\pdppp-7.png)

**\*IMPORTANT\*** If you are using Google Chrome you will need to refresh the page as Chrome has a security feature that prevents any script executing that was part of the previous POST.

And then the People picker will be ready for use:

![](Images\pdppp-8.png)

Happy People Picking :)

James.

