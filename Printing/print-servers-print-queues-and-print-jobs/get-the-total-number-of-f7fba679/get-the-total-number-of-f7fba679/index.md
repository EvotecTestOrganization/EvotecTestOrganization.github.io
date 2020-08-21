# Get the Total Number of Printers Hosted on a Print Server (PowerShell)

## Original Links

- [x] Original Technet URL [Get the Total Number of Printers Hosted on a Print Server (PowerShell)](https://gallery.technet.microsoft.com/Get-the-Total-Number-of-f7fba679)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Get-the-Total-Number-of-f7fba679/description)
- [x] Download: [Download Link](Download\GetTheCountOfPrintersHostedOntheServer(PowerShell).zip)

## Output from Technet Gallery

# Get the Total Number of Printers Hosted on a Print Server (PowerShell)

## **Introduction**

This sample can help you to get the total number of the printers hosted on your print Server by using PowerShell.

## **Scenario****s **

It is important to note that the primary limitation of the print server in this configuration is related to remote management and not the result of constraints imposed by the print server hardware or core spooler component. Specifically, when you are viewing  and sorting columns in the Printers and Faxes folder, the Server may begin to experience delays if it is hosting more than 1,500 printers. You can run this script to get the total number of the printers hosted on your print Server.

## Script

This script contains one advanced function:

- Measure-OSCPrinterCountTheServerHosted

You can use this script in the following ways (You need run the script as administrator):

Method 1:

1. Download the script and copy it to your computer.

2. Open the script file by using Notepad or any other script editors.

3. Scroll down to the end of the script file, and then add the code to call the functions.

4. Save the file and then run the script on the computer.

Method 2:

1. Rename *scriptname*.ps1 to *scriptname*.psm1 (PowerShell Module file)

2. Run the Import-Module cmdlet to import this module file in PowerShell Console.

Import-Module *filepath*\*scriptname*.psm1

To obtain the detailed information about how to use the functions, run the following command to retrieve the help information:

Get-Help functionName -detailed

For example:

Get-Help Measure- OSCPrinterCountTheServerHosted -detailed

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

```
$PrintSpoolerResources = Get-OSCAllPrintSpoolerResources
If ($PrintSpoolerResources.Count -gt 0) {
    Foreach($Resourcein$PrintSpoolerResources){
        $PrintsInCurrentResource = Get-Item-Path `
            (-join("HKLM:\Cluster\Resources\", $Resource.ID,"\Printers"))`
            -ErrorAction SilentlyContinue
        $PrinterCountTheServerHosted+= $PrintsInCurrentResource.SubKeyCount
    }
}
Else{
    $PrintsInCurrentResource = Get-ChildItem-Path `
        "HKLM:\SYSTEM\CurrentControlSet\Control\Print\Printers"$PrinterCountTheServerHosted+= $PrintsInCurrentResource.Count
}
```

## Examples

**Example 1: **Get the total number of the printers hosted on your print Server

**Command: Measure-OSC****PrinterCountTheServerHosted

Screenshot:

![](Images\image002.jpg)**

## Prerequisites

Windows PowerShell 2.0

 Microsoft Windows Print Server

## **Additional Resources**** **

**Technical Resources:**

[Windows Print Server Scalability and Sizing Reference System](http://technet.microsoft.com/en-us/library/cc781857%28WS.10%29.aspx)

[MSCluster\_Resource class](http://msdn.microsoft.com/en-us/library/windows/desktop/aa371464%28v=vs.85%29.aspx)

