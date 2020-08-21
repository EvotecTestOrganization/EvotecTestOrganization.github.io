# How to Clear Printing Subsystem (PowerShell)

## Original Links

- [x] Original Technet URL [How to Clear Printing Subsystem (PowerShell)](https://gallery.technet.microsoft.com/How-to-Clear-Printing-93eb5ebc)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-Clear-Printing-93eb5ebc/description)
- [x] Download: [Download Link](Download\FixPrinter.zip)

## Output from Technet Gallery

# **How to Clear Printing Subsystem (PowerShell)**

## **Introduction**

This script is used to clear Printing Subsystem.

## **Scenarios**

Generally, to clear existing printing related components, several steps are required. The steps can easily be followed on individual systems. However, if there are hundreds of computers in the domain and they have the same printing issue, it may be hard to resolve. The script can help domain administrators to clean the printing subsystem for multiple computers easily.

## **Script**

This script contains one advanced function, **Repair-OSCPrinter**, You can use this script in the following ways:

Method 1:

1. Download the script and open the script file     with Notepad or any other script editors.

2. Scroll down to the end of     the script file, and then add the example command which you want to run.

3. Save the file then run the     script in PowerShell.

Method 2:

1. Rename *scriptname*.ps1 to *scriptname*.psm1 (PowerShell Module file)

2. Run Import-Module cmdlet to import this module file.

    Import-Module *filepath*\*scriptname*.psm1

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

```
#Stop spooler serviceif(Stop-Service-Name Spooler  -Force -ErrorAction Stop )
{
    Write-Host "Stoping the Spooler Service!"
}
Write-Host "Deleting old files and folders!"#Delete files or foldersGet-ChildItem-Path "C:\Windows\System32\Spool\Printers"|Remove-ItemGet-ChildItem-Path "C:\Windows\System32\Spool\Drivers\w32x86"|Remove-Item
write-host "Backup registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Environments\Windows NT x86 as NTX86.REG"#Back up registry key
REG EXPORT "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Environments\Windows NT x86" NTX86.REG
```

## **Examples**

**Example 1**: Get help about **Repair-OSCPrinter**

**Command**:   Get-help Repair-OSCPrinter –Full

**Screenshot**:

![](Images\image001.jpg)

**Example 2**: Clear the Printing Subsystem

**Command**:   Repair-OSCPrinter -FixPrinter

**Screenshot**:

![](Images\image003.jpg)

**Example 3**: Restore the registry key

**Command**:   Repair-OSCPrinter -RestoreREG

**Screenshot**:

![](Images\image005.jpg)

## **Prerequisite**

Windows PowerShell 2.0

## **Additional Resources**

**Technical Resource:

**[Problems adding network printers](http://social.technet.microsoft.com/Forums/en-US/w7itpronetworking/thread/0da9898f-e06c-4435-a59b-b5476a8ae547)

[Can't add printer. Print Spooler crashes. Error code 0x000006be](http://social.technet.microsoft.com/Forums/en-US/itprovistaprinting/thread/3e47b7b6-00a3-47e1-9e28-e615fbff5f87/)

