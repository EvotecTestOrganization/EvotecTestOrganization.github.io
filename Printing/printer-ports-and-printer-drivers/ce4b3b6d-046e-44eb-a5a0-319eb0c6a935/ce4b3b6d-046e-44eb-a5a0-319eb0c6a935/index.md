# Install a Network Printer

## Original Links

- [x] Original Technet URL [Install a Network Printer](https://gallery.technet.microsoft.com/ce4b3b6d-046e-44eb-a5a0-319eb0c6a935)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ce4b3b6d-046e-44eb-a5a0-319eb0c6a935/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **NeoCatalyst

Installs a network printer. Use the /y parameter (rather than /n) to set the new printer as the default printer.

Visual Basic

```
rundll32 printui.dll,PrintUIEntry /ga /n\\servername\printersharename
net stop spooler
net start spooler
```

