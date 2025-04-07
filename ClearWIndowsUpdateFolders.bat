@ECHO OFF

::Clear Windows update issues
::James Holmes
::Updated: 2024-10-17
::
::This batch file must be run as administrator or run in elevated command prompt

::Clear screen
cls

ECHO [31mStopping Services[0m
echo:
::Stop Windows Update Service
net stop wuauserv

::Stop Windows Cryptographic Service
net stop cryptSvc

::Stop Background Intelligent Transfer Service
net stop bits

::Stop Windows Installer Service
net stop msiserver

::Delete any old backups of the Software Distribution and catroot2 folders
echo [31mDeleting any old backups of the catroot2 folder[0m
rmdir /s /q C:\Windows\System32\catroot2.old
echo [31mDeleting any old backups of the Software Distribution folder[0m
rmdir /s /q C:\Windows\SoftwareDistribution.old
echo:

::Change to System32 directory, rename catroo2 folder
ECHO [32mChanging to the System32 directory[0m
cd C:\Windows\System32\

::Rename catroot2 Folder
ECHO [33mRenaming catroot2 folder[0m
ren C:\Windows\System32\catroot2 catroot2.old
echo:

::Change directory to Windows directory
ECHO [32mChanging to the Windows directory[0m
cd C:\Windows\

::Rename Software Distribution Folder
ECHO [33mRenaming SoftwareDistribution folder[0m
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
echo:

ECHO Restarting Services
::Restart Windows Installer Service
echo:
ECHO [32mRestarting Services[0m
net start msiserver

::Restart Background Intelligent Transfer Service
net start bits

::Restart Windows Cryptographic Service
net start cryptSvc

::Restart Windows Update Service
net start wuauserv

pause

::Return to users home folder
cd "%userprofile%\Onedrive - Eaton\Desktop\"