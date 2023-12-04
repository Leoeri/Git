cls
$folder = Test-Path C:\Users\leoer\Desktop\Powershell2
if($folder -eq $false)
{
    Get-ChildItem C:\Users\leoer\Desktop\Powershell | Copy-Item -Destination C:\Users\leoer\Desktop\Powershell2
    "Folder Created"
}
else {
    "Folder Already exists"
}
"done"