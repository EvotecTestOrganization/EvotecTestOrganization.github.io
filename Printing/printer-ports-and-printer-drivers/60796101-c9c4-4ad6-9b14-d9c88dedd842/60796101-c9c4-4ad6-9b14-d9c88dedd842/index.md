# List Printer Information

## Original Links

- [x] Original Technet URL [List Printer Information](https://gallery.technet.microsoft.com/60796101-c9c4-4ad6-9b14-d9c88dedd842)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/60796101-c9c4-4ad6-9b14-d9c88dedd842/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Anonymous Submission

Lists information about the printers installed on a print server.

Visual Basic

```
' *** This script generates a spreadsheet containing printer information. It can query one, or multiple servers.
' *** David Wills 1-20-2005

Dim oFSO, oTS, strComputer, strExcelPath, objExcel, objSheet, sheet, intCount
Dim objWMIService, colItems, ErrState

' sheet = workbook sheet, intCount = count of workbook sheets

sheet = 1

' Specify path and file name for saved spreadsheet
strExcelPath = "c:\PrintServer details.xls"

' Try to start an Excel object
On Error Resume Next
Set objExcel = CreateObject("Excel.Application")
If Err.Number <> 0 Then
  On Error GoTo 0
  Wscript.Echo "Excel application not found."
  Wscript.Quit
End If
On Error GoTo 0

' Set the new workbook to have one sheet initially, in case there's just one server in the list
objExcel.SheetsInNewWorkbook = 1

' Create a new workbook.
objExcel.Workbooks.Add

' Open text file for processing
Set oFSO = CreateObject("Scripting.FileSystemObject")
Set oTS = oFSO.OpenTextFile("c:\printservers.txt")

Do Until oTS.AtEndOfStream

  ' Get a line from input file 
  strComputer = oTS.ReadLine
   
  ' Get the printer information
  Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
  Set colItems = objWMIService.ExecQuery("Select * from Win32_Printer",,48)
   
  ' Check to see if this is the first sheet of the workbook
  If sheet = 1 Then
    Set objSheet = objExcel.ActiveWorkbook.Worksheets(sheet)
    objSheet.Name = strComputer
  Else
  'Add a new sheet to the workbook
    intCount = objExcel.Sheets.Count
    objExcel.ActiveWorkbook.Sheets.Add,objExcel.sheets(intCount)
    Set objSheet = objExcel.ActiveWorkbook.Worksheets(sheet)
    objSheet.Name = strComputer
  End If

  ' Adding on error resume next - to deal with objItem not supported
  On Error Resume Next
   
  k=2

  ' Populate spreadsheet cells with printer attributes.
   objSheet.Cells(1, 1).Value = "Name"
   objSheet.Cells(1, 2).Value = "ShareName"
   objSheet.Cells(1, 3).Value = "Comment"
   objSheet.Cells(1, 4).Value = "Error"
   objSheet.Cells(1, 5).Value = "DriverName"
   objSheet.Cells(1, 6).Value = "EnableBIDI"
   objSheet.Cells(1, 7).Value = "JobCount"
   objSheet.Cells(1, 8).Value = "Location"
   objSheet.Cells(1, 9).Value = "PortName"
   objSheet.Cells(1, 10).Value = "Published"
   objSheet.Cells(1, 11).Value = "Queued"
   objSheet.Cells(1, 12).Value = "Shared"
   objSheet.Cells(1, 13).Value = "Status"

   For Each objItem in colItems

   ' Put error code into human readable form
   Select Case objItem.DetectedErrorState
    Case 4
     ErrState = "Out of Paper"
    Case 5
     ErrState = "Toner low"
    Case 6
     ErrState = "Printing"
    Case 9
     ErrState = "Offline"
    Case Else
     ErrState = objItem.DetectedErrorState
   End Select

   ' Populate the row with this printer's data
   objSheet.Cells(k, 1).Value = objItem.Name
   objSheet.Cells(k, 2).Value = objItem.ShareName
   objSheet.Cells(k, 3).Value = objItem.Comment
   objSheet.Cells(k, 4).Value = ErrState
   objSheet.Cells(k, 5).Value = objItem.DriverName
   objSheet.Cells(k, 6).Value = objItem.EnableBIDI
   objSheet.Cells(k, 7).Value = objItem.JobCountSinceLastReset
   objSheet.Cells(k, 8).Value = objItem.Location
   objSheet.Cells(k, 9).Value = objItem.PortName
   objSheet.Cells(k, 10).Value = objItem.Published
   objSheet.Cells(k, 11).Value = objItem.Queued
   objSheet.Cells(k, 12).Value = objItem.Shared
   objSheet.Cells(k, 13).Value = objItem.Status

   k = k + 1
   Next

   ' Format the spreadsheet.
   objSheet.Range("A1:M1").Font.Bold = True
   objSheet.Select
   objSheet.Range("A2").Select
   objExcel.ActiveWindow.FreezePanes = True
   objExcel.Columns(3).ColumnWidth = 25
   objExcel.Columns(5).ColumnWidth = 25
   objExcel.Columns(6).ColumnWidth = 10
   objExcel.Columns(8).ColumnWidth = 25
   objExcel.Columns(1).ColumnWidth = 20
   objExcel.Columns(9).ColumnWidth = 14
   objExcel.Columns(2).ColumnWidth = 15

   sheet = sheet + 1

Loop

' Save the spreadsheet and close the workbook.
objExcel.ActiveWorkbook.SaveAs strExcelPath
objExcel.ActiveWorkbook.Close

' Reset Excel application's SheetsInNewWorkbook to default
objExcel.SheetsInNewWorkbook = 3

' Quit Excel.
objExcel.Application.Quit

WScript.Echo "Print Sever spreadsheet is done"
```

