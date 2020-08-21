# How to remove all network printers on a computer

## Original Links

- [x] Original Technet URL [How to remove all network printers on a computer](https://gallery.technet.microsoft.com/How-to-remove-all-network-f3816c96)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-remove-all-network-f3816c96/description)
- [x] Download: [Download Link](Download\PowerShell.zip)

## Output from Technet Gallery

* * *

[!\[\](http://bit.ly/onescriptlogo)](http://blogs.technet.com/b/onescript)

**Script to remove all network printers on a computer (PowerShell)**

**Introduction**

This PowerShell script shows how to remove all network printers on a computer.

**Scenarios**

Remove all network printers is a frequently asked question in many public forums.

**Script**

**Step1:** Start the PowerShell Console with administrator. To run the script in the Windows PowerShell Console**,** type the one command&lt; Script Path&gt; at the Windows PowerShell Console.

For example, type **C:\Scripts\RemoveAllNetworkPrinters.ps1**

The step is shown in the following figure.

![](Images\image.png)

Here are some code snippets for your references.

```
Foreach($NetworkPrinter in $NetworkPrinters)
            {
                $NetworkPrinter.Delete()
                Write-Host "Successfully deleted the network printer:" + $NetworkPrinter.Name -ForegroundColor Green
            }
```

**Prerequisite**

Windows PowerShell 2.0

Windows 7

Microsoft All-In-One Script Framework is an automation script sample library for IT Professionals. The key value that All-In-One Script Framework is trying to deliver is Scenario-Focused Script Samples driven by IT  Pros' real-world pains and needs. The team is monitoring all TechNet forums, IT Pros' support calls to Microsoft, and script requests submitted to TechNet Script Repository. We collect frequently asked IT scenarios, and create script samples to automate the  tasks and save some time for IT Pros. The team of All-In-One Script Framework sincerely hope that these customer-driven automation script samples can help our IT community in this script-centric move.

