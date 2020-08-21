
Dim strComputer, strSRVName, strPrinterName, strIPAdr, strPrinterName, strDriverName, strDriverInfPath, strPrinterLocation, strPrinterDescription
Dim objWMIService, objNewPort, objDriver, objPrinter

' Enter the following details for the new LPR Printer
' <PRINTER_NAME> = Name of the Printer, you will find the name in the INF file of the driver
' <PATH_TO_INF_FILE> = The Path where the printer INF file is located
' <SERVER_NAME> = The name of the print server where the LPR cue is installed
' <SERVER_IP> = The IP Adress of your print server
' <CUE_NAME> = The name of the printer cue
' <LOCATION> = Where the printer is located
' <DESCRIPTION> = Needed information of the printer, eg Type of the Printer, IP Adr, or something you like
' Example:
' MapLPRPrinter "HP Universal Printing PCL 5", ".\Printers\", "hpcu107b.inf", "SERVER01", "192.168.0.1", "HPLJ_LPR", "Accounting Office", "HP Color Laserjet from John Doe"


MapLPRPrinter "<PRINTER_NAME>", "<PATH_TO_INF_FILE>", "<INF_FILE>", "<SERVER_NAME>", "<SERVER_IP>", "<CUE_NAME>", "<LOCATION>", "<DESCRIPTION>"


Sub MapLPRPrinter(strDriverName,strDriverInfPath,strDriverInf,strSRVName,strIPAdr,strPrinterName,strPrinterLocation,strPrinterDescription)

'==========
' Connects to a Printer and sets this printer as a LPR Printer

	strComputer = "."

	Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
 	objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True
	On Error Resume Next
 
'SETS PRINTER PORT.
 
     Set objNewPort = objWMIService.Get("Win32_TCPIPPrinterPort").SpawnInstance_
	objNewPort.Name = strSRVName & ":" & strPrinterName
	objNewPort.PortNumber = "515"
	objNewPort.Protocol = 2
	objNewPort.HostAddress = strIPAdr
	objNewPort.Queue = strPrinterName
	objNewPort.ByteCount = True
	objNewPort.SNMPEnabled = False
	objNewPort.Put_

	NewPort = objNewPort.Put_
     
'INSTALLS DRIVER NOT LOCATED IN Driver.cab

     Set objDriver = objWMIService.Get("Win32_PrinterDriver")
	objDriver.Name = strDriverName
	objDriver.SupportedPlatform = "Windows NT x86"
	objDriver.Version = "3"
	objDriver.DriverPath = strDriverInfPath
	objDriver.Infname = strDriverInfPath & strDriverInf

 	intResult = objDriver.AddPrinterDriver(objDriver)

'SETS PRINTER TO PORT.
 
     Set objPrinter = objWMIService.Get("Win32_Printer").SpawnInstance_
	objPrinter.Name = strPrinterName
	objPrinter.DriverName = strDriverName
	objPrinter.PortName   = strSRVName & ":" & strPrinterName
	objPrinter.DeviceID   = strPrinterName
	objPrinter.Location = strPrinterLocation
	objPrinter.Comment = strPrinterDescription
	objPrinter.Description = strPrinterDescription
	objPrinter.CurrentLanguage = 2
	objPrinter.Network = True
	objPrinter.Shared = False
	objPrinter.EnableBIDI = False
	objPrinter.Put_
End Sub
