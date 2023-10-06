$DefaultPath = "C:\Users\leoer\Desktop\Powershell"
New-VM -Name AD-Lab -MemoryStartupBytes 4GB -BootDevice VHD -NewVHDPath "$DefaultPath\VMhd\AD-Lab.vhdx" -Path "$DefaultPath" -NewVHDSizeBytes 60GB -Generation 2 -Switch LAN
Add-VMScsiController -VMName AD-Lab
Get-VM AD-Lab | Add-VMDvdDrive -Controllernumber 1 -Path "$DefaultPath\Server2022.iso"
$DVDDrive = Get-VMDvdDrive -VMName AD-Lab
Set-VMFirmware -VMName AD-Lab -FirstBootDevice $DVDDrive