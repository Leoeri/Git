cls
$DefaultPath = "C:\Users\leoer\Desktop\Powershell"
for($i = 1; $i -lt 2; $i++){
    New-VM -Name Windows10.$i -MemoryStartupBytes 4GB -BootDevice VHD -NewVHDPath "$DefaultPath\VMhd\Windows10.$i.vhdx" -Path "$DefaultPath" -NewVHDSizeBytes 60GB -Generation 2 -Switch LAN
    Add-VMScsiController -VMName Windows10.$i
    Get-VM Windows10.$i | Add-VMDvdDrive -Controllernumber 1 -Path "$DefaultPath\Windows10.iso"
    $DVDDrive = Get-VMDvdDrive -VMName Windows10.$i
    Set-VMFirmware -VMName Windows10.$i -FirstBootDevice $DVDDrive
}
"done"