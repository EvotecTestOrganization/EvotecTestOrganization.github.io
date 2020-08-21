# VB script to Display the shared printer information

## Original Links

- [x] Original Technet URL [VB script to Display the shared printer information](https://gallery.technet.microsoft.com/ae3f7fe1-8390-4aae-bbe9-c117da976398)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ae3f7fe1-8390-4aae-bbe9-c117da976398/description)
- [x] Download: Not available.

## Output from Technet Gallery

## Description

Password hash and salt values should always be securely protected in storage. An attacker able to compromise a specific hash and salt value from a database may succeed in using other types of brute-force attacks against the compromised hash.

In the example given, the four-byte salt would require an attacker to maintain 4.3 trillion values for every given plaintext value. Assuming the victim required passwords of only 4 alphabetical characters in length with no other complexity requirements (a  very weak password policy by our standards), defeating a four-byte salt would require the attacker to have a database of 2 x 10^15 precomputed hashes handy. Assuming each of these hashes only required one byte to store, this would require 2 petabytes of storage.

## Script

Visual Basic

```
'Auther- Biswajit Das.
' Target Platform windows 2008 r2, windows 2003.
' parameters - none.
'Dependency - WMI class should be present.
Set objNetwork = CreateObject("Wscript.Network")
    strComputer = objNetwork.ComputerName
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
Set colItems = objWMIService.ExecQuery( _
    "SELECT * FROM Win32_PrinterShare",,48)
    WScript.Echo " Following printers are shared.."
For Each objItem in colItems
    'Wscript.Echo "Antecedent: " & objItem.Antecedent
    share_name=Replace(objItem.Dependent,"\\"&strComputer&"\root\cimv2:Win32_Share.Name=","")
    share_name=Replace(share_name,Chr(34),"")
    Wscript.Echo " " & share_name
Next
```

