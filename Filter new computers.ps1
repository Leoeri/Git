Enter-PSSession -vmname Filserver

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

$i = 0
$names = Get-ADcomputer -filter * | Foreach {$_.name}
$existingnames = Get-Content -Path C:\datorer.txt
$names
foreach($name in $names)
{
    if($name -ne ($existingnames[$i])){
        Invoke-Command -ComputerName "$name" -scriptblock{
            
        $job = Start-Job { Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) }
        Wait-Job $job
        Receive-Job $job
        choco feature enable -n allowGlobalConfirmation
        $job = Start-Job { choco install 7zip --version 23.1.0 -y --force }
        Wait-Job $job
        Receive-Job $job
        }
        $name | Out-File -FilePath C:\datorer.txt -Append
    }
    $($existingnames[$i])
   $i = $i+1
}

$names | Out-file -filepath C:\datorer.txt -Append
$existingnames[1]