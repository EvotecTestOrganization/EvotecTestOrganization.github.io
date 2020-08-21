Const NETWORK = 22
Set objNetwork = CreateObject("WScript.Network")
strComputer = "."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colPrinters = objWMIService.ExecQuery("Select * From Win32_Printer")
   
For Each objPrinter in colPrinters
    If objPrinter.Attributes And NETWORK Then 
        strPrinter = objPrinter.Name
        objNetwork.RemovePrinterConnection strPrinter
    End If
Next