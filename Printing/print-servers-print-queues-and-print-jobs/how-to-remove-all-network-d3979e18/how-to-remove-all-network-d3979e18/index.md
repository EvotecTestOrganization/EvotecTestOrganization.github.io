# How to remove all network printers on a computer

## Original Links

- [x] Original Technet URL [How to remove all network printers on a computer](https://gallery.technet.microsoft.com/How-to-remove-all-network-d3979e18)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-remove-all-network-d3979e18/description)
- [x] Download: [Download Link](Download\VBScript.zip)

## Output from Technet Gallery

* * *

[!\[\](http://bit.ly/onescriptlogo)](http://blogs.technet.com/b/onescript)

**Script to remove all network printers on a computer (VBScript)**

**Introduction**

This VBScript shows how to remove all network printers on a computer.

**Scenarios**

Remove all network printers is a frequently asked question in many public forums.

**Script**

**Step 1: **Double-click SetDesktopIE.vbs to run this VBScript sample.The step is shown in the following figure:

![](Images\image.png)

When script finishes running, you will see something as shown in the following figure. However, if there is no network printer in your currently environment, it will not be shown.

Here are some code snippets for your references:

VB Script

```
Set networkPrinters = objWMI.ExecQuery("Select * From Win32_Printer Where Network = true")
For Each networkPrinter in networkPrinters
    networkPrinter.Delete_
Next
WScript.Echo "Successfully deleted all network printers"
```

**Prerequisite**

Windows 7

Microsoft All-In-One Script Framework is an automation script sample library for IT Professionals. The key value that All-In-One Script Framework is trying to deliver is Scenario-Focused Script Samples driven by IT  Pros' real-world pains and needs. The team is monitoring all TechNet forums, IT Pros' support calls to Microsoft, and script requests submitted to TechNet Script Repository. We collect frequently asked IT scenarios, and create script samples to automate the  tasks and save some time for IT Pros. The team of All-In-One Script Framework sincerely hope that these customer-driven automation script samples can help our IT community in this script-centric move.

