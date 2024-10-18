Must be run as administrator - there is a check for this

$MinDays - can be set to whatever value you would like it set to. Set to '0' as this is what was needed in my use case.  can be set to any daily value - 30,60,90, etc.

Feature updates:
 - check for Execution Policy and ability to change it.
 - if no desire to change execution policy permanently, run the following
   -powershell -ExecutionPolicy Bypass -File ClearCCMCache-and-WindowsUpdateFolders.ps1
 - for more on ExecutionPolicy - https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.4

Zero error checks - will implement if demand is there
