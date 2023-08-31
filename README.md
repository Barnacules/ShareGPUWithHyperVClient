# Share GPU With Hyper-V Client v1.1 (by: @Barnacules)
This PowerShell script will enable GPU partitioning of your nVidia GPU in your host PC with the guest operating system allowing for hardware accelerated video in your Windows 10 -or- Windows 11 guest operating systems running under Hyper-V.

# Requirements
*- This only works with Nvidia GTX & RTX series GPU's greater then 10xx or newer
*- VM guest must be running Windows 10 -or- Windows 11 since both Guest and Host need to run the same exact driver
*- You must shut down the VM before running this script
*- I've only tested this with Type 2 Hypervisors, but should work with Type 1 from what I've read
*- You must re-run this script for each VM you run it on whenever you update the drivers on your HOST machine otherwise you'll have issues 

# Instructions
1. Download ShareGPUWithHyperVClient.ps1 to a local folder
2. Open elevated (Admin) PowerShell Prompt
3. Navigate to folder where you downloaded script
4. Edit script with your favorite text editor
5. Change $vm variable to equal the name of the virtual machine you want to enable GPU on
6. Make sure the VM you're targeting IS NOT RUNNING! You must stop it before running this
7. Run script '.\ShareGPUWithHyperVClient.ps1' and wait for it to complete
8. Now your VM will be running and should show your host GPU under device manager
9. Open Microsoft Edge and navigate to 'EDGE://GPU' and it should show almost everything as "Hardware Accelerated"

# Come say hi 👋
If you found this script helpful please come and say hi to me on Twitter (or X) over at http://twitter.com/barnacules -or- http://x.com/barnacules and also come visit my live streams on Twitch.tv/Barnacules -&- YouTube.com/@barnacules since I'm a very interactive guy...


