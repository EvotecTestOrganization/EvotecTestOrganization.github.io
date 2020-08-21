# Export to Pdf file powershell

## Original Links

- [x] Original Technet URL [Export to Pdf file powershell](https://gallery.technet.microsoft.com/Export-to-Pdf-file-d360e5cb)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Export-to-Pdf-file-d360e5cb/description)
- [x] Download: Not available.

## Output from Technet Gallery

.Synopsis

         Cmdlet to Export html to pdf using PDFCreator.exe

         .Requires

         Install PDFCreator from http://www.pdfforge.org

         Make pdfcreator as default printer

         Open pdfcreator and set the autosave option enabled and save

         .Usage

         Convert a text object to html using convertto-html and use out-pdfcreator for creating pdf

          or you can print a html without conversion

        .Example

         Out-PDFCreator -Input\_HTML "C:\test.html" -OUTPUT\_FOLDER "c:\test" -OUTPUT\_FILENAME "myname" -Verbose

         .Credits

         Adapted from script of Jishusen gupta titled "Automated Website Printing in IE using PowerShell"

         http://gallery.technet.microsoft.com/scriptcenter/1f08824a-c9db-415e-83b1-2c49ebda195c

```
<#
        .Synopsis
        Cmdlet to Export html to pdf using PDFCreator.exe
        .Requires
        Install PDFCreator from http://www.pdfforge.org
        Make pdfcreator as default printer
        Open pdfcreator and set the autosave option enabled and save
        .Usage
        Convert a text object to html using convertto-html and use out-pdfcreator for creating pdf
         or you can print a html without conversion
       .Example
        Out-PDFCreator -Input_HTML "C:\test.html" -OUTPUT_FOLDER "c:\test" -OUTPUT_FILENAME "myname" -Verbose
        .Credits
        Adapted from script of Jishusen gupta titled "Automated Website Printing in IE using PowerShell"
        http://gallery.technet.microsoft.com/scriptcenter/1f08824a-c9db-415e-83b1-2c49ebda195c
#>
Function Out-PDFCreator()
{
    Param(
            [Parameter(Position=1,Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
            $Input_Html="",
            [Parameter(Position=2,Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
            $OUTPUT_FOLDER="c:\test",
            [Parameter(Position=3,Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
            $OUTPUT_FILENAME="test"
    )
Try {
$PDFINFOPATH="HKCU:\Software\PDFCreator\Program"
Get-itemproperty -path $PDFINFOPATH -name "AutoSaveDirectory" |out-null
Set-itemproperty -path $PDFINFOPATH -name "AutoSaveDirectory" -value $OUTPUT_FOLDER |out-null
Get-itemproperty -path $PDFINFOPATH -name "UseAutoSave" |out-null
Set-itemproperty -path $PDFINFOPATH -name "UseAutoSave" -value "1" |out-null
Get-itemproperty -path $PDFINFOPATH -name "AutoSaveFilename" |out-null
Set-itemproperty -path $PDFINFOPATH -name "AutoSaveFilename" -value "$OUTPUT_FILENAME.pdf" |out-null
$IE = new-object -comobject "InternetExplorer.Application"
$IE.visible=$false
$IE.navigate("$Input_html")
$IE.ExecWB(6,2)
Start-Sleep -Seconds 5
#$ie.QueryStatusWB(6)
#$ie.QueryStatusWB(2)
$IE.quit
set-itemproperty -path $PDFINFOPATH -name "AutoSaveFilename" -value "" |out-null
set-itemproperty -path $PDFINFOPATH -name "AutoSaveDirectory" -value "" |out-null
set-itemproperty -path $PDFINFOPATH -name "UseAutoSave" -value "0" |out-null
}
Catch [system.exception]
{
    Write-Output $Error[0]
}
Finally { Write-Output "created $output_filename.pdf" }
}
```

