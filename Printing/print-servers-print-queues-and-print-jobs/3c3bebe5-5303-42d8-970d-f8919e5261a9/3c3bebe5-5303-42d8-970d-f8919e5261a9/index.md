# Modify Printer Locations

## Original Links

- [x] Original Technet URL [Modify Printer Locations](https://gallery.technet.microsoft.com/3c3bebe5-5303-42d8-970d-f8919e5261a9)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/3c3bebe5-5303-42d8-970d-f8919e5261a9/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses ADSI to configure the location attribute for all the printers in a specified OU.

Visual Basic

```
Set objOU = GetObject("LDAP://OU = Finance, DC = fabrikam, DC = com")
objOU.Filter = Array("printqueue")

For Each objPrintQueue In objOU
    objPrintQueue.Put "Location" , "USA/Redmond/Finance Building"
    objPrintQueue.SetInfo
Next
```

