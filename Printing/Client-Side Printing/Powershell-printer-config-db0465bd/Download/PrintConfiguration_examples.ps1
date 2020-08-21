#Examples for:
#Get-PrintConfiguration
#Set-PrintConfiguration

#By Chris Sutton (Mith UK)


# Get Printer Config from Printer that has been properly configured
	
	$GPCA = get-printconfiguration -PrinterName $PNA
	
# Write the PrintTicketXML to an xml file

	$GPCA.PrintTicketXML | out-file C:\Temp\$PNA.xml

	
# Get printer configurations for multiple printers
	
	$PNA = "Printer Name A"
	$PNB = "Printer Name B"
	$PNC = "Printer Name C"
	
	$PN = $PNA,$PNB,$PNC

# OR get all the printers:
	$PN = (get-printer | select name).name
	
# Then do the Foreach loop
	Foreach ($P in $PN){
	$GPC = get-printconfiguration -PrinterName $P
	$GPC.PrintTicketXML | out-file C:\Temp\$P.xml
	}
	

# Set the Printer Configuration for Multiple Printers	
	$XMLA = Get-Content "C:\Temp\$PNA.xml" | Out-String 
	Set-PrintConfiguration -PrinterName $PNA -PrintTicketXml $XMLA
	
	$XMLB = Get-Content "C:\Temp\$PNB.xml" | Out-String 
	Set-PrintConfiguration -PrinterName $PNB -PrintTicketXml $XMLB
	
	$XMLC = Get-Content "C:\Temp\$PNC.xml" | Out-String 
	Set-PrintConfiguration -PrinterName $PNC -PrintTicketXml $XMLC