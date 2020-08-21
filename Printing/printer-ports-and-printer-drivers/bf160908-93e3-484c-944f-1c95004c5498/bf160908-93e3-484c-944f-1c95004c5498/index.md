# Map Printers Based on Group Membership

## Original Links

- [x] Original Technet URL [Map Printers Based on Group Membership](https://gallery.technet.microsoft.com/bf160908-93e3-484c-944f-1c95004c5498)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/bf160908-93e3-484c-944f-1c95004c5498/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Robert Gransbury

Logon script that maps printers based on Active Directory group membership.

Visual Basic

```
on error resume next
Dim objADSystemInfo, objUser, objMemberOf, objGroup, objGroupEnum, objNetwork, objPrinter dim i, bTroubleFlag

Set objNetwork = CreateObject("Wscript.Network")

'Get current user info from active directory Set objADSystemInfo = CreateObject("ADSystemInfo") 'bind to current user in active directory set objUser = GetObject("LDAP://" & objADSystemInfo.UserName)

if objuser.description = "printer.trouble" thenbTroubleFlag = truemsgbox "Troubleshooting Printer Logon Script"
end if

Set objPrinter = objNetwork.EnumPrinterConnections 'Test to see if we have any printers mapped If objPrinter.Count > 0 Then'The Printer array is Printer name, printer path that is why it is step 2for i=1 to objPrinter.Count Step 2	'test to make sure it is a network printer	if instr(objPrinter.Item(i),"\\") <> 0 then		if bTroubleFlag then			msgbox "Deleting:" & vbcrlf &
objPrinter.Item(i)		end if		objNetwork.RemovePrinterConnection
objPrinter.Item(i),true,true	end ifnext
end if


'Get an array of group names that the user is a member of objMemberOf = objUser.MemberOf for Each objGroup in objMemberOf'Test to see if it is a printer group. all printer groups should be in the same OUif (instr(objGroup,"OU=Printer-Groups") <> 0) then	'Bind to the group to get is description. The description contain the path to the printer	set objGroupEnum = GetObject("LDAP://" & objGroup)	if bTroubleFlag then		msgbox "Adding:" & vbcrlf & "[" &
objGroupEnum.name & "]" & vbcrlf & objGroupEnum.description	end if	objNetwork.AddWindowsPrinterConnection
objGroupEnum.description	set objGroupEnum = nothingend if
next
'Repeat as above for the default printer for Each objGroup in objMemberOfif (instr(objGroup,"OU=Printer-Default-Groups") <> 0) then	set objGroupEnum = GetObject("LDAP://" & objGroup)	if bTroubleFlag then		msgbox "Setting Default:" & vbcrlf & "[" & objGroupEnum.name & "]" & vbcrlf & objGroupEnum.description	end if	objNetwork.SetDefaultPrinter objGroupEnum.description	set objGroupEnum = nothingend if
next

if bTroubleFlag thenmsgbox "Printer Logon Script Finished"
end if
```

