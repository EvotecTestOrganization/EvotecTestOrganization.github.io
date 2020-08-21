# Add Project Server Users to Project Server Group using PowerShell

## Original Links

- [x] Original Technet URL [Add Project Server Users to Project Server Group using PowerShell](https://gallery.technet.microsoft.com/Add-Server-Users-to-Server-40aed317)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Add-Server-Users-to-Server-40aed317/description)
- [x] Download: [Download Link](Download\AddPSUsersToProjectGroup.ps1)

## Output from Technet Gallery

Based on the insights of Paul Mather (Modify lookup tables:https://gallery.technet.microsoft.com/scriptcenter/Update-Server-Lookup-table-bb1ae14f) I created a PowerShell function to add users (from file with UIDs of resources, one UID per line) to a Project Server Group (indentified by its UID).

I tested it with Project Server 2013, but it probably works also with other versions.

Just edit the following parameters before starting the script:

$pwaURL = URL to your PWA instance

$sGroupUID = UID of the Project Server Group

$sUserToAdd = link to text file with RES\_UID entries

Have fun using it,

Trutz-Sebastian Stephani

Campana & Schott

http://www.campana-schott.com

PowerShell

```
function Add-PSUsersToProjectServerGroup
{
    param ($pwaUrl, $sGroupUID,$sUserToAdd)
    try {
        #Get RES_UID values to add
        $values = Get-Content $sUserToAdd
        $svcPSProxy = New-WebServiceProxy -uri "$pwaUrl/_vti_bin/PSI/Security.asmx?wsdl" -UseDefaultCredential
        $secGroup = $svcPSProxy.ReadGroup($sGroupUID)
        foreach($value in $values)
            {
                $secGroupRow = $secGroup.GroupMembers.NewGroupMembersRow()
                $secGroupRow.RES_UID = [System.Guid] $value
                $secGroupRow.WSEC_GRP_UID = $sGroupUID
                $secGroup.GroupMembers.AddGroupMembersRow($secGroupRow)
            }
        $error.clear()
        Try
            {
                $svcPSProxy.SetGroups($secGroup)
            }
        Catch
            {
                write-host "Error updating the group, see the error below:" -ForeGroundColor Red -BackGroundColor White
                write-host "$error" -ForeGroundColor Red
            }
        If ($error.count -eq 0)
        {
                Write-host "The group $sGroupUID has been updated with the values from the text file specified" -ForeGroundColor Green
            }
        Else
            {
                Write-host "The group $sGroupUID has not been updated with the values from the text file specified, please see error" -ForeGroundColor Red -BackGroundColor White
            }
        $error.clear()
    }
        catch [System.Exception]
    {
        write-host -f red $_.Exception.ToString()
    }
}
#Required Parameters
$pwaUrl = "<PWA URL>"
$sGroupUID="<Group UID, e.g. a6d72f6e-820b-e511-9424-00155d0a0c10"
$sUserToAdd = ".\UserUIDs.txt"
Add-PSUsersToProjectServerGroup -pwaUrl $pwaUrl -sGroupUID $sGroupUID -sUserToAdd $sUserToAdd
```

