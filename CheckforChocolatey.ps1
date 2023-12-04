
if(test-path C:\programdata\Chocolatey -eq $false){
$job = Start-Job {Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}
Wait-Job $job
Receive-Job $job

$job = Start-Job {choco feature enable -n allowGlobalConfirmation}
Wait-Job $job
Receive-Job $job
}

$packages = Choco list--local-only



Foreach($package in $packages){
    if($package -like "Adobe" -or $package -like "Chrome"  -or $package -like "Edge" -or $package -like "Zoom" -or $package -like "Zip" -or $package -like "Teams" -or -$package -like "Teamviewer"){}
    else{
        if($package -notlike "adobe"){
            $job = Start-Job { choco install adobereader -version 2023.6.20360 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($package -notlike "chrome"){
            $job = Start-Job { choco install googlechrome -version 119.0.6045.124 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($package -notlike "edge"){
            $job = Start-Job { choco install microsoft-edge -version 119.0.2151.44 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($package -notlike "zoom"){
            $job = Start-Job { choco install zoom -version 5.16.6.24712 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($package -notlike "Teams"){
            $job = Start-Job { choco install microsoft-teams.install -version 1.6.0.27573 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($package -notlike "Zip"){
        $job = Start-Job { choco install 7zip.install --version 23.1.0 -y --force }
        Wait-Job $job
        Receive-Job $job
        }
        if($package -notlike "TeamViewer"){}
    }
}