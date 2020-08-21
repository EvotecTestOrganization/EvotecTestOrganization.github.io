# Add a Network Printer

## Original Links

- [x] Original Technet URL [Add a Network Printer](https://gallery.technet.microsoft.com/85640294-d965-43bc-8ee6-5c1c9daa704d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/85640294-d965-43bc-8ee6-5c1c9daa704d/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Tim Laqua

Installs a network printer at logon. The script determines if the user has this printer installed already; if they do, then the script exits. If the printer is not installed the script installs the printer and, if the user does not have a local default printer  installed, sets the printer as the default printer.

Visual Basic

```
Option Explicit

' Tell WSH to resume on errors, otherwise our error handling can't do it's job
On Error Resume Next

' Dim variables
Dim objNetwork, objWMIService, objPrinter
Dim colInstalledPrinters
Dim strPrinterServer, strPrinterShare, strComputerName
Dim Return, LocalDefault, PrinterIsInstalled

'######## Define Printer Configuration here #########

strPrinterServer = "\\printserver"
strPrinterShare = "PRINTQUEUE"

'######## Code below does not need to be modified unless logical changes are needed ########

PrinterIsInstalled = False' We will only set this to true if we can find this printer in the list
strComputerName = "."	' This Computer

' Get WMIService so we can run WMI queries (good stuff)
Set objWMIService = GetObject( _
    "winmgmts:" & "{impersonationLevel=impersonate}!\\" _
    & strComputerName & "\root\cimv2")

' Run a WMI query to get all the objects belonging to the 
' Win32_Printer Class (all the installed printers)
Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer")

' The WMI query returns a collection (hence, the 'col' prefix), 
' so we have to loop through the objects
For Each objPrinter in colInstalledPrinters
    ' Now we have objects... printer objects to be exact...
    ' Check to see if the current printer object is the default printer
    If objPrinter.Default = "True" Then ' We found the default printer, so lets see if it's a Local printer
' (but NOT that Image Writer doohickey)If objPrinter.ServerName = Null And_
     objPrinter.Name <> "Microsoft Office Document Image Writer" Then	' User has a local Default Printer, so set LocalDefault to True	LocalDefault = TrueElse	' User has a Network Default Printer, so set LocalDefault to False	LocalDefault = FalseEnd If
    End If

' Lets figure out if this printer is installed already by 
' checking each printer object for a match
    If objPrinter.ServerName = strPrinterServer And _
        objPrinter.ShareName = strPrinterShare Then' Printer is already installed, so set PrinterIsInstalled to TruePrinterIsInstalled = True
    End If
Next

' If the Printer is not installed, install it.  If it's already installed, do nothing.
' This also serves to allow users to choose a different default printer, as we only
' update the default printer if this printer has not been installed before AND they
' do not have a local default printer.
If Not PrinterIsInstalled Then' Printer is not installed, so install it
' Create the Network ObjectSet objNetwork = CreateObject("WScript.Network") 
' Create a new connection to the specified Printer PathobjNetwork.AddWindowsPrinterConnection strPrinterServer & "\" & strPrinterShare
' Check to see if an error was loggedIf err.Number <> 0 Then	' An error was logged, display a nice error message indicating the error number	WScript.Echo "Could not map " & strPrinterServer & "\" _
    & strPrinterShare & " [" & err.Number & "]" 	Err.ClearElse	' No errors were logged, so check to see if we should make this printer the default printer	If Not LocalDefault Then		' User does not have a local default printer, so make this the default printer		objNetwork.SetDefaultPrinter strPrinterServer & "\" & strPrinterShare	End IfEnd If
Else' Printer is already installed, so do nothing
End If

' Good practice to clear the main objects, ESPECIALLY WMI provider objects
Set objWMIService = Nothing
Set objNetwork = Nothing

WScript.Quit
```

