# Rename a Printer Published in Active Directory

## Original Links

- [x] Original Technet URL [Rename a Printer Published in Active Directory](https://gallery.technet.microsoft.com/1f20ea0c-89aa-4f5c-8309-023bf65b85f7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/1f20ea0c-89aa-4f5c-8309-023bf65b85f7/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses the MoveHere method to rename a published printer in an OU.

Visual Basic

```
Set objOU = GetObject("LDAP://ou=HR,dc=NA,dc=fabrikam,dc=com")

objOU.MoveHere _
    "LDAP://cn=Printer1,ou=HR,dc=NA,dc=fabrikam,dc=com", "cn=HRPrn1"
```

