# Retrieve Duplex Printing Settings

## Original Links

- [x] Original Technet URL [Retrieve Duplex Printing Settings](https://gallery.technet.microsoft.com/62879402-6c9f-42f8-bb40-a3519a77ab86)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/62879402-6c9f-42f8-bb40-a3519a77ab86/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Stephane Courcy-Poitras

HTA that retrieves duplex printing settings. These settings are kept in a binary key of the registry; the key is to discover which must be to changed to set duplex printing, because these values are specific to each driver. This HTA retrieves the initial  values for selected printers drivers and then writes the changed bytes (offset and value) to a CSV file. This HTA is designed to be used along with the community scripts Exclude Printers From a Printer Configuration Script and Apply Printer Settings to Network  Printers.

Visual Basic

```
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Printer settings capture</title>
<HTA:APPLICATION 
     ID="CapturePrinterSettings"
     APPLICATIONNAME="CapturePrinterSettings"
     SCROLL="yes"
     SINGLEINSTANCE="yes"
     WINDOWSTATE="normal">


</head>
<SCRIPT Language="VBScript">
' -----------------------------------------------------------------------------------------
' Capture network printers settings to CSV files.
' Script by Stéphane Courcy-Poitras
' -----------------------------------------------------------------------------------------

'General declarations
Const CleRacine = "Printers\Connections\"
Const HKCU      =  &H80000001

Dim WSHShell          : Set WSHShell = CreateObject("WScript.Shell")
Dim WMI               : Set WMI = GetObject("Winmgmts:")
Dim wmiLocator        : Set wmiLocator = CreateObject("WbemScripting.SWbemLocator")
Dim NameSpace         : Set NameSpace = wmiLocator.ConnectServer("", "root\default")
Dim objRegistry       : Set objRegistry = NameSpace.Get ("StdRegProv")
Dim colPrinter        : Set colPrinter = WMI.InstancesOf("Win32_printer")
Dim Dict              : Set Dict = CreateObject("Scripting.Dictionary")    

'General functions and subs

Sub EcrireFichier (Chemin,Contenu) 
    'Write Contenu in file
    Const ForWriting = 2
    Dim oFSO: set oFSO = CreateObject("Scripting.FileSystemObject")
    Dim oFic
    Set oFic = oFSO.OpenTextFile(Chemin,ForWriting,True)
    oFic.Write(Contenu)
    oFic.Close()
    Set oFic = Nothing
    Set oFSO = Nothing
End Sub

</SCRIPT>

<body>
<h1>Printer settings capture</h1>
<p>Printer's setting are kept in the registry as an array of binary values 
specific to each printer driver. Use this tool to capture and save changes made 
to printers settings values and later on apply those changes to printers sharing 
the same driver on any workstation using the ApplyPrinterSettings.vbs script.</p><p><span class="Instructions">Printer's settings are kept in the DevMode registry key under HKCU\Printers\Connections\&lt;pinter name&gt;.</span></p><p><span class="NumeroEtape">Step 1: Select printers</span></p>
<p>Please select the printers to capture. Select only one printer for each 
distinct driver. </p>
<form action="" name="Formulaire" id="Formulaire">
  <div class="style1">
  <table width="100%" border="0">
    <tr bgcolor="#FFFFCC">
      <td width="4%" valign="top">&nbsp;</td>
      <td width="56%" valign="top"><strong>Printer</strong></td>
      <td width="56%" valign="top"><strong>Driver</strong></td>
      <td width="40%" valign="TOP"><strong>Capture</strong></td>
    <tr>
    <script language="vbscript">
      'Display available printers with check boxes 
      For Each oPrinter In colPrinter
        If (oPrinter.ServerName <> "") Then
          'Display only network printers ServerName = "" for local printers
          Document.write "<tr>"
          Document.write "<td width=""4%"" valign=""top"">&nbsp;</td>"
          Document.write "<td width=""56%"" valign=""top"">" & oPrinter.Name & "</td>"
          Document.write "<td width=""56%"" valign=""top"">" & oPrinter.DriverName & "</td>"
          Document.write "<td width=""40%"" valign=""TOP"">"
          Document.write "<input name=""" & oPrinter.Name & """type=""checkbox"" value=""1"" id=""" & oPrinter.name & """>"
          Document.write "</td>"
          Document.write "</tr>"
        End If
      Next
    </script>
    </table>
  <p><span class="NumeroEtape">Step 2: Set initial printer's setting </span></p>
  <p>To capture the changes made to printers settings array you must start by modifing each setting to capture to an initial value. This initial value must be different then the value you want to set. For instance, if you want to enable duplex printing, start by disabling it.</p><p>
    Now, set your initial settings for all selected printers then click on the button below.   </p><p>
    <input name="BoutonDemarrer" type="button" id="BoutonDemarrer" value="Initial capture">
  </p>
  <p><span class="NumeroEtape">Step 3: Capture and save changed settings</span></p><p>The captured settings will be saved in a CSV file for each selected printer driver. Each line of the CSV files will have the following format:</p><p><span class="resultat">Printer driver name, Offset, Binary value</span></p>
  <table  border="0" class="Instructions" style="width: 99%">
    <tr>
      <td class="Instructions" style="width: 47%">Save CSV files in the 	following directory:
      <td width="60%">	<input name="textDossier" type="text" id="textDossier" size="16" style="width: 293px" value="c:\temp"></td>
    </tr>
    </table>Now, change the settings to capture to the wanted value. For instance, you could now enable duplex printing on long side. When done, click on the button below.
    <input name="BoutonEnregistrer" type="button" id="BoutonEnregistrer" value="Capture and save settings">
  	</div>
</form>

<SCRIPT language="VBSCRIPT">

Sub BoutonDemarrer_OnClick()
     'Capture initials values from the DevMode binary keys of each selected printer
     Dim CheckBox
     For Each oPrinter In colPrinter
        If (oPrinter.ServerName <> "") Then
          'Network printer
          If Document.Formulaire.elements(oPrinter.Name).Checked Then
            'It is checked
            '\ are replaced by , in the registry key name
            'For instance \\server1\printer1 gives ,,server1,printer1
            Cle = CleRacine & Replace(oPrinter.DeviceID,"\",",")
            'Get the binary values
            objRegistry.GetBinaryValue HKCU,Cle,"DevMode",Valeurs
            'Keep the values in a dictionnary with printers name
            If Dict.Exists(oPrinter.Name) Then
              'In case the user clicked twice on the capture button, we overwrite the value
   			  Dict.Item(oPrinter.Name) = Valeurs
   			Else
   			  'Add a new value
   			  Dict.Add oPrinter.Name,Valeurs
   			End IF            	  End If
        End If
      Next
     MsgBox (Dict.Count & " captures done")
End Sub

Sub BoutonEnregistrer_OnClick()
     'Get the changed settings and save to file
     Dim CheckBox
     For Each oPrinter In colPrinter
        If (oPrinter.ServerName <> "") Then
          'This is a network printer
          If Document.Formulaire.elements(oPrinter.Name).Checked Then
            'It is checked
            '\ are replaced by , in the registry key name
            'For instance \\server1\printer1 gives ,,server1,printer1
            Cle = CleRacine & Replace(oPrinter.DeviceID,"\",",")
            'Get the new value
            objRegistry.GetBinaryValue HKCU,Cle,"DevMode",NouvelleValeurs
            If Dict.Exists(oPrinter.Name) Then
              'We have captured values
              Valeurs = Dict.Item(oPrinter.Name)
              Contenu = ""
              'Compare each byte of the array (can have hundreds of values)
              'and keep changed values in a csv string
           	  For i = LBound(Valeurs) To UBound(Valeurs)            If Valeurs(i) <> NouvelleValeurs(i) Then              If Contenu <> "" Then Contenu = Contenu & VbCrLf              'Format CSV : index;valeur              Contenu = Contenu & i & ";" & NouvelleValeurs(i)            End If
              Next
              If Contenu <> "" Then 
                'There are differences to save to the driver name            NomFichier = Formulaire.TextDossier.Value            If Right(NomFichier,1) <> "\" Then NomFichier = NomFichier & "\"            NomFichier = NomFichier & Replace(oPrinter.DriverName," ","_") & ".csv"            EcrireFichier NomFichier,Contenu            MsgBox "Settings captured for " & oPrinter.Name & " saved in " & NomFichier          Else            'No differences            MsgBox "No settings captured for " & oPrinter.Name          End If        Else          'On n'a rien trouvé dans le dictionnaire...          MsgBox "No initial settings found for " & oPrinter.Name
            End If	  End If
        End If
      Next
      Document.parentWindow.close()
End Sub
</SCRIPT>

</body>
</html>
```

