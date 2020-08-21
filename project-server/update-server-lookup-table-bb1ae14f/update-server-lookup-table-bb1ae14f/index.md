# Update Project Server 2010 / 2013 Lookup table with values from a text fil

## Original Links

- [x] Original Technet URL [Update Project Server 2010 / 2013 Lookup table with values from a text fil](https://gallery.technet.microsoft.com/Update-Server-Lookup-table-bb1ae14f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Update-Server-Lookup-table-bb1ae14f/description)
- [x] Download: [Download Link](Download\Update Project Server lookup table.ps1)

## Output from Technet Gallery

This PowerShell script will add lookup table values from a text file into the specified lookup table. This script does assume that the lookup table values are all level 1. The values to add will need to be in a list in a text file, an example can be found on the blog post link below. There are a couple of variables / lines that will need to be updated in the script, these are menitoned below but detailed in the blog post.

- Text file location and filename, in the example below you will see "C:\Lookupvaluestoadd.txt"

- The lookup table that you want to update, in the example below you will see "Test Lookup Table"

- The Project Server PWA URL, in the example below you will see http://vm353/pwa

- The language (Locale ID) might also need to be updated, in this examplee you will find 1033

Once these have been updated the script will be ready to execute, I'd recommend running this with a Project Server administrator account as the user acount will need permission to manage enterprise custom fields.

Please see a code snippet below:

```
#Get lookup table values to add
$values = Get-Content "C:\Lookupvaluestoadd.txt"
#Specify Lookup table to update
$lookupTablename = "Test Lookup Table"
$EPMTYString = [system.string]::empty
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwa/_vti_bin/PSI/LookupTable.asmx?wsdl" -useDefaultCredential
$lookupTables = $svcPSProxy.ReadLookupTables($EPMTYString, 0 , 1033)
$lookupTableGuid = $Lookuptables.LookupTables  | where {$_.LT_NAME -eq $Lookuptablename }
$lookuptable = $svcPSProxy.ReadLookupTablesbyUids($lookupTableGuid.LT_UID, 1 , 1033)
#get lookup table count
$lookuptableValues = $svcPSProxy.ReadLookupTablesbyUids($lookupTableGuid.LT_UID, 0 , 1033).LookupTableTrees
$count = $lookuptableValues.Count +1
#update lookup table...
foreach($value in $values)
    {
        $GUID = [System.Guid]::NewGuid()
        $LookupRow = $lookuptable.LookupTableTrees.NewLookupTableTreesRow()
        $LookupRow.LT_STRUCT_UID = $GUID
        $LookupRow.LT_UID = $lookupTableGuid.LT_UID
        $LookupRow.LT_VALUE_TEXT = $value
        $LookupRow.LT_VALUE_SORT_INDEX =  ($count ++)
        $lookuptable.LookupTableTrees.AddLookupTableTreesRow($LookupRow)
    }
$error.clear()
Try
    {
        $svcPSProxy.UpdateLookupTables($lookuptable , 0 , 1 , 1033)
    }
Catch
    {
        write-host "Error updating the Lookup table, see the error below:" -ForeGroundColor Red -BackGroundColor White
        write-host "$error" -ForeGroundColor Red
    }
If ($error.count -eq 0)
    {
        Write-host "The lookup table $lookupTablename has been updated with the values from the text file specified" -ForeGroundColor Green
    }
Else
    {
        Write-host "The lookup table $lookupTablename has not been updated with the values from the text file specified, please see error" -ForeGroundColor Red -BackGroundColor White
    }
#force checkin in case of failure
$error.clear()
Try
    {
     $svcPSProxy.CheckInLookUpTables($lookupTableGuid.LT_UID, 1)
    }
Catch
    {
        If ($error -match "LastError=CICONotCheckedOut")
            {
            }
        Else
        {
            write-host "Error checking the Lookup table, see the error below:" -ForeGroundColor Red -BackGroundColor White
            write-host "$error" -ForeGroundColor Red
        }
    }
```

For an example walkthrough using this script please see the following blog post:

http://pwmather.wordpress.com/2012/08/29/update-projectserver-lookup-tables-using-powershell-ps2010-sp2010-msproject/

