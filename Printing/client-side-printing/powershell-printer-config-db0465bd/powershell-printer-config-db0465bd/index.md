# Powershell Get- & Set-PrintConfiguration (Printuidll replacement)

## Original Links

- [x] Original Technet URL [Powershell Get- & Set-PrintConfiguration (Printuidll replacement)](https://gallery.technet.microsoft.com/Powershell-printer-config-db0465bd)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Powershell-printer-config-db0465bd/description)
- [x] Download: [Download Link](Download\PrintConfiguration_examples.ps1)

## Output from Technet Gallery

This is my first PowerShell upload here at Technet (so please feedback if you need to)

 I'm claiming a world first on this as I couldn't find this info ANYWHERE on the net. (yes there are the commands, but not a proper example of how to get the config correctly or apply it).

 Previously to set the configuration properties of a printer you would use a fairly lengthy procedure which used the PrintUI.exe (or printuidll) procedure, something like this:

PRINTUI.EXE /Sr /n "Name of Printer" /a "full\path\to\configuration\file" d u g 8 r

So with the powershell printer commands, its much more simple.  Just set the parameters of your installed printer, how you like it (paper size, colour, orientation, private print or whatever other settings you need to change.

Then run the following code (Change $PNA to the actual name of your printer)

```
$PNA = "Printer name a"
    $GPC = get-printconfiguration -PrinterName $PNA
    $GPC.PrintTicketXML | out-file C:\Temp\$PNA.xml
```

This will save the correct printer configurations to an xml file: "C:\Temp\Printer name a.xml"

To get the XML Config file of multiple Printers.  I use the following code:

```
$PNA = "Printer Name A"
    $PNB = "Printer Name B"
    $PNC = "Printer Name C"
    $PND = "Printer Name D"
    $PN = $PNA,$PNB,$PNC,$PND
    Foreach ($P in $PN){
    $GPC = get-printconfiguration -PrinterName $P
    $GPC.PrintTicketXML | out-file C:\Temp\$P.xml
    }
```

You can see how this can be expanded for multiple printers.  Im sure someone can make this even simpler, or you could even use this code to get the name of all your printers (be aware of Faxes, XPS Document writer, etc if you keep them!)

```
$PN = (get-printer | select name).name
    Foreach ($P in $PN){
    $GPC = get-printconfiguration -PrinterName $P
    $GPC.PrintTicketXML | out-file C:\Temp\$P.xml
    }
```

To apply Printetr Configurations you would use these commands:

```
$PNA = "Printer Name A"
    $XMLA = Get-Content "Path\to\$PNA.xml" | Out-String
    Set-PrintConfiguration -PrinterName $PNA -PrintTicketXml $XMLA
```

 I've written this so that you can expand it for multiple printers, in your environment.

After a lot of testing, Ive been using this in our live environment to set configs for multiple printers on over 300 different site and over 4000 users.

Thanks,

MithUK

