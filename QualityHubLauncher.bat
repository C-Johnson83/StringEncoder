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
-File "..\..\OpenWorkbook.ps1" ^
-PwFilePath "..\..\ created.dat" ^
-WorkbookPath "..\..\encryptedWorkbook.xlsm"

exit
