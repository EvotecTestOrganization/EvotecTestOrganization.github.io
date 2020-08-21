#add SharePoint Online DLL - update the location if required
$programFiles = [environment]::getfolderpath("programfiles")
add-type -Path $programFiles'\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll'

#get the environment details
$PWAInstanceURL = Read-Host "what is the pwa url?"
$PWAUserName = Read-Host "what is the pwa username?" 
$PWAUserPassword = Read-Host -AsSecureString "what is the pwa password?"
$startDate = Read-Host "enter the period start date in the following format yyyy-mm-dd"
$finishDate = Read-Host "enter the period finish date in the following format yyyy-mm-dd"
$fileName = 'TimesheetExport_' + $startDate + '_to_ ' + $finishDate

$results1 = @()

#set the Odata URL
$url = $PWAInstanceURL + "/_api/ProjectData/TimesheetLineActualDataSet()?`$Filter=TimeByDay ge datetime'$startDate' and TimeByDay le datetime'$finishDate'&`$Select=ResourceName,TimeByDay,ActualWorkBillable,ActualOvertimeWorkBillable"

#check for Project Online or Project Server then get the data
if ($PWAInstanceURL -like "*SharePoint.com*")
{
    while ($url){
    [Microsoft.SharePoint.Client.SharePointOnlineCredentials]$spocreds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($PWAUserName, $PWAUserPassword);    
    $webrequest = [System.Net.WebRequest]::Create($url)
    $webrequest.Credentials = $spocreds
    $webrequest.Accept = "application/json;odata=verbose"
    $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
    $response = $webrequest.GetResponse()
    $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
    $data = $reader.ReadToEnd()
    $results = ConvertFrom-Json -InputObject $data
    $results1 += $results.d.results
    if ($results.d.__next){
        $url=$results.d.__next.ToString()
    }
    else {
        $url=$null
    }
}

    $results1  | select ResourceName, TimeByDay, ActualWorkBillable, ActualOvertimeWorkBillable | sort TimeByDay, ResourceName | Format-Table -AutoSize
    $results1  | select ResourceName, TimeByDay, ActualWorkBillable, ActualOvertimeWorkBillable | sort TimeByDay, ResourceName | Export-Csv -Path "$fileName.csv" -NoTypeInformation
}
else
{

    while ($url){
    $spcreds = New-Object System.Management.Automation.PsCredential $PWAUserName,$PWAUserPassword
    $webrequest = [System.Net.WebRequest]::Create($url)
    $webrequest.Credentials = $spcreds
    $webrequest.Accept = "application/json;odata=verbose"
    $webrequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
    $response = $webrequest.GetResponse()
    $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
    $data = $reader.ReadToEnd()
    $results = ConvertFrom-Json -InputObject $data
    $results1 += $results.d.results
    if ($results.d.__next){
        $url=$results.d.__next.ToString()
    }
    else {
        $url=$null
    }
}

    $results1  | select ResourceName, TimeByDay, ActualWorkBillable, ActualOvertimeWorkBillable | sort TimeByDay, ResourceName | Format-Table -AutoSize
    $results1  | select ResourceName, TimeByDay, ActualWorkBillable, ActualOvertimeWorkBillable | sort TimeByDay, ResourceName | Export-Csv -Path "$fileName.csv" -NoTypeInformation
}