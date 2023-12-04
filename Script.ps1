$path = test-path C:\programdata\Chocolatey

if($path -eq $false){
$job = Start-Job {Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}
Wait-Job $job
Receive-Job $job

$job = Start-Job {choco feature enable -n allowGlobalConfirmation}
Wait-Job $job
Receive-Job $job
}

$packages = Choco list
$adobe = test-path C:\programdata\chocolatey\lib\adobereader
$chrome = test-path C:\programdata\chocolatey\lib\GoogleChrome
$edge = test-path C:\programdata\chocolatey\lib\microsoft-edge
$zoom = test-path C:\programdata\chocolatey\lib\zoom
$Teams = test-path C:\programdata\chocolatey\lib\microsoft-teams.install
$Zip = test-path C:\programdata\chocolatey\lib\7zip.install
$Teamviewer = test-path C:\programdata\chocolatey\lib\teamviewer

$Filestoinstall = "Adobe","Chrome","Edge","Zoom","Teams","Zip","Teamviewer"

<##>
Foreach($file in $Filestoinstall){

    if($zip -eq $false){
        $job = Start-Job { choco install 7zip.install --version 23.1.0 -y --force }
        Wait-Job $job
        Receive-Job $job
    }

        if($adobe -eq $false){
            $job = Start-Job { choco install adobereader --version 2023.6.20360 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($chrome -eq $false){
            $job = Start-Job { choco install googlechrome --version 119.0.6045.124 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($edge -eq $false){
            $job = Start-Job { choco install microsoft-edge --version 119.0.2151.44 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($zoom -eq $false){
            $job = Start-Job { choco install zoom --version 5.16.6.24712 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($teams -eq $false){
            $job = Start-Job { choco install microsoft-teams.install --version 1.6.0.27573 -y --force }
            Wait-Job $job
            Receive-Job $job
        }
        if($teamviewer -eq $false){
            $job = Start-Job { choco install teamviewer --version 15.47.3 -y --force }
            Wait-Job $job
            Receive-Job $job
            }
        
    $adobe = test-path C:\programdata\chocolatey\lib\adobereader
    $chrome = test-path C:\programdata\chocolatey\lib\GoogleChrome
    $edge = test-path C:\programdata\chocolatey\lib\microsoft-edge
    $zoom = test-path C:\programdata\chocolatey\lib\zoom
    $Teams = test-path C:\programdata\chocolatey\lib\microsoft-teams.install
    $Zip = test-path C:\programdata\chocolatey\lib\7zip.install
    $Teamviewer = test-path C:\programdata\chocolatey\lib\teamviewer

}