#Get lookup table values to add
$values = Get-Content "C:\Lookupvaluestoadd.txt"
#Specify Lookup table to update 
$lookupTablename = "Test Lookup Table"
$EPMTYString = [system.string]::empty
$svcPSProxy = New-WebServiceProxy -uri "http://vm353/pwa/_vti_bin/PSI/LookupTable.asmx?wsdl" -useDefaultCredential
$lookupTables = $svcPSProxy.ReadLookupTables($EPMTYString, 0 , 1033)
$lookupTableGuid = $Lookuptables.LookupTables  | where {$_.LT_NAME -eq $Lookuptablename }
$lookuptable = $svcPSProxy.ReadLookupTablesbyUids($lookupTableGuid.LT_UID, 1 , 1033)
#get lookup table count
$lookuptableValues = $svcPSProxy.ReadLookupTablesbyUids($lookupTableGuid.LT_UID, 0 , 1033).LookupTableTrees
$count = $lookuptableValues.Count +1
#update lookup table...

foreach($value in $values)
    {
        $GUID = [System.Guid]::NewGuid()
        $LookupRow = $lookuptable.LookupTableTrees.NewLookupTableTreesRow()
        $LookupRow.LT_STRUCT_UID = $GUID
        $LookupRow.LT_UID = $lookupTableGuid.LT_UID
        $LookupRow.LT_VALUE_TEXT = $value
        $LookupRow.LT_VALUE_SORT_INDEX =  ($count ++)
        $lookuptable.LookupTableTrees.AddLookupTableTreesRow($LookupRow)
    }
$error.clear()
Try
    {
        $svcPSProxy.UpdateLookupTables($lookuptable , 0 , 1 , 1033)
    }
Catch 
    {
        write-host "Error updating the Lookup table, see the error below:" -ForeGroundColor Red -BackGroundColor White
        write-host "$error" -ForeGroundColor Red
    }
If ($error.count -eq 0)
    {
        Write-host "The lookup table $lookupTablename has been updated with the values from the text file specified" -ForeGroundColor Green
    }
Else
    {
        Write-host "The lookup table $lookupTablename has not been updated with the values from the text file specified, please see error" -ForeGroundColor Red -BackGroundColor White
    }
#force checkin in case of failure
$error.clear()
Try
    {
     $svcPSProxy.CheckInLookUpTables($lookupTableGuid.LT_UID, 1)
    }
Catch 
    {
        If ($error -match "LastError=CICONotCheckedOut")
            {
    
            }
        Else
        {
            write-host "Error checking the Lookup table, see the error below:" -ForeGroundColor Red -BackGroundColor White
            write-host "$error" -ForeGroundColor Red
        }
    }