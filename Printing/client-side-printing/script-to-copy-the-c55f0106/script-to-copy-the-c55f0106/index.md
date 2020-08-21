# Script to copy the contents of the ISE or a file to the printer

## Original Links

- [x] Original Technet URL [Script to copy the contents of the ISE or a file to the printer](https://gallery.technet.microsoft.com/Script-to-copy-the-c55f0106)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Script-to-copy-the-c55f0106/description)
- [x] Download: [Download Link](Download\Copy-ToPrinter.ps1)

## Output from Technet Gallery

This script will create an html version of the current script (or current selection) in the ISE or the specified file using an Internet Explorer com object.

The html object includes line numbers.

Once the html is built, and the IE window is opened, you can print using IE's print functions.

This script is extracted from a module I use to provide basic functions in the ISE that I miss from PowerGUI, or which I had added as script editor add-ons to PowerGui.

This is based on Lee Holmes Set-ClipboardScript located here: http://www.leeholmes.com/blog/2009/02/03/more-powershell-syntax-highlighting/

For more information see http://unlockpowershell.wordpress.com/2011/12/30/print-from-powershells-integrated-scripting-environment/

**This is modified as of January 30, 2013 to work with Windows Server 2012. Essentially, we need to force the browser into compatability mode.**

Updated again, as I noticed a problem where sometimes the print preview does not open as the page has not fully rendered. Added line 231:

Start-Sleep -Seconds 1

This may need to be modified in your environment.

Modified May 8th, 2013 - test for CompatibilityMode value in registry, and if not present, do not attemt to set it,

**This is modified as of February 02, 2017 to work with Windows 10. We need to force the browser to be visible on Eindows 10.**

