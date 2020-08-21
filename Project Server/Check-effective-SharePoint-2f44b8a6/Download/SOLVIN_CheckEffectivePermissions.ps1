#Please modify lines 23, 30 and 40 as needed
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server")
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.Office.Server.UserProfiles")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Web")
Add-PSSnapin Microsoft.SharePoint.Powershell
function GetHelp() {
   
   
$HelpText = @"
   
DESCRIPTION:
This Script will check for the SharePoint permissions of PWA users. PWA users are specified in a SQL query (member of group having name like xxxx)
"@
$HelpText
   
}
   
function CheckEffectivePermissions() {

$connection= new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database 
#####modify the connection string as needed:
$connection.ConnectionString ="server=SQLSERVERNAME;database=ProjectWebApp_DB;trusted_connection=True" # Connectiongstring setting for local machine database with window authentication 
Write-host "connection information:" 
$connection #List connection information 
Write-host "connect to database successful." 
$connection.open() #Connecting successful  
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands 
#####modify this query as necessary
$SqlQuery = "select sc.ENCODED_CLAIM from pub.MSP_WEB_SECURITY_CLAIMS sc inner join pub.MSP_WEB_SECURITY_GROUP_MEMBERS sgm on sc.SECURITY_GUID =sgm.WRES_GUID inner join pub.MSP_WEB_SECURITY_GROUPS sg on sg.WSEC_GRP_GUID=sgm.WSEC_GRP_GUID where sg.WSEC_GRP_NAME like '%Projectmanager%'"  
$SqlCmd.CommandText = $SqlQuery # get query 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter # 
$SqlAdapter.SelectCommand = $SqlCmd
$SqlCmd.Connection = $connection 
$DataSet = New-Object System.Data.DataSet 
$SqlAdapter.Fill($DataSet)  
$connection.Close() 

#####enter the URL here
$url="URL of PWA site here"
$site=get-spsite $url
$serverContext = [Microsoft.Office.Server.ServerContext]::GetContext($site)

$web=get-spweb $url 
foreach ($row in $DataSet.Tables[0])
{
$userlogin=$row[0]
$permissionInfo = $web.GetUserEffectivePermissionInfo($userLogin)
$roles = $permissionInfo.RoleAssignments
write-host "Now checking the permissions of the user "  $userLogin  " " "in the site " $web.Url
if ($roles.count -eq 0)
  {write-host "The User " $userlogin " does not have any permissions in this web"}
for ($i = 0; $i -lt $roles.Count; $i++)
{
$bRoles = $roles[$i].RoleDefinitionBindings
foreach ($roleDefinition in $bRoles)
{
 if ($roles[$i].Member.ToString().Contains('\'))
{
write-host "The User "  $userLogin  " has direct permissions "  $roleDefinition.Name
}
else
{
write-host "The User "  $userLogin  " has permissions "  $roleDefinition.Name  " given via "  $roles[$i].Member.ToString()
                                }
}
}
}
$site.Dispose()
}
   
if($help) { GetHelp; Continue }
else { CheckEffectivePermissions }
