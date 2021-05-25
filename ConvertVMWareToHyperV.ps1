#install Microsoft Virtual Machine Converter
#https://www.microsoft.com/en-us/download/details.aspx?id=42497

Import-Module 'C:\Program Files\Microsoft Virtual Machine Converter\MvmcCmdlet.psd1'
#Get-Module
Set-Location C:\VirtuellaMaskiner\mim2016_2020
ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath .\disk1-cl1.vmdk -VhdType DynamicHardDisk -VhdFormat vhdx -Destination C:\VirtuellaMaskiner\HyperV\mim2020

ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath .\disk2-cl1.vmdk -VhdType DynamicHardDisk -VhdFormat vhdx -Destination C:\VirtuellaMaskiner\HyperV\mim2020

# ConvertTo-MvmcVirtualHardDisk -SourceLiteralPath c:...vmdx -VhdType FixedHardDisk -VhdFormat Vhd -DestinationLiteralPath c:\...

HyperVServer
Get-NetNatSession
Get-NetIPConfiguration
Test-Connection MIN.admim.lab
Test-Connection 192.168.214.210
Test-Connection 172.17.228.233
Get-NetRoute
Get-NetRoute | Where-Object {$_.InterfaceAlias -eq 'vEthernet (InternMIM_192_168_214_210)' -and $_.AddressFamily -eq 'IPv4'}| Format-List -Property *
Get-NetNeighbor | Format-List -Property *

Test-Connection UbuntuWM
Test-Connection 172.17.128.225

# Luckily, you can change the screen resolution.  Just not here.  What you need to do is:

# Open Terminal
# Type: sudo vi /etc/default/grub
# Find the line starting with GRUB_CMDLINE_LINUX_DEFAULT, and add video=hyperv_fb:[the resolution you want].  The resolution I want is 1280x720.  So my line ends up looking like this: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"
# Write the changes and quit vi.
# Run: sudo update-grub
# Reboot the virtual machine