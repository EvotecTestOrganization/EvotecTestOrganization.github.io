# Remove printers added By group policy

## Original Links

- [x] Original Technet URL [Remove printers added By group policy](https://gallery.technet.microsoft.com/Remove-printers-added-By-9dc5f551)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Remove-printers-added-By-9dc5f551/description)
- [x] Download: [Download Link](Download\GP Printer Removal Fix.reg)

## Output from Technet Gallery

I have often had issues where printers that have been deployed through GP cannot be removed even after the policy is no longer applied. The printers must be removed through the registry.

Here is a registry edit to remove fix the issue it will remove all printers.As always edit the registry with caution and backup the keys you edit to avoid problems

It edits the following Key

Bash/shell

```
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers]
"DefaultSpoolDirectory"="C:\\Windows\\system32\\spool\\PRINTERS"
"LANGIDOfLastDefaultDevmode"=dword:00000409
```

