# Check if the network printer is connected (PowerShell)

## Original Links

- [x] Original Technet URL [Check if the network printer is connected (PowerShell)](https://gallery.technet.microsoft.com/Check-if-the-network-30e7800a)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Check-if-the-network-30e7800a/description)
- [x] Download: [Download Link](Download\CheckIfNetworkPrinterIsConnected (PowerShell).zip)

## Output from Technet Gallery

# **Check if the network printer is connected (PowerShell)**

## **Introduction**

This PowerShell script will list the status of network printer and whether the printer connection is connected.

## **Scenarios**

In a real word, office environment are always changing, users have been using the network for a long time. Many users will encounter some printer problems, but not all of the print problems are user related, sometime some problems from printer itself, especially  the printers were offline. IT helpdesk always take a lot of time on it.

## **Script**

**Step1:** Start the PowerShell Console with administrator. To run the script in the Windows PowerShell Console**,** type the one command&lt; Script Path&gt; at the Windows PowerShell Console.

For example, type **C:\Script\CheckIfNetworkPrinterIsConnected.ps1**

The step is shown in the following figure.

![](Images\image002.png)

When the script finishes running, it will display the results as below.

![](Images\image004.png)

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

```
Try
{    #retrieve all network printer and check if network printer is connected
    Get-WmiObject -Class Win32_Printer -ErrorAction Stop | Where {$_.Network} | Select-Object Name,SystemName,`
    @{Name="PrinterStatus";Expression={Switch($_.PrinterStatus)
                                        {1{"Other"; break}2{"Unknown"; break}3{"Idle"; break}4{"Printing"; break}5{"Warming Up"; break}6{"Stopped printing"; break}7{"Offline"; break}}}},`
    @{Name="ConnectedStatus";Expression={$PrinterName = $_.Name;
                                        Try
                                        {
                                            $NetworkObj = New-Object -ComObject WScript.Network
                                            $NetworkObj.AddWindowsPrinterConnection("$PrinterName")
                                            "Connected"}
                                        Catch
                                        {"Unconnected"}}} | Format-Table -AutoSize
}
```

## **Prerequisite**

Windows PowerShell 2.0

