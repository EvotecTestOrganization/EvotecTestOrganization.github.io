# How to Clear Printing Subsystem (VBScript)

## Original Links

- [x] Original Technet URL [How to Clear Printing Subsystem (VBScript)](https://gallery.technet.microsoft.com/How-to-Clear-Printing-bf0a9fd0)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-Clear-Printing-bf0a9fd0/description)
- [x] Download: [Download Link](Download\FixPrinter(VBScript).zip)

## Output from Technet Gallery

# **How to Clear Printing Subsystem (VBScript)**

## **Introduction**

This script is used to clear Printing Subsystem.

## **Scenarios**

Generally, to clear existing printing related components, several steps are required. The steps can easily be followed on individual systems. However, if there are hundreds of computers in the domain and they have the same printing issue, it may be hard to resolve. The script can help domain administrators to clean the printing subsystem for multiple computers easily.

## **Script**

**Step1: **Run  "Command Prompt" as Administrator.

**Step2: **Enter "Cscript.exe *Scriptpath*" in to the Prompt,and press Enter.

For example:   Cscript.exe  "C: \OneScript\FixPrinter(VBScript)\FixPrinter.vbs"

It will show messages as the following.

![](Images\image002.jpg)

After the script executed, you can find two ".reg" files in the folder of the script. Those are the backup of the registry keys.

![](Images\image004.jpg)

Here are some code snippets for your references. To get the complete script sample, please click the download button at the beginning of this page.

VB Script

```
Sub main()
    Dim sExecutable
    sExecutable = LCase(Mid(Wscript.FullName, InstrRev(Wscript.FullName,"\")+1))
    If sExecutable <> "cscript.exe" Then
        wscript.echo "Please run this script with cscript.exe"
    Else
        Call FixPrinter
    End If
End Sub
```

## **Prerequisite**

Windows 7 or higher version

## **Additional Resources**

**Technical Resource:

**[Problems adding network printers](http://social.technet.microsoft.com/Forums/en-US/w7itpronetworking/thread/0da9898f-e06c-4435-a59b-b5476a8ae547)

[Can't add printer. Print Spooler crashes. Error code 0x000006be](http://social.technet.microsoft.com/Forums/en-US/itprovistaprinting/thread/3e47b7b6-00a3-47e1-9e28-e615fbff5f87/)

