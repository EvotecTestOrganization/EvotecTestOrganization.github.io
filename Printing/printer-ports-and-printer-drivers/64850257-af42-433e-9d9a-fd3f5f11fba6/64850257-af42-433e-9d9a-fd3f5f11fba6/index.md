# Assign Printers Based on Group Membership

## Original Links

- [x] Original Technet URL [Assign Printers Based on Group Membership](https://gallery.technet.microsoft.com/64850257-af42-433e-9d9a-fd3f5f11fba6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/64850257-af42-433e-9d9a-fd3f5f11fba6/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Jeffrey M. Oyler

Assigns printer resources based on group membership.

Visual Basic

```
'Written by Jeffrey M. Oyler, Systems Engineer
Option ExplicitOn Error Resume Next
Dim objShell		: Set objShell = WScript.CreateObject("WScript.Shell")Dim objNetwork		: Set objNetwork = WScript.CreateObject("WScript.Network")Dim objGroupListDim enumPrinters	: Set enumPrinters = objNetwork.EnumPrinterConnectionsDim strWorkDir		: strWorkDir = ObjShell.ExpandEnvironmentStrings("%temp%")Dim strUser		: strUser = objNetwork.UserNameDim strDomain		: strDomain = objNetwork.UserDomainDim strGroupDim objUser		: Set objUser = GetObject("WinNT://" & strDomain & "/" & strUser & ",user")Dim intCounterDim localPrinter	: Set localPrinter = False

'Set script working directory to user %temp%
objShell.CurrentDirectory = strWorkDir

'Remove all current network printers
For intCounter = 1 to enumPrinters.Count -1 step 2	objNetwork.RemovePrinterConnection enumPrinters.Item(intCounter), true	Next

'Map standard printers for all users
objNetwork.AddWindowsPrinterConnection "\\SERVERNAME\Printer 01$"objNetwork.AddWindowsPrinterConnection "\\SERVERNAME\Printer 02$"objNetwork.AddWindowsPrinterConnection "\\SERVERNAME\Printer 03$"

'Set standard default printer
objNetwork.SetDefaultPrinter "\\SERVERNAME\Printer 01$"

'If local printer existson LPT or USB, set to default
For intCounter = 0 to enumPrinters.Count -1 step 2if Left(enumPrinters(intCounter),3)="LPT" OR Left(enumPrinters(intCounter),3)="USB" OR Left(enumPrinters(intCounter),3)="DOT" Thenif Left(enumPrinters(intCounter+1),7)="Acrobat" ThenElseobjNetwork.SetDefaultPrinter enumPrinters(intCounter+1)localPrinter = Trueend ifend ifNext

'Map additional printers and change default printer if no local printer based on group membership
strGroup = "Group 01"if IsMember(strGroup) ThenobjNetwork.AddWindowsPrinterConnection "\\SERVER\Printer 04$"if localPrinter = false ThenobjNetwork.SetDefaultPrinter "\\SERVER\Printer 04$"end ifend if
strGroup = "Group 02"if IsMember(strGroup) Thenif localPrinter = false ThenobjNetwork.SetDefaultPrinter "\\SERVERNAME\Printer 02$"end ifend if
'For use with Windows 2003 built in fax server (Client must have XP fax client installed)strGroup = "Fax Group"if IsMember(strGroup) ThenobjNetwork.AddWindowsPrinterConnection "\\FAXSERVER\Fax Printer$"end if

'Cleanup
Set objGroupList = NothingSet objUser = Nothing

'Function to test group membership
Function IsMember(strGroup)
If IsEmpty(objGroupList) ThenCall LoadGroupsEnd If
IsMember = objGroupList.Exists(strGroup)
End Function

'Subroutine to load user's groups into dictionary object
Sub LoadGroups
Dim objGroup
Set objGroupList = CreateObject("Scripting.Dictionary")objGroupList.CompareMode = vbTextCompareFor Each objGroup In objUser.GroupsobjGroupList(objGroup.name) = TrueNext
Set objGroup = Nothing
End Sub
```

