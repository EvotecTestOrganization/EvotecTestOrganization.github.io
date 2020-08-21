# Powershell GUI - Enhanced Printer Infrastructure Creator (or E.P.I.C)

## Original Links

- [x] Original Technet URL [Powershell GUI - Enhanced Printer Infrastructure Creator (or E.P.I.C)](https://gallery.technet.microsoft.com/Powershell-GUI-Enhanced-b4e3fede)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Powershell-GUI-Enhanced-b4e3fede/description)
- [x] Download: [Download Link](Download\epic.zip)

## Output from Technet Gallery

Hi all,

i have been working on a printer creator tool for some time. its not perfect and im not a PS expert (so be kind and understanding) but it works great and saves me tons of clicks and mistakes. the tool is meant to run on the print server.

as always - TEST before deploying to PROD.

so here it is. use at your own risk. feel free to modify the code or send comments.

E.P.I.C

 requirements: PS 5

 tested OS: Print Server 2012 R2

contents of zip file:

 epic.exe - a compiled version of the code

 epic\_conf.ini - modify this file to fit your own needs

 epic\_v1.3.export.ps1 - the full script

 epic\_v1.3.psf - Sapien PowerShell Studio project file.

 folder "Additions" with subinacl.exe (needed for fixing printer permissions)

the app does the following:

Finds an available IP for the printer. example: 172.16.15.101

creates AD group (for users printing permissions). example: CMP1-16-15-101

Add selected users to the group

Creates a Port. example: CMP1-16-15-101

Creates a printer and share it. example: CMP1-16-15-101

printer is created shared with SSR and published in AD.

option to duplicate printer to FAX. example: CMP1-16-15-101-FAX

Assign/fix permissions (this requires subinacl.exe which can be installed on the print server using windows resource kit)

known issues:

 a bit slow, had to add some sleep for the ports and groups to be created and available.

 manual IP is not test

 mac reservation is not implemeted yet

 sometimes security on printer will fail for FAX.

 if creation fails try running as admin (i use without and it works)

![](Images\capture.png)

![](Images\capture2.png)

![](Images\capture3.png)

![](Images\capture4.png)

best regards,

Sean Noy.

