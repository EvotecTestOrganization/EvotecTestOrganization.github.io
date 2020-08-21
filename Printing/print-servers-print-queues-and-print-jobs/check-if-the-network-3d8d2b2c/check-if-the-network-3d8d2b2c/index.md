# Check if the network printer is connected (VBScript)

## Original Links

- [x] Original Technet URL [Check if the network printer is connected (VBScript)](https://gallery.technet.microsoft.com/Check-if-the-network-3d8d2b2c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Check-if-the-network-3d8d2b2c/description)
- [x] Download: [Download Link](Download\CheckIfNetworkPrinterIsConnected (VBScript).zip)

## Output from Technet Gallery

# **Check if the network printer is connected (VBScript)**

## **Introduction**

This VBScript will list the status of network printer and whether the printer connection is connected.

## **Scenarios**

In a real word, office environment are always changing, users have been using the network for a long time. Many users will encounter some printer problems, but not all of the print problems are user related, sometime some problems from printer itself, especially  the printers were offline. IT helpdesk always take a lot of time on it.

## **Script**

**Step 1:**** ****Step 1: **Click **Start**, type **cmd** in the search box on the Start Menu, right-click the **cmd.exe **icon, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.

**Step 2: **Run this VBScript with cscript in the Windows Console (type the path of the script at the command prompt)

The step is shown in the following figure.

![](Images\image003.png)

When the script finishes running, it will spawn a window that displays brief information about the result.

![](Images\image006.png)

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

VB Script

```
For Each objPrinter in colPrinters
    PrinterPath = objPrinter.Name
    If  IsEmpty(PrinterPath) Then
        WScript.Echo "Failed to find printer, please check your printer service 'Spooler' is running."
    Else
        WshNetwork.AddWindowsPrinterConnection PrinterPath
        If Err.Number = 0 Then
            PrinterStatus = "Connected"
        Else
            PrinterStatus = "Unconnected"
        End If
        WScript.Echo "Name :" & vbTab & PrinterPath & vbCrLf & "Conneted Status : " & PrinterStatus
    End If
Next
```

## **Prerequisite**

Windows XP or higher version

