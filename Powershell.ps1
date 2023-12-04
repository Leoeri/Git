cls
$powershell = Test-Path -Path C:\Users\leoer\Desktop\Powershell

if($powershell -eq $false){
New-Item -ItemType Directory -Name "Powershell" -Path C:\Users\leoer\Desktop\
for ($i = 1; $i -le 3; $i++)
{
    New-Item -ItemType Directory -Path C:\Users\leoer\Desktop\Powershell\P$i
}
New-Item -ItemType File -Path C:\Users\leoer\Desktop\powershell\Hello_powershell.txt
"Powershell is the best" | Out-File C:\Users\leoer\Desktop\Powershell\Hello_powershell.txt
"Powershell Forever" | Out-File C:\Users\leoer\Desktop\Powershell\Hello_powershell.txt -Append 

"Folder created"
}
else{
    "Folder already exists"
}
"done"