# Exclude Printers From a Printer Configuration Scrip

## Original Links

- [x] Original Technet URL [Exclude Printers From a Printer Configuration Scrip](https://gallery.technet.microsoft.com/437f6748-c23d-4772-adac-2d632602bc34)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/437f6748-c23d-4772-adac-2d632602bc34/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Stephane Courcy-Poitras

Creates a printer exclusion list which specified printers not to be affected by the community script Apply Printer Settings to Network Printers.

Visual Basic

```
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Exclude printers</title>
<HTA:APPLICATION 
     ID="ExcludePrinters"
     APPLICATIONNAME="ExcludePrinters"
     SCROLL="yes"
     SINGLEINSTANCE="yes"
     WINDOWSTATE="normal">


</head>
<SCRIPT Language="VBScript">
' -----------------------------------------------------------------------------------------
' Create a printer exclusion list to save in user's homedir.
' Stéphane Courcy-Poitras
' -----------------------------------------------------------------------------------------

'General declarations
Const CleRacine = "Printers\Connections\"
Const HKCU      =  &H80000001

Dim WSHShell          : Set WSHShell = CreateObject("WScript.Shell")
Dim WMI               : Set WMI = GetObject("Winmgmts:")
Dim wmiLocator        : Set wmiLocator = CreateObject("WbemScripting.SWbemLocator")
Dim NameSpace         : Set NameSpace = wmiLocator.ConnectServer("", "root\default")
Dim colPrinter        : Set colPrinter = WMI.InstancesOf("Win32_printer")
Dim CheminExceptions,Exceptions        

'General functions and subs

Sub EcrireFichier (Chemin,Contenu) 
    'Save Contenu to file
    Const ForWriting = 2
    Dim oFSO: set oFSO = CreateObject("Scripting.FileSystemObject")
    Dim oFic
    Set oFic = oFSO.OpenTextFile(Chemin,ForWriting,True)
    oFic.Write(Contenu)
    oFic.Close()
    Set oFic = Nothing
    Set oFSO = Nothing
End Sub

Function LireFichier (Chemin) 
  'Get all text from file. Return "" if file not found.
  const ForReading = 1
  Dim fso: set fso = CreateObject("Scripting.FileSystemObject")
  Dim Fic
  If fso.FileExists(Chemin) Then
    Set Fic = fso.OpenTextFile(Chemin,ForReading,False)
    LireFichier = ""
    On Error Resume Next
    LireFichier = Fic.ReadAll()
    On Error GoTo 0
    Set Fic = Nothing
  Else
    LireFichier = ""
  End If
End Function  

</SCRIPT>

<body>
<h1>Excluded printers</h1>
<p>Don't apply saved printers settings to the current user for the following printers:</p>
<form action="" name="Formulaire" id="Formulaire">
  <table width="100%" border="0">
    <tr bgcolor="#FFFFCC">
      <td width="4%" valign="top"><strong></strong></td>
      <td width="56%" valign="top"><strong>Printer</strong></td>
      <td width="56%" valign="top"><strong>Driver</strong></td>
      <td width="40%" valign="TOP"><strong>Exclude</strong></td>
    <tr>
    <script language="vbscript">
      'Get actual excluded printers names
       CheminExceptions = WSHShell.SpecialFolders("MyDocuments") & "\ExcludedPrinters.txt"
       Exceptions = LireFichier(CheminExceptions)
      'Display network printers with check boxes
      For Each oPrinter In colPrinter
        If (oPrinter.ServerName <> "") Then
          'This is a network printer
          Document.write "<tr>"
          Document.write "<td width=""4%"" valign=""top"">&nbsp;</td>"
          Document.write "<td width=""56%"" valign=""top"">" & oPrinter.Name & "</td>"
          Document.write "<td width=""56%"" valign=""top"">" & oPrinter.DriverName & "</td>"
          Document.write "<td width=""40%"" valign=""TOP"">"
          If Instr(Exceptions,oPrinter.Name) = 0 Then
          	 'Printer already in exclusion list, show it checked
             Document.write "<input name=""" & oPrinter.Name & """type=""checkbox"" value=""1""" & oPrinter.name & """>"
          Else
          	'Printer not in exclusion list, show in unchecked
             Document.write "<input name='" & oPrinter.Name & "' type='checkbox' value='1'" & oPrinter.name & " checked='checked'>"
          End If
          Document.write "</td>"
          Document.write "</tr>"
        End If
      Next
    </script>
    </table><p class="style1">
    <input name="BoutonDemarrer" type="button" id="BoutonDemarrer" value="Save this list for the current user">
  </p>
 
</form>

<SCRIPT language="VBSCRIPT">

Sub BoutonDemarrer_OnClick()
     'Update the exclusion list file
     Dim CheckBox
     Exceptions = ""
     For Each oPrinter In colPrinter
        If (oPrinter.ServerName <> "") Then
          'This is a network printer
          If Document.Formulaire.elements(oPrinter.Name).Checked Then
            'It is checked, so add it...
            If Exceptions <> "" Then Exceptions = Exceptions & VbCrLf
            Exceptions = Exceptions & oPrinter.Name
          End If
        End If
      Next
      'Write the file
      EcrireFichier CheminExceptions ,Exceptions
      MsgBox ("Exclusion list saved")
      Document.parentWindow.close
    End Sub

</SCRIPT>

</body>
</html>
```

