cls
for($i = 1; $i -lt 3; $i++){
    Stop-VM Fil0$i
    Remove-VM Fil0$i -Force -Confirm:$false
    Remove-Item C:\Users\leoer\Desktop\Powershell\Windows10.$i -Recurse -Force -Confirm:$false
    Get-ChildItem C:\users\leoer\desktop\powershell\VMhd | Remove-Item 
}
"done"