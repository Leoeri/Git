#En räknare som används för array index
$number = 0
#Vad domänet heter 
$domain = "nils.se"
#Vad servern som delar shared folder ska ligga
$servernamn ="AD"
#Vart shared folder mappen ska ligga
$root = "C"
#Alla mappar som ska skapas
$folders = "Ledning", "Sälj", "Verkstad", "Ekonomi", "IT", "Public"
#Alla säkerhetsgrupper
$Groups = "Ledning", "Sälj", "Verkstad", "Ekonomi","IT"
#Skapar nya mappar
foreach($folder in $folders){
New-Item -ItemType Directory -Path "$($root):\Shared\$folder"
}

#Tar bort inheritance från alla delade filer
foreach($Folder in $Folders){
$folder = "C:\Shared\$folder"
$acl = Get-ACL -Path $folder
$acl.SetAccessRuleProtection($True, $False)
Set-Acl -Path $folder -AclObject $acl
}

#Lägger till NTFS rättigheter till alla delade filer
foreach ($group in $groups){
$identity = "NILS\Sec-$group"
$rights = 'Fullcontrol' 
$inheritance = 'ContainerInherit, ObjectInherit'
$propagation = 'None'
$type = 'Allow'
$ACE = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)

$path = "C:\Shared\$($folders[$number])"  
$acl = Get-Acl $path  
$acl.SetAccessRule($ACE)  
$acl | Set-Acl $path  

$number = $number + 1

$number = 0
}
foreach ($group in $groups){
$identity = "NILS\Sec-Ledning"
$rights = 'Fullcontrol' 
$inheritance = 'ContainerInherit, ObjectInherit'
$propagation = 'None'
$type = 'Allow'
$ACE = New-Object System.Security.AccessControl.FileSystemAccessRule($identity,$rights,$inheritance,$propagation, $type)

$path = "C:\Shared\$($folders[$number])"  
$acl = Get-Acl $path  
$acl.SetAccessRule($ACE)  
$acl | Set-Acl $path  

$number = $number + 1
}

$number = 0
#Tar bort rättigheter från domain users 
foreach ($group in $groups){
$path = "C:\Shared\$($folders[$number])"  
$acl = Get-Acl $path  
$ACE = $ACL.Access | Where-Object {$_.identityReference -eq "Builtin\Users" -and $_.fileSystemRights -like "*ReadandExecute*"}
$ACL.RemoveAccessRule($ACE)
Set-ACL $path -AclObject $ACL
$number = $number + 1
}
#Nollställer en räknare
$number = 0
#Ta bort rättigheter från domain users
foreach ($group in $groups){
$path = "C:\Shared\$($folders[$number])"
$ACL = Get-Acl $path
$Ace = $Acl.Access | Where-Object {$_.IdentityReference -eq 'builtin\Users'}
$ACL.RemoveAccessRule($Ace)
Set-Acl $path -AclObject $ACL
$number = $number + 1
}
#Dela shared folder med namnet Shared
New-SmbShare -Name Shared -path "$($root):\Shared" -FullAccess "Everyone"
#Installera DFS namespace på servern
install-windowsFeature -name FS-DFS-Namespace -IncludeManagementTools
#Skap DFS namespace med domänet
new-DFsnroot -targetpath "\\$servernamn\Shared" -Type "domainV2" -path "\\$domain\Shared" 
#Lägga till Access based enumeration på Namespacet
set-dfsnroot -path "\\Nils.se\Shared" -EnableAccessBasedEnumeration $true