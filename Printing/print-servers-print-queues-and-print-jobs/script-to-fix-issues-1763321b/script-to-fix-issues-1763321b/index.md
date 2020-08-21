# Script to fix issues described in KB2027593

## Original Links

- [x] Original Technet URL [Script to fix issues described in KB2027593](https://gallery.technet.microsoft.com/Script-to-fix-issues-1763321b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Script-to-fix-issues-1763321b/description)
- [x] Download: [Download Link](Download\DeleteEvilPrintQueueRegKey.zip)

## Output from Technet Gallery

# Script to fix issues described in KB2027593

## Introduction

This sample can help you resolve the issue “The new printer status is **Offline** after you delete a print queue and then restart a Windows-based computer” described in KB2027593. It demonstrates how to list printers,  print queues and how to delete evil registry key for print queue by using PowerShell script. This script completes the tasks by using registry and WMI Win32\_Printer class.

## Scenarios

Consider the following scenario:

- You delete a print queue while it is in an Offline status.

- You add a new print queue that has the same name as the old print queue.

- You restart the computer.

In this scenario, the status of the new print queue is displayed as Offline. To solve this issue, you can use this script to get and remove evil registry key which cause the problem after you delete a print queue but before you add a new print queue of the  same name.

## Script

This script contains the following advanced functions:

- Get-OSCPrinter

- Get-OSCPrintQueue

- Remove-OSCEvilPrintQueueRegkey

You can use this script in the following ways:

Method 1:

1. Download the script and copy it to your computer.

2. Open the script file with Notepad or any other script editors.

3. Scroll down to the end of the script file, and then add the code to call the functions.

4. Save the file and then run the script on the computer.

Method 2:

1. Rename *scriptname*.ps1 to *scriptname*.psm1 (PowerShell Module file)

2. Run Import-Module cmdlet to import this module file in PowerShell Console.

 Import-Module *filepath*\*scriptname*.psm1

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

```
Try{
    $KeyPrintQueue = $BaseKeyPrintQueues.OpenSubKey(`
    "System\CurrentControlSet\Control\Print\Printers\" `
    + $KeyPrintQueueName, $false)
    }
    Catch{
    Write-Error ($Message.FailToOpenSubKey +
    " [HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\" +
    "Print\Printers\" + $KeyPrintQueueName +" ]")
    return $Null
    }
    $KeyPrintQueueValuesList = $KeyPrintQueue.GetValueNames()
    If($KeyPrintQueueValuesList -contains 'PrinterOnLine'){
    $ValueType = $KeyPrintQueue.GetValueKind('PrinterOnLine')
    If ($ValueType -eq "Dword"){
        If($KeyPrintQueue.GetValue("PrinterOnLine") -eq 0){
            $OSCPrintQueue = New-Object -TypeName PSObject
            $OSCPrintQueue | Add-Member NoteProperty PrintQueueName `
            $KeyPrintQueue.Name.Replace(
            'HKEY_CURRENT_CONFIG\System\CurrentControlSet\Control\Print\Printers\','')
            $OSCPrintQueue | Add-Member NoteProperty Printer $null
            $OSCPrintQueue | Add-Member NoteProperty `
            PrinterDriver $null
            $OSCPrintQueue | Add-Member NoteProperty Computer `
            $Computer
            $OSCPrintQueue | Add-Member NoteProperty IsEvilPrintQueue $true
            # Get the printer info of a print queue
            Foreach($OSCPrinter in $OSCPrinters){
                $PrinterName = [String]$OSCPrinter.PrinterName
                $PrintQueueName = $KeyPrintQueueName
                If($PrintQueueName -eq $OSCPrinter.PrinterName){
                    $OSCPrintQueue.Printer = $OSCPrinter.PrinterName
                    $OSCPrintQueue.PrinterDriver = `
                    $OSCPrinter.PrinterDriver
                    $OSCPrintQueue.IsEvilPrintQueue = $false
                }
                Else{
                    While($PrintQueueName -match "^.{1,}(\s){1}\(redirected(\s)[1-9][0-9]*\)$"){
                        $PrintQueueName = $PrintQueueName.Substring(`
                        0,$PrintQueueName.LastIndexof(' (redirected'))
                        If($PrintQueueName -eq $OSCPrinter.PrinterName){
                            $OSCPrintQueue.Printer = $OSCPrinter.PrinterName
                            $OSCPrintQueue.PrinterDriver = `
                            $OSCPrinter.PrinterDriver
                            $OSCPrintQueue.IsEvilPrintQueue = $false
                            Break
                        }
                    }
                }
            }
            $OSCPrintQueues += $OSCPrintQueue
        }
    }
}
```

## Examples

**Example 01: **Get all printers **

Command: Get-OSCPrinter

Screenshot:

![](Images\image002.jpg)**

**Example 0****2****: **Get a specific printer **

Command: Get-OSCPrinter  -Printer &lt;PrinterName&gt;

Screenshot:

![](Images\image004.jpg)**

**Example 03: Get all print queues

Command: Get-OSCPrinter  -Printer &lt;PrinterName&gt;

Screenshot:

![](Images\image006.jpg)**

**Example 04: Get print queue of a specific printer

Command: Get- OSCPrintQueue -Printer &lt;PrinterName&gt;

Screenshot:

![](Images\image008.jpg)**

**Example 05: Delete evil registry key for a specific print queue

Command: Remove-OSCEvilPrintQueueRegKey -PrintQueue  &lt;PrintQueueName&gt;

Screenshot:

![](Images\image010.jpg)**

**Example 06: Delete all evil registry keys for print queues in the current computer

Command: Remove-OSCEvilPrintQueueRegKey

Screenshot:

![](Images\image012.jpg)**

## Prerequisites

Windows PowerShell 2.0

## **Additional Resources**

**Technical Resource:  **

[The new printer status is "Offline" after you delete a print queue and then restart a Windows-based computer](http://support.microsoft.com/kb/2027593)

[Win32\_Printer class](http://msdn.microsoft.com/en-us/library/windows/desktop/aa394363%28v=vs.85%29.aspx)

