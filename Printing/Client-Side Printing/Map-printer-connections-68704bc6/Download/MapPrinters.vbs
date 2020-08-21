Option Explicit
On Error Resume Next
Dim bOnlyRunOnWorkstations : bOnlyRunOnWorkstations = True
Dim bInteractive : bInteractive = False
Dim bRemoveCurrentNetworkPrinters : bRemoveCurrentNetworkPrinters = True
Dim oShell : Set oShell = Wscript.CreateObject("Wscript.Shell")
Dim iEventID : iEventID = 0
Dim sEventDescription : sEventDescription = "Logon Script: " & Wscript.ScriptFullName & vbcrlf & "Start: " & Date & " " & Time & vbcrlf & "--" & vbcrlf

If bOnlyRunOnWorkstations Then
	Dim sProductType : sProductType = oShell.RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ProductOptions\ProductType")
	If sProductType <> "WinNT" Then
		sEventDescription = sEventDescription & "This script does not run on servers. " &_
			"ProductType detected as: " & sProductType & vbcrlf &_
			"See the following for more info: http://support.microsoft.com/kb/q152078/" & vbcrlf &_
			"--" & vbcrlf & "Logon Script: " & Wscript.ScriptFullName & vbcrlf & "End: " & Date & " " & Time & vbcrlf
		oShell.LogEvent iEventID, sEventDescription
		Wscript.quit
	End If
End If

Dim oADS : Set oADS = CreateObject("ADSystemInfo")
Dim sSiteName : sSiteName = oADS.SiteName
If Err Then sSiteName = "Unable to retrieve Site Name from AD." : Err.Clear
'Define the following variable if you want to "force" yourself into a particular site for troubleshooting or testing.
'sSiteName = "Edinburgh"

Dim oUser : Set oUser = GetObject("LDAP://" & Replace(oADS.Username, "/", "\/"))
Dim sSamAccountName : sSamAccountName = oUser.Get("samAccountName")
If Err Then sSamAccountName  = "Unable to retrieve samAccountName from AD." : iEventID = 2 : Err.Clear
Dim sDepartment : sDepartment = oUser.Get("department")
If Err Then sDepartment = "Unable to retrieve Department from AD." : iEventID = 2 : Err.Clear
'Define the following variable if you want to "force" yourself into a particular department for troubleshooting or testing.
'sDepartment = ""

sEventDescription = sEventDescription & "SiteName: " & sSiteName & vbcrlf & "samAccountName: " & sSamAccountName & vbcrlf & "Department: " & sDepartment & vbcrlf & "--" & vbcrlf
Const HKCU = &H80000001
Dim oNetwork : Set oNetwork = Wscript.CreateObject("WScript.Network")
Dim oReg : Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
oReg.SetDWordValue HKCU,"Printers\Defaults","Disabled",1
If bRemoveCurrentNetworkPrinters Then
	Dim oWMI : Set oWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Dim cPrinters : Set cPrinters =  oWMI.ExecQuery ("Select Default, ServerName, Name from Win32_Printer WHERE Network = True")
	Dim oPrinter
	For Each oPrinter in cPrinters
		sEventDescription = sEventDescription & Time & " | Removing printer: " & oPrinter.Name & vbcrlf
		oPrinter.Delete_
	Next
End If

Dim dMappedPrinters : Set dMappedPrinters = CreateObject("Scripting.Dictionary")
Dim dDefaultGateways : Set dDefaultGateways = CreateObject("Scripting.Dictionary")
'Usage:   MapPrinterConnection "UNC Path to printer", Default Printer: True\False, "Reason it's being mapped site\department"
'Example: MapPrinterConnection "\\printserver01.domain.com\printersharename", False, "site (" & sSiteName & ")"
Select Case sSiteName
	Case "Birmingham" MapPrinterConnection "\\birm-ps01.domain.tld\birmprnt01", True, "site (" & sSiteName & ")"
	Case "Brussels"
		MapPrinterConnection "\\brus-ps01.domain.tld\brusprnt01", True, "site (" & sSiteName & ")"
		MapPrinterConnection "\\brus-ps01.domain.tld\brusprnt02", False, "site (" & sSiteName & ")"
	Case "Frankfurt"
		MapPrinterConnection "\\fran-ps01.domain.tld\franprnt01", False, "site (" & sSiteName & ")"
		MapPrinterConnection "\\fran-ps01.domain.tld\franprnt02", True, "site (" & sSiteName & ")"
		Select Case sDepartment
			Case "Accounts"
				MapPrinterConnection "\\fran-ps01.domain.tld\franprnt01", True, "department (" & sDepartment & ")"
			Case "Sales"
				MapPrinterConnection "\\fran-ps01.domain.tld\franprnt03", True, "department (" & sDepartment & ")"
		End Select
	Case "London"
		GetDefaultGateways(dDefaultGateways)
		If dDefaultGateways.Exists("10.0.50.1") Or dDefaultGateways.Exists("10.0.52.1") Then
			MapPrinterConnection "\\lond-ps01.domain.tld\londprnt01", False, "location (1st floor, London)"
			MapPrinterConnection "\\lond-ps01.domain.tld\londprnt02", False, "location (1st floor, London)"
			Select Case sDepartment
				Case "Compliance"
					MapPrinterConnection "\\lond-ps01.domain.tld\londprnt03", True, "department (" & sDepartment & ")"
				Case "Finance", "HR"
					MapPrinterConnection "\\lond-ps01.domain.tld\londprnt04", True, "department (" & sDepartment & ")"
				Case "IT"
					MapPrinterConnection "\\lond-ps01.domain.tld\londprnt05", True, "department (" & sDepartment & ")"
			End Select
		ElseIf dDefaultGateways.Exists("10.0.54.1") Then
			MapPrinterConnection "\\lond-ps01.domain.tld\londprnt06", False, "location (2nd floor, London)"
		End If
End Select

sEventDescription = sEventDescription & "--" & vbcrlf & "Logon Script: " & Wscript.ScriptFullName & vbcrlf & "End: " & Date & " " & Time & vbcrlf
If bInteractive Then Wscript.echo "Event ID: " & iEventID & vbcrlf & "Event Description: " & vbcrlf & sEventDescription
oShell.LogEvent iEventID, sEventDescription
Wscript.quit

'________________________________

Sub MapPrinterConnection(sPrinter, bDefault, sReason)
	On Error Resume Next
	If dMappedPrinters.Exists(sPrinter) Then
	Else
		sEventDescription = sEventDescription & Time & " | Connecting to " & sPrinter & " due to " & sReason & ". "
		oNetwork.AddWindowsPrinterConnection sPrinter
		If Err Then
			iEventID = 2
			sEventDescription = sEventDescription & "Result: Failed!" & vbcrlf &_
				vbTab & "Error Number: " & Err.Number & vbcrlf & vbTab & "Error Description: " & Replace(Err.Description, vbcrlf, " | ") & vbcrlf
			Err.Clear
		Else
			sEventDescription = sEventDescription & "Result: Success!" & vbcrlf
			dMappedPrinters.Add sPrinter, 1
		End If
	End If
	If bDefault And dMappedPrinters.Exists(sPrinter) Then
			oNetwork.SetDefaultPrinter sPrinter
			sEventDescription = sEventDescription & Time & " | " & sPrinter & " set as default due to " & sReason & "." & vbcrlf
	End If
End Sub

'________________________________

Sub GetDefaultGateways(dDefaultGateways)
	Dim oWMI : Set oWMI = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Dim cNetworkAdapters : Set cNetworkAdapters = oWMI.ExecQuery("Select DefaultIPGateway from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")
	Dim i, oNetworkAdapter, sDefaultGateway
	For Each oNetworkAdapter in cNetworkAdapters
		If Not IsNull(oNetworkAdapter.DefaultIPGateway) Then
			For i=LBound(oNetworkAdapter.DefaultIPGateway) to UBound(oNetworkAdapter.DefaultIPGateway)
				sDefaultGateway = oNetworkAdapter.DefaultIPGateway(i)
				If dDefaultGateways.Exists(sDefaultGateway) Then
				Else
					dDefaultGateways.Add sDefaultGateway, 1
				End If
			Next
    End If
	Next
End Sub

'________________________________
