cls
$DefaultPath = "C:\Users\leoer\Desktop\Powershell"
for($i = 1; $i -lt 3; $i++){
    New-VM -Name Fil0$i -MemoryStartupBytes 4GB -BootDevice VHD -NewVHDPath "$DefaultPath\VMhd\file0$i.vhdx" -Path "$DefaultPath" -NewVHDSizeBytes 60GB -Generation 2 -Switch LAN
    Add-VMScsiController -VMName Fil0$i
    Get-VM Fil0$i | Add-VMDvdDrive -Controllernumber 1 -Path "$DefaultPath\Server2022.iso"
    $DVDDrive = Get-VMDvdDrive -VMName Fil0$i
    Set-VMFirmware -VMName Fil0$i -FirstBootDevice $DVDDrive
}
"done"