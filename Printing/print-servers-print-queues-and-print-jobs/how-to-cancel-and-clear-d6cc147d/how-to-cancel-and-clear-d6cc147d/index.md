# How to cancel and clear print jobs stuck in the print queu

## Original Links

- [x] Original Technet URL [How to cancel and clear print jobs stuck in the print queu](https://gallery.technet.microsoft.com/How-to-cancel-and-clear-d6cc147d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-cancel-and-clear-d6cc147d/description)
- [x] Download: [Download Link](Download\39509.zip)

## Output from Technet Gallery

**How to cancel and clear print jobs stuck in the print queue using PowerShell**** (VBScript)**

**Introduction**

This VBScript shows how to cancel print jobs stuck in the print queue.

**Scenarios**

Maybe you have ever run into the situation where you try to print something and nothing happens. There are a ton of reasons why a print job may not actually print, but one of the common causes is that the printer queue has a stuck print job. Sometimes you  can manually go in and delete the print job, but sometimes you just can’t get rid of it. This script sample will show you how to clean up the legacy print jobs.

**Script**

**Step1:** Double-click **CancelPrintJobs.vbs** to run this VBScript sample. The step is shown in the following figure.

The step is shown in the following figure.

![](Images\image001.png)

When the script finishes running, Windows PowerShell Console will display brief information about the script to let you know the execution result.

![](Images\image002.png)

Here are some code snippets for your references.

```
VB Script
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colPrintJobs =  objWMIService.ExecQuery("select * from Win32_Printer where PrinterState=0 and PrinterStatus=6")
For Each objPrintJob in colPrintJobs
    ' cancel
      objPrintjob.CancelAllJobs()
Next
```

** **

**Prerequisite**

Windows 7 or higher version

