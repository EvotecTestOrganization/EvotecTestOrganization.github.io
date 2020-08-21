# Update Printer Locations

## Original Links

- [x] Original Technet URL [Update Printer Locations](https://gallery.technet.microsoft.com/08aff197-e501-48a7-a2b4-0bca1bfef353)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/08aff197-e501-48a7-a2b4-0bca1bfef353/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses ADSI to update the location attribute for all printers in a specified OU.

Visual Basic

```
Set objOU = GetObject("LDAP://OU=Finance, DC=fabrikam, DC=com")
objOU.Filter = Array("printqueue")

For Each objPrintQueue In objOU
    strNewLocation = "Redmond/" & objPrintQueue.Location
    objPrintQueue.Put "Location" , strNewLocation
    objPrintQueue.SetInfo
Next
```

