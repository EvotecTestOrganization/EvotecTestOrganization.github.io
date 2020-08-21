# Copy-ACLToPrinter

## Original Links

- [x] Original Technet URL [Copy-ACLToPrinter](https://gallery.technet.microsoft.com/Copy-ACLToPrinter-2d66ce19)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Copy-ACLToPrinter-2d66ce19/description)
- [x] Download: [Download Link](Download\Copy-ACLToPrinter.ps1)

## Output from Technet Gallery

Replace the permissions (ACL) from one printer to another.

I'm using WMI Object  win32\_printer and Win32\_SecurityDescriptor .. not a great deal of error trapping I'm afraid.

I've used this script to set permissions after a PaperCut installation highlighted the need to adjust permissions across 400 printers!

Run the powershell environment at administrator as I couldn't figure how to get the permissions when a normal user :o(

When permissions are set to should get this output ....

\_\_GENUS          : 2

 \_\_CLASS          : \_\_PARAMETERS

 \_\_SUPERCLASS     :

 \_\_DYNASTY        : \_\_PARAMETERS

 \_\_RELPATH        :

 \_\_PROPERTY\_COUNT : 1

 \_\_DERIVATION     : {}

 \_\_SERVER         :

 \_\_NAMESPACE      :

 \_\_PATH           :

 ReturnValue      : 0

