# How to cancel and clear print jobs stuck in the print queu

## Original Links

- [x] Original Technet URL [How to cancel and clear print jobs stuck in the print queu](https://gallery.technet.microsoft.com/How-to-cancel-and-clear-d2966353)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-cancel-and-clear-d2966353/description)
- [x] Download: [Download Link](Download\39193.zip)

## Output from Technet Gallery

**How to cancel and clear print jobs stuck in the print queue using PowerShell**** (PowerShell)**

**Introduction**

This PowerShell Script shows how to cancel print jobs stuck in the print queue.

**Scenarios**

Maybe you have ever run into the situation where you try to print something and nothing happens. There are a ton of reasons why a print job may not actually print, but one of the common causes is that the printer queue has a stuck print job. Sometimes you  can manually go in and delete the print job, but sometimes you just can’t get rid of it. This script sample will show you how to clean up the legacy print jobs.

**Script**

**Step1:** To run the script in the Windows PowerShell Console**,** type the one command&lt; Script Path&gt; at the Windows PowerShell Console.

For example, type **C:\Script\CompactPSTInOutlook\CompactPSTInOutlook.ps1**

![](Images\image002.png)

When the script finishes running, Windows PowerShell Console will display brief information about the script.

Here are some code snippets for your references.

```
If ($PSCmdlet.ShouldProcess("Cancel print job(s)","Printer"))
{
    If($PrinterInfo)
    {
        Try
        {
            Write-Verbose "Cancelling printer jobs."
            $PrinterInfo | Foreach{$_.CancelAllJobs()}
            Write-Host "Successfully cancel print job(s)."
        }
        Catch
        {
            Write-Host "Failed to cancel print jobs stuck in the print queue."
        }
    }
    Else
    {
        Write-Host "Cannot find any print jobs stuck in the print queue."
    }
}
```

** **

**Prerequisite**

Windows PowerShell 2.0

