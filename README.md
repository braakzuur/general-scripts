Must be run as administrator - there is a check for this

This script is for environments that use Configuration Manager (CCM) and are having issues updating bits via Software Center

$MinDays - can be set to whatever value you would like it set to. Set to '0' as this is what was needed in my use case.  can be set to any daily value - 30,60,90, etc.

Feature updates:
 - check for Execution Policy and ability to change it.
 - if no desire to change execution policy permanently, run the following:
   -powershell -ExecutionPolicy Bypass -File ClearCCMCache-and-WindowsUpdateFolders.ps1
 - for more on ExecutionPolicy - https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.4

Zero error checks - will implement if demand is there

=======================

Fixing machine process
----------------------
Try first: 
Open Configuration Manager -> Cache -> click 'Configure Settings' -> Delete Files -> check 'Delete persisted cache content -> click 'Yes' -> click 'OK'
Run gpupdate /force

If that doesn't work, try the following

Required Scripts:
-----------------
ClearWIndowsUpdateFolders.bat/ps1
wmi-fix-sb.bat

Run Actions in Configuration Manager
Run GPupdate /force
Check Software Center

Open Elevated CMD prompt
Run ClearWIndowsUpdateFolders.bat (check if there are already .old files for SD and cr2 folders. If so, delete them or script may fail)
Run wmi-fix-sb.bat
Note: if sfc at end of wmi bat doesn't fix everything, try: 
DISM /Online /Cleanup-Image /RestoreHealth - then sfc
if it still doesn't work, try: chkdsk /f /r
[restart computer]

Open Elevated CMD prompt
Ran c:\Windows\CCM\ccmrepair.exe

Run Actions in Configuration Manager

Run gpupdate /force
[restart computer]

Run gpupdate /force
[restart computer]

Run gpupdate /force
[restart computer]

Check Software Center to see if everything works as expected
