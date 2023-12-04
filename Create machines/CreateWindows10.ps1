cls
#for($i = 1; $i -lt 2; $i++){
New-VM -Name Windows10 -MemoryStartupBytes 4GB -BootDevice VHD -VHDPath "C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\Windows10.vhdx" -Path C:\Users\leoer\Desktop\VM -Generation 2 -Switch LAN
Start-VM Windows10
<#    Add-VMScsiController -VMName Windows10.$i
    Get-VM Windows10.$i | Add-VMDvdDrive -Controllernumber 1 -Path "$DefaultPath\Windows10.iso"
    $DVDDrive = Get-VMDvdDrive -VMName Windows10.$i
   Set-VMFirmware -VMName Windows10.$i -FirstBootDevice $DVDDrive #> 
#}
"done"

New-VM -Name Server -MemoryStartupBytes 4GB -BootDevice VHD -VHDPath "C:\ProgramData\Microsoft\Windows\Virtual Hard Disks\Server2022.vhdx" -Path C:\Users\leoer\Desktop\VM -Generation 2 -Switch LAN
