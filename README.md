# Share GPU With Hyper-V Client v1.1 (by: Barnacules)
This PowerShell script will enable GPU partitioning of your nVidia GPU in your host PC with the guest operating system allowing for hardware accelerated video in your Windows 10 -or- Windows 11 guest operating systems running under Hyper-V. It's terrible that Microsoft doesn't document this process well at all and still leads people to documentation on RemoteFX which is a dead technology long removed from Windows 10 and Windows 11 due to security issues and it ends up wasting tons of peoples time going down that avenue (like I did) only to be disappointed. This script by default will only allocate one GPU due to issues with multiple GPU laptops but can be easily modified to pick a specific GPU or partition multiple GPU's. Right now I have my VM's using my second Titan XP I installed in my system so the RTX 3080 gets used by the host 100% and I can share the Titan XP with the VM's and use it for other machine learning stuff without bogging down my system too much. Honestly, this script has freed me from VMWare and allowed me to use Hyper-V.

# Requirements
- This only works with Nvidia GTX & RTX series GPU's greater then 10xx or newer
- VM guest must be running Windows 10 -or- Windows 11 since both Guest and Host need to run the same exact driver
- You must shut down the VM before running this script
- I've only tested this with Type 2 Hypervisors, but should work with Type 1 from what I've read
- You must re-run this script for each VM you run it on whenever you update the drivers on your HOST machine otherwise you'll have issues 

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

# Other Supporting Changes
By default Remote Desktop Client (MSTSC.EXE) is locked at 30fps max so when you run things on the VM it won't seem like they are running at a high framerate but if you run a benchmark like Heaven or run a CUDA task you will see it's running with full hardware acceleration. You can fix this slightly by increasing the maximum framerate of Microsoft Remote Desktop client by downloading and merging *IncreaseRemoteDesktopFPSto60.reg* into your registry from this project. Once you merge with the registry simply close down all mstsc.exe (Remote Desktop Client) sessions and re-start them and you should see a noticable improvement in framerate overall even if sometimes it still can't hit 60 due to networking issues, etc.

# Got Questions or want to say thank you 🤗
You can find all my links on linktr.ee/barnacules to my various live streams, social media, discord, etc. I'm a very interactive person and make my living as an online content creator. I mostly live stream these days but all of my streams are interactive and I really enjoy meeting new people, entertaining them and educating them 🙏 Hope to see you around if you found this at all useful 👍

