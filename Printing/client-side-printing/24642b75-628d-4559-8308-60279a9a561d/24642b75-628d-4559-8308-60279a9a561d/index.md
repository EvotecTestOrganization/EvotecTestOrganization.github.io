# Printing the contents of a directory and subdirectories recursively

## Original Links

- [x] Original Technet URL [Printing the contents of a directory and subdirectories recursively](https://gallery.technet.microsoft.com/24642b75-628d-4559-8308-60279a9a561d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/24642b75-628d-4559-8308-60279a9a561d/description)
- [x] Download: Not available.

## Output from Technet Gallery

## Description

The purpose of this script is to allow the user to simply enter a path and hit return and have the script silently print the contents of that directory and its subdirectories via the default printer. I am printing only Excel workbooks, Visio drawings, JPEG  images and PDF files here, but you should be able to easily modify it to deal with other file types.

I am hoping this script will be helpful to you. If you spot any errors or would like to make any suggestions, you are very welcome. I am open to questions, but please note that my knowledge of this language is somewhat limited.

Credit goes to jv, who is much more knowledgable than myself, for helping me with this script.

Kind regards,

James Finch (MCDST)

## Script

Visual Basic

```
'Declare shell objects
Set objShell = CreateObject("Shell.Application")
Set WshShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
'Excel object for printing workbooks
Set Excel = WScript.CreateObject("Excel.Application")
'Get start directory from user
path = InputBox("Please enter a path:")
If path <> "" Then
    'Get directory object & items
    Set objFolder = objFSO.GetFolder(path)
    Set shFolder = objShell.Namespace(path)
    Set colItems = shFolder.Items
    'Iterate through items collection, printing documents
    For i = 0 To colItems.Count - 1
    'Grab extension
    str = Right(colItems.Item(i).Name, 4)
    'Print Word documents, Visio drawings and PDFs using InvokeVerbEx("Print")
        If str = ".doc" Or str = ".vsd" Or _
                str = ".pdf" Then
        colItems.Item(i).InvokeVerbEx("Print")
    End If
    'Print a full workbook by iterating through worksheets
    If str = ".xls" Then
        'Set the workbook object by passing the full path to method Open
        Set workbook = Excel.Workbooks.Open(path & hfis(ai) & _
        "\" & colItems.Item(i).Name,false,true)
        'Print all non-blank worksheets iteratively
        For Each ws In workbook.Sheets
            ws.Printout
        Next
        workbook.Close
    End If
    'Print JPEGs 'silently' by passing them to Picture and Fax Viewer via command.com
    If str = ".jpg" Then
        'Resolve the long path into a short, DOS-compatible path
        str = WScript.CreateObject("Scripting.FileSystemObject").GetFile(path & hfis(ai) & _
        "\" & colItems.Item(i).Name).ShortPath
        'Pass file to Paint
        WshShell.Run "rundll32 C:\WINDOWS\system32\shimgvw.dll,ImageView_PrintTo /pt " & str
    End If
Next
    '* RECURSE THROUGH SUBDIRECTORIES *
    PrintSubfolders objFSO.GetFolder(path)
    Sub PrintSubFolders(subDir)
        For Each sd In subDir.SubFolders
            Set sdFolder = objShell.Namespace(sd.Path)
            Set colItems = sdFolder.Items
            For i = 0 To colItems.Count - 1
            str = Right(colItems.Item(i).Name, 4)
                If str = ".doc" Or str = ".vsd" Or _
                    str = ".pdf" Then
                colItems.Item(i).InvokeVerbEx("Print")
            End If
            If str = ".xls" Then
                Set workbook = Excel.Workbooks.Open(sd.Path & _
            "\" & colItems.Item(i).Name,false,true)
                For Each ws In workbook.Sheets
                    ws.Printout
                Next
                workbook.Close
            End If
            If str = ".jpg" Then
            str = WScript.CreateObject("Scripting.FileSystemObject").GetFile(sd.Path & _
            "\" & colItems.Item(i).Name).ShortPath
                WshShell.Run "rundll32 C:\WINDOWS\system32\shimgvw.dll,ImageView_PrintTo /pt " & str
            End If
            Next
            PrintSubFolders sd
        Next
    End Sub
    MsgBox("Done.")
Else 'User pressed Cancel
    MsgBox("Cancelled.")
End If
```

Note that calling InvokeVerbEx("Print") is basically equal to right-clicking on a file from within Windows Explorer and selecting Print. Therefore you can call this on any file so long as you have an application on your computer capable of opening it and  sending it to the printer.

Also note that in this line:

Visual Basic

```
WshShell.Run "rundll32 C:\WINDOWS\system32\shimgvw.dll,ImageView_PrintTo /pt " & str
```

str can be the Name of any file supported by Windows Picture and Fax Viewer.

Please rate this article if you find it helpful.

