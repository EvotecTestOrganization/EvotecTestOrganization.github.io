# Delete reappearing printers that keeps comming back

## Original Links

- [x] Original Technet URL [Delete reappearing printers that keeps comming back](https://gallery.technet.microsoft.com/Delete-reappearing-91bfec8b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Delete-reappearing-91bfec8b/description)
- [x] Download: [Download Link](Download\DeletePrintersRDS.cmd)

## Output from Technet Gallery

Script to delete ghost printers that keeps coming back after deletion.

![](Images\printers.png)

You can read more about this problem [here](https://serverfault.com/questions/604161/deleted-printers-keeps-coming-back-and-multiply).

You need to add psexec to system path. Download [PsTools](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec) and extract it to C:\Windows\System32.

**Please, take a registry backup first! **

This script removes the following registry keys:

Windows Shell Script

```
HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\PRINTENUM\*
HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{0ecef634-6ef0-472a-8085-5ad023ecbccd}\*
HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider\*
HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\*
HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\V4 Connections\*
```

 I had not any problem running script in several servers, but be carefully using it:

`"Using Registry Editor incorrectly can cause serious, system-wide problems that may require you to re-install Windows to correct them. Microsoft cannot guarantee that any problems resulting from the use of Registry Editor

 can be solved. Use this tool at your own risk."`

Reboot server immediately after running it.

