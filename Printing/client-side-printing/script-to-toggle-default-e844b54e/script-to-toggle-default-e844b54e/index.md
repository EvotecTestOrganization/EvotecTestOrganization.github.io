# Script to Toggle Default XPS Document Writer (MXDW) Format (OXPS <-> XPS)

## Original Links

- [x] Original Technet URL [Script to Toggle Default XPS Document Writer (MXDW) Format (OXPS <-> XPS)](https://gallery.technet.microsoft.com/Script-to-Toggle-Default-e844b54e)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Script-to-Toggle-Default-e844b54e/description)
- [x] Download: [Download Link](Download\ToggleMXDWFormat.ps1)

## Output from Technet Gallery

Windows 8 introduces the OpenXPS (.oxps) international standard format as the default format for XPS output from the Microsoft XPS Document Writer (MXDW).  Metro style apps will automatically save documents to the My Documents folder with a default  name in this format.  Desktop apps will be able to use the File Type option in the file save dialog to change between OpenXPS and the legacy Microsoft XPS (.xps) format.

However, there are certain scenarios where Windows 8 users require Microsoft XPS (.xps) to be the default format.  The "ToggleMXDWFormat.ps1" script will toggle the default format between OpenXPS and MicrosoftXPS.  If a system has OpenXPS as the  default, running the script will cause Microsoft XPS to be the new default, so all Metro style apps printing to MXDW will output .xps files and .xps will be the default option in the desktop.  Running the script again will return the system to OpenXPS  as the default.

To run the script:

- Open Powershell as an administrator

- Execute the following command to allow all scripts to run in the current Powershell instance:  Set-ExecutionPolicy

–ExecutionPolicy Unrestricted –Scope Process

- Execute the script:  [full path]\ToggleMXDWFormat.ps1

- Exit Powershell

This script will work on all versions of Windows 8 and Windows 8 RT.

