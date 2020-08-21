#============================================================================================================================#
#                                                                                                                            #
#  RICOH-MFP-AB.psm1                                                                                                         #
#  Ricoh Multi Function Printer (MFP) Address Book PowerShell Module                                                         #
#  Author: Alexander Krause                                                                                                  #
#  Contributor: Darren Kattan                                                                                                #
#  Creation Date: 10.04.2013                                                                                                 #
#  Modified Date: 10.11.2017                                                                                                 #
#  Version: 2.0.0                                                                                                            #
#                                                                                                                            #
#============================================================================================================================#

function ConvertTo-Base64
{
param($String)
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($String))
}

$global:SessionID = $null

Function ConvertTo-RicohItemList 
{
    param($xml, $HashTable)
    
    $HashMembers = (new-object psobject -property $HashTable | Get-Member -MemberType NoteProperty) | select -ExpandProperty name
    foreach($Member in $HashMembers)
    {
        $a = $xml.CreateElement("item")
        $a.set_InnerText("")
        $b = $xml.CreateElement("propName")
        $b.set_InnerText($Member)
        $o = $a.AppendChild($b)
        $c = $xml.CreateElement("propVal")
        $c.set_InnerText($HashTable."$Member")
        $o = $a.AppendChild($c)
    }
    return $a
}

function Connect-MFP
{
param($Hostname,$Authentication,$Username="admin",$Password="",$SecurePassword)
$url = "http://$Hostname/DH/udirectory"
$login = [xml]@'
<?xml version="1.0" encoding="utf-8" ?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
 <s:Body>
  <m:startSession xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
   <stringIn></stringIn>
   <timeLimit>30</timeLimit>
   <lockMode>X</lockMode>
  </m:startSession>
 </s:Body>
</s:Envelope>
'@
    if($SecurePassword -eq $NULL){$pass = ConvertTo-Base64 $Password}else{$pass = $SecurePassword; $enc = "gwpwes003"}
    $login.Envelope.Body.startSession.stringIn = "SCHEME="+(ConvertTo-Base64 $Authentication)+";UID:UserName="+(ConvertTo-Base64 $Username)+";PWD:Password=$pass;PES:Encoding=$enc"
    [xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#startSession"} -Body $login
    if($xml.Envelope.Body.startSessionResponse.returnValue -eq "OK")
    {
        $Script:Hostname = $Hostname
        $script:session = $xml.Envelope.Body.startSessionResponse.stringOut
    }
}

function Search-MFPAB
{
$url = "http://$Script:Hostname/DH/udirectory"
$search = [xml]@'
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
 <s:Body>
  <m:searchObjects xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
    <sessionId></sessionId>
   <selectProps xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.w3.org/2001/XMLSchema" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" soap-enc:arrayType="itt:string[1]">
    <item>id</item>
   </selectProps>
    <fromClass>entry</fromClass>
    <parentObjectId></parentObjectId>
    <resultSetId></resultSetId>
   <whereAnd xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" soap-enc:arrayType="itt:queryTerm[1]">
    <item>
     <operator></operator>
     <propName>all</propName>
     <propVal></propVal>
     <propVal2></propVal2>
    </item>
   </whereAnd>
   <whereOr xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" soap-enc:arrayType="itt:queryTerm[1]">
    <item>
     <operator></operator>
     <propName></propName>
     <propVal></propVal>
     <propVal2></propVal2>
    </item>
   </whereOr>
   <orderBy xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/udirectory" soap-enc:arrayType="itt:queryOrderBy[1]">
    <item>
     <propName></propName>
     <isDescending>false</isDescending>
    </item>
   </orderBy>
    <rowOffset>0</rowOffset>
    <rowCount>50</rowCount>
    <lastObjectId></lastObjectId>
   <queryOptions xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" soap-enc:arrayType="itt:property[1]">
    <item>
     <propName></propName>
     <propVal></propVal>
    </item>
   </queryOptions>
  </m:searchObjects>
 </s:Body>
</s:Envelope>
'@
$search.Envelope.Body.searchObjects.sessionId = $script:session
[xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#searchObjects"} -Body $search
$xml.SelectNodes("//rowList/item") | %{$_.item.propVal} | ?{$_.length -lt "10"} | %{[int]$_} | sort
}

function Get-MFPAB
{
param($ScriptID=$script:session)
$url = "http://$Script:Hostname/DH/udirectory"
$get = [xml]@'
<?xml version="1.0" encoding="utf-8" ?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
 <s:Body>
  <m:getObjectsProps xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
   <sessionId></sessionId>
  <objectIdList xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.w3.org/2001/XMLSchema" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="">
  </objectIdList>
  <selectProps xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.w3.org/2001/XMLSchema" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="itt:string[7]">
   <item>entryType</item>
   <item>id</item>
   <item>index</item>
   <item>name</item>
   <item>longName</item>
   <item>auth:name</item>
   <item>mail:address</item>
  </selectProps>
   <options xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="itt:property[1]">
    <item>
     <propName></propName>
     <propVal></propVal>
    </item>
   </options>
  </m:getObjectsProps>
 </s:Body>
</s:Envelope>
'@
$get.Envelope.Body.getObjectsProps.sessionId = $script:session
Search-MFPAB | %{
$x = $get.CreateElement("item")
$x.set_InnerText("entry:$_")
$o = $get.Envelope.Body.getObjectsProps.objectIdList.AppendChild($x)
}
$get.Envelope.Body.getObjectsProps.objectIdList.arrayType = "itt:string["+$get.Envelope.Body.getObjectsProps.objectIdList.item.count+"]"
try
{
    [xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#getObjectsProps"} -Body $get
    $xml.SelectNodes("//returnValue/item") | %{
    New-Object PSObject -Property @{
       EntryType = (%{$_.item} | ?{$_.propName -eq "entryType"}).propVal
       ID        = [int](%{$_.item} | ?{$_.propName -eq "id"}).propVal
       Index     = [int](%{$_.item} | ?{$_.propName -eq "index"}).propVal
       Name      = (%{$_.item} | ?{$_.propName -eq "name"}).propVal
       LongName  = (%{$_.item} | ?{$_.propName -eq "longname"}).propVal
       UserCode  = (%{$_.item} | ?{$_.propName -eq "auth:name"}).propVal
       Mail      = (%{$_.item} | ?{$_.propName -eq "mail:address"}).propVal
    }} | sort Index
}
catch
{
  Write-Warning "Error retrieving address book. This could be because it is empty."
}
}

function Add-MFPAB
{
param($SessionID=$script:session,$EntryType="user",$Index,$Name,$LongName,$UserCode,[bool]$IsDestination=$true,[bool]$IsSender=$false,$MailAddress,[bool]$Folder,$FolderPath)
$url = "http://$script:Hostname/DH/udirectory"
$add = [xml]@'
<?xml version="1.0" encoding="utf-8" ?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
 <s:Body>
  <m:putObjects xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
   <sessionId></sessionId>
   <objectClass>entry</objectClass>
   <parentObjectId></parentObjectId>
   <propListList xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="">
    <item xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="itt:property[7]">
     <item>
      <propName>entryType</propName>
      <propVal></propVal>
     </item>
     <item>
      <propName>name</propName>
      <propVal></propVal>
     </item>
     <item>
      <propName>longName</propName>
      <propVal></propVal>
     </item>     
    </item>
   </propListList>
  </m:putObjects>
 </s:Body>
</s:Envelope>
'@
$add.Envelope.Body.putObjects.sessionId = $script:session
$add.Envelope.Body.putObjects.propListList.item.item[0].propVal = $EntryType
$add.Envelope.Body.putObjects.propListList.item.item[1].propVal = $Name
$add.Envelope.Body.putObjects.propListList.item.item[2].propVal = $LongName

$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"isDestination"=$IsDestination.ToString().ToLower()} -xml $add)) | Out-Null
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"isSender"=$IsSender.ToString().ToLower()} -xml $add)) | Out-Null
if($Index -ne $NULL){
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"index"=$Index} -xml $add)) | Out-Null
}

if($UserCode){
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"auth:name"=$UserCode} -xml $add)) | Out-Null
}
if($MailAddress){
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"mail:"=$true.ToString().ToLower()} -xml $add)) | Out-Null
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"mail:address"=$MailAddress} -xml $add)) | Out-Null
}
if($FolderPath)
{
$add.Envelope.Body.putObjects.propListList.item.AppendChild((ConvertTo-RicohItemList -HashTable @{"remoteFolder:path"=$FolderPath} -xml $add)) | Out-Null
}

$add.Envelope.Body.putObjects.propListList.arrayType = "itt:string[]["+$add.Envelope.Body.putObjects.propListList.item.item.count+"]"
[xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#putObjects"} -Body $add
}

function Remove-MFPAB
{
param($SessionID=$script:session,$ID)
$url = "http://$Script:Hostname/DH/udirectory"
$remove = [xml]@'
<?xml version="1.0" encoding="utf-8" ?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
 <s:Body>
  <m:deleteObjects xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
   <sessionId></sessionId>
  <objectIdList xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.w3.org/2001/XMLSchema" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="">
  </objectIdList>
   <options xmlns:soap-enc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:itt="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:type="soap-enc:Array" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="http://www.ricoh.co.jp/xmlns/schema/rdh/commontypes" xsi:arrayType="itt:property[1]">
    <item>
     <propName></propName>
     <propVal></propVal>
    </item>
   </options>
  </m:deleteObjects>
 </s:Body>
</s:Envelope>
'@
$remove.Envelope.Body.deleteObjects.sessionId = $script:session
$ID | %{
$x = $remove.CreateElement("item")
$x.set_InnerText("entry:$_")
$o = $remove.Envelope.Body.deleteObjects.objectIdList.AppendChild($x)
}
$remove.Envelope.Body.deleteObjects.objectIdList.arrayType = "itt:string["+$remove.Envelope.Body.deleteObjects.objectIdList.item.count+"]"
[xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#deleteObjects"} -Body $remove
return $xml
}

function Disconnect-MFP
{
$url = "http://$script:Hostname/DH/udirectory"
$logout = [xml]@'
<?xml version="1.0" encoding="utf-8" ?>
 <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <s:Body>
   <m:terminateSession xmlns:m="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory">
    <sessionId></sessionId>
   </m:terminateSession>
  </s:Body>
 </s:Envelope>
'@
$logout.Envelope.Body.terminateSession.sessionId = $script:session
[xml]$xml = iwr $url -Method Post -ContentType "text/xml" -Headers @{SOAPAction="http://www.ricoh.co.jp/xmlns/soap/rdh/udirectory#terminateSession"} -Body $logout
$script:session = $null
$script:hostname = $null
}

Export-ModuleMember Get-MFPAB,Add-MFPAB,Remove-MFPAB,Connect-MFP,Disconnect-MFP