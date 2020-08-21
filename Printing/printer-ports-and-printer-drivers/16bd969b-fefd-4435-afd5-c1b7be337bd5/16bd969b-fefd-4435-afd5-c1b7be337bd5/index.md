# Migrate Printer Connections

## Original Links

- [x] Original Technet URL [Migrate Printer Connections](https://gallery.technet.microsoft.com/16bd969b-fefd-4435-afd5-c1b7be337bd5)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/16bd969b-fefd-4435-afd5-c1b7be337bd5/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Marco Sombroek

Deletes existing printer connections and creates new connections to different print servers.

Visual Basic

```
Break on
If @producttype = 'Windows XP Professional'
 
Dim $printers, $printer, $rc
 
$printers=arrayenumkey('HKCU\Printers\Connections')
 
For Each $printer In $printers
If InStr($printer,'prtsrv01')
                   $printer=Split($printer,',')
                   $old='\\'+$printer[2]+'\'+$printer[3]
                   $new="\\prtsrv02\" + $printer[3]
                   ? '-I- Connection found: '+$old
                   $rc=DelPrinterConnection($old)
                                      If @error
                                                         ? '-E- Error deleting connection to '+$old+' (EC='+@error+')'
                                      Else
                                                         ? '-I- Succesfully deleted connection to '+$old
                                      EndIf
                                      
                   $rc=AddPrinterConnection($new)          
                                      If @ERROR
                                                         ? '-E- Error connecting to '+$new+' (EC='+@error+')'
                                      Else
                                                         ? '-I- Succesfully added connection to '+$new
                                      EndIf
EndIf
 
;Exit
 
;FUNCTION
;
;NAME ArrayEnumKey
;
;ACTION Creates an array of names of the subkeys contained in a registry key or subkey
;
;AUTHOR Jens Meyer (sealeopard@usa.net)
;
;VERSION 1.2 (added error codes)
; 1.1
;
;DATE CREATED 2001/12/05
;
;DATE MODIFIED 2003/05/17
;
;KIXTART 4.12+
;
;SYNTAX ARRAYENUMKEY($subkey)
;
;PARAMETERS SUBKEY
; Required string containing the key or subkey for which the subkeys will be enumerated
;
;RETURNS Array containing the subkeys
;
;REMARKS none
;
;DEPENDENCIES none
;
;EXAMPLE $retcode=arrayenumkey('HKEY_USERS')
;
;KIXTART BBS http://www.kixtart.org/cgi-bin/ultimatebb.cgi?ubb=get_topic&f=12&t=000064
;
Function arrayenumkey($regsubkey)
Dim $retcode, $subkeycounter, $currentsubkey, $subkeyarray
 
If NOT KeyExist($regsubkey)
Exit 87
EndIf
 
$subkeycounter=0
Do
$currentsubkey=EnumKey($regsubkey,$subkeycounter)
If NOT @ERROR
ReDim preserve $subkeyarray[$subkeycounter]
$subkeyarray[$subkeycounter]=$currentsubkey
$subkeycounter=$subkeycounter+1
EndIf
Until @ERROR
 
$arrayenumkey=$subkeyarray
Exit 0
EndFunction
```

