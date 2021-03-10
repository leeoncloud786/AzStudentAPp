Param (
    [string]$user,
    [string]$password,
    [string]$sqlserver,
    [string]$dbName
)
$xmlDocument = New-Object XML
$path = "C:\inetpub\wwwroot\TruBI\Web.config"
$xmlDocument.Load($path)
$targetNode = $XmlDocument.SelectSingleNode("//configuration/connectionStrings/add[@name='nSightsMasterEntities']")
if($null -ne $targetNode)
{
   Write-Host "Target: $($targetNode.Name) being set to $($setting.connectionString)"
   $targetNode.connectionString = "metadata=res://*/EFMasters.nSightsMasters.csdl|res://*/EFMasters.nSightsMasters.ssdl|res://*/EFMasters.nSightsMasters.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=$sqlserver;initial catalog=$dbName;persist security info=True;user id=$User;password=$password;MultipleActiveResultSets=True;App=EntityFramework&quot;"
}   
Write-Host "nSightsMasterEntities - " $targetNode.connectionString

$targetNode = $XmlDocument.SelectSingleNode("//configuration/connectionStrings/add[@name='OwinAuthDbContext']")
if($null -ne $targetNode)
{
   Write-Host "Target: $($targetNode.Name) being set to $($setting.connectionString)"

   $targetNode.connectionString = "Data Source=$sqlserver;Initial Catalog=$dbName;Persist Security Info=True;User ID=$User;Password=$password"
} 

#Write-Host "User" $user "password" $password "servername" $sqlserver
Write-Host "OwinAuthDbContext - " $targetNode.connectionString
$xmlDocument.Save($path)