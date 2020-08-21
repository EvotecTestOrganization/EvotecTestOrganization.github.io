# Manage Network Printers

## Original Links

- [x] Original Technet URL [Manage Network Printers](https://gallery.technet.microsoft.com/ea85a33b-6690-4910-b83d-6b993e57ba54)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ea85a33b-6690-4910-b83d-6b993e57ba54/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Frank Methorst

Manages a user's network printers.

Visual Basic

```
'==========================================================================
'
' VBScript Source File -- Created with SAPIEN Technologies PrimalScript 4.0
'
' NAME: ManagePrinters.vbs 1.0
'
' CREATED       : 10/17/2006
' CREATED BY    : Frank Methorst
' MODIFIED      :
' MODIFIED BY   :
'
'
' COMMENT: This script demonstrates printer management. The code would
' likely be part of a logon script. Local printers are not affected by 
' this script
'
'
'==========================================================================
'
' Variable Prefix Standards:
'
' Single letter lower case prefixes should be used
' to identify the type of variable
'
' s = String        (i.e. sComputer, sUser, sDomain etc.)
' o = Object        (i.e. oFSO, oShell, oNetwork, oWMI etc.)
' a = Array         (i.e. aHotfixes, aBranches, etc.)
' c = Collection    (i.e. cComputers, cUsers, cOUs etc.)
' i = Integer       (i.e. i, iNumber, etc.)
' d = Date/Time     (i.e. dDate, dStartTime, dToday etc.)
' b = Boolean       (i.e. bAnswer, bOutput etc.)
' e = Error         (i.e. eNumber, eDescription etc.)
' vb = builtin      (i.e. vbCRLF, vbTAB, vbLongDate etc.)
'
'
' Constant Standards:
' 
' Constants should be identified by using upper case letters
' exclusively separated by underscores:
'
' i.e. OVERWRITE_EXISTING, FILE_SHARE, MAXIMUM_CONNECTIONS etc.
'
'
'==========================================================================

'=================== Script Initialization ================================

Option Explicit
On Error Resume Next

'=================== Constant / Variable Declaration ======================

Dim oAssignedPrinters
Dim sComputer
Dim sDefaultPrinter
Dim oInstalledPrinters
Dim oNetwork
Dim oPrinter

'=================== Object Creation ======================================

Set oAssignedPrinters = CreateObject("Scripting.Dictionary")
Set oNetwork = WScript.CreateObject("Wscript.Network")
Set oInstalledPrinters = CreateObject("Scripting.Dictionary")

'=================== Main Logic ===========================================

' Determine the computer name

sComputer = oNetwork.ComputerName

' Determine which printers the user has installed. Add user's installed printers 
' to oInstalledPrinters dictionary object to allow comparison with oAssignedPrinters 
' dictionary object. Printers that are present in oAssignedPrinters but not 
' oInstalledPrinters will be installed. Printers that are present in oInstalledPrinters
' but not oAssignedPrinters will be removed. Determine the user's default printer.

' IMPORTANT: printer name and printer share name MUST be the same since this script 
' compares the two. If they are not printers will be removed and reinstalled
' each time the script runs
For Each oPrinter In GetPrinters(sComputer)oInstalledPrinters.Add oPrinter.Name, Null If oPrinter.Default = True Then	sDefaultPrinter = oPrinter.NameEnd If 
Next 

' Add Printers to the oAssignedPrinters dictionary object. Printer assignment
' can be based on any criteria you require. Through the use of If and Select
' statements you can selectively target printer assignment. 

' The following are some examples:
' Portion of a computer name
' User group membership
' Existence of a specific application
' IP Address

oAssignedPrinters.Add "\\Printer\Infrastructure4", Null
oAssignedPrinters.Add "\\printer\Inventure5", Null
oAssignedPrinters.Add "\\printer\xerox65-4f", Null
oAssignedPrinters.Add "\\Printer\Infrastructure7", Null 

' Delete any printer that is not currently assigned to the PC. 

For Each oPrinter In oInstalledPrintersIf Not oAssignedPrinters.Exists(oPrinter) Then	oNetwork.RemovePrinterConnection oPrinterEnd If 
Next	

' Add all printers assigned to the PC. 

For Each oPrinter In oAssignedPrintersIf Not oInstalledPrinters.Exists(oPrinter) Then	oNetwork.AddWindowsPrinterConnection oPrinterEnd If 
Next	

'=================== Cleanup ==============================================

Set oAssignedPrinters = Nothing 
Set oInstalledPrinters = Nothing 
Set oNetwork = Nothing 
Set oPrinter = Nothing 

'=================== Functions / Subroutines ==============================

Function GetPrinters(sComputer) ' #regionOn Error Resume NextDim oWMISet oWMI = GetObject("winmgmts:\\" & sComputer)Set GetPrinters = oWMI.ExecQuery ("Select * from Win32_Printer")Set oWMI = Nothing
End Function ' #endregion
```

