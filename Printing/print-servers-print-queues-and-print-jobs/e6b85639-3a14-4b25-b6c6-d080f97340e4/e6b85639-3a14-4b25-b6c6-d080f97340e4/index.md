# Modify Print Job Start Tim

## Original Links

- [x] Original Technet URL [Modify Print Job Start Tim](https://gallery.technet.microsoft.com/e6b85639-3a14-4b25-b6c6-d080f97340e4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/e6b85639-3a14-4b25-b6c6-d080f97340e4/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses ADSI to change the start time for all print jobs larger than 400K to 2:00 AM.

Visual Basic

```
Set objPrinter = GetObject("WinNT://atl-dc-02/ArtDepartmentPrinter,printqueue")

For Each objPrintQueue in objPrinter.PrintJobs
    If objPrintQueue.Size > 400000 Then
        objPrintQueue.Put "StartTime" , TimeValue("2:00:00 AM")
        objPrintQueue.SetInfo
    End If
Next
```

