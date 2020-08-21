# Modify Print Job Priority

## Original Links

- [x] Original Technet URL [Modify Print Job Priority](https://gallery.technet.microsoft.com/d97e6e03-b5c2-42ab-8ec4-a9b1d97d0a7a)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/d97e6e03-b5c2-42ab-8ec4-a9b1d97d0a7a/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses ADSI to change the priority of current print jobs based on the size of those print jobs.

Visual Basic

```
Set objPrinter = GetObject _
    ("WinNT://atl-dc-02/ArtDepartmentPrinter, printqueue")

For Each objPrintJob in objPrinter.PrintJobs
    If objPrintJob.Size > 400000 Then
        objPrintJob.Put "Priority" , 2
        objPrintJob.SetInfo
    Else
        objPrintJob.Put "Priority" , 3
        objPrintJob.SetInfo
    End If
Next
```

