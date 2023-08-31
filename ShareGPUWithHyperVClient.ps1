# ShareGPUWithHyperVClient.ps1 v1.1
# 
# This script will enable nVidia GPU sharing with your VM client under Hyper-V running
# Windows 10 -or- Windows 11by partitioning your GPU so both host & client can simultaneously 
# use it and access 100% of it's total resources unless you change the values in the script 
# below to limit it. This ONLY works for nvidia GTX 1000 or newer GPU's and you should always 
# start with latest drivers!
#
# WARNING: You must re-run this script anytime you update video drivers on the host!

# [ONLY THING YOU NEED TO CHANGE] 
# Change this to the exact name of your VM before running the script
$vm = "Example Windows 11 VM"

# Reset all current partitioning to configure new settings to share 100% of the GPU resources 
Remove-VMGpuPartitionAdapter -VMName $vm
Add-VMGpuPartitionAdapter -VMName $vm -MaxPartitionCompute 1000000000 -MaxPartitionDecode 1000000000 -MaxPartitionEncode 18446744073709551615 -MaxPartitionVRAM 1000000000 -MinPartitionCompute 0 -MinPartitionDecode 0 -MinPartitionEncode 0 -MinPartitionVRAM 0 -OptimalPartitionCompute 1000000000 -OptimalPartitionDecode 1000000000 -OptimalPartitionEncode 18446744073709551614 -OptimalPartitionVRAM 1000000000 -Verbose
Set-VM -GuestControlledCacheTypes $true -VMName $vm
Set-VM -LowMemoryMappedIoSpace 1Gb -VMName $vm
Set-VM -HighMemoryMappedIoSpace 32GB -VMName $vm
Start-VM -Name $vm

# Wait 15 seconds for VM to start
Sleep 15

# Find all video card driver DLL's to be copied from the host to the client (You must re-run this script when you update your host drivers)
$GpuDllPaths = (Get-CimInstance Win32_VideoController -Filter "Name like 'N%'").InstalledDisplayDrivers.split(',') | Get-Unique

# Extract directories
$GpuInfDirs = $GpuDllPaths | ForEach-Object {[System.IO.Path]::GetDirectoryName($_)} | Get-Unique
 
# Hack, leaving only NVidia drivers (solving issue with notebooks with multiple GPUs) You can also change this to share a specific GPU if you have multiple
$GpuInfDirs = $GpuInfDirs | Where-Object {(Split-Path $_ -Leaf ).StartsWith("nv")}
 
# Start session to copy files from host to guest (client) machine
$s = New-PSSession -VMName $vm -Credential (Get-Credential)
 
# Copy nv_dispi.inf_amd64 folder from host to guest system
$GpuInfDirs | ForEach-Object { Copy-Item -ToSession $s -Path $_ -Destination C:\Windows\System32\HostDriverStore\FileRepository\ -Recurse -Force }
 
# Copy nvapi64.dll into guest system
Copy-Item -ToSession $s -Path C:\Windows\System32\nv*.dll -Destination C:\Windows\System32\
 
# Cleaning up session
Remove-PSSession $s
 
# Restarting the VM and GPU should not show up under Device Manager on VM and edge://gpu should show hardware acceleration enabled
Restart-VM $vm -Force