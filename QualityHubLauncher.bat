@echo off
title Quality Hub Launcher
color 1F
cls

echo.
echo ===============================================
echo            QUALITY HUB LAUNCHER
echo ===============================================
echo.
echo Hello %USERNAME%!
echo.
echo Opening the Quality Hub...
echo Please wait...
echo.

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ^
-NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass ^
-File "J:\zz_Access_Tools_Data\Developers\OpenWorkbook.ps1" ^
-PwFilePath "J:\zz_Access_Tools_Data\Developers\.sysconfig\qh_42a.dat" ^
-WorkbookPath "J:\zz_Access_Tools_Data\Developers\encryptedWorkbook.xlsm"

exit