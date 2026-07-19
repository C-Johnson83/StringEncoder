@echo off
title Encrypted File Launcher
color 1F
cls

echo.
echo ===============================================
echo            ENCRYPTED FILE LAUNCHER
echo ===============================================
echo.
echo Hello %USERNAME%!
echo.
echo Please wait...
echo.

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ^
-NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass ^
-File "..\..\OpenWorkbook.ps1" ^
-PwFilePath "..\..\ created.dat" ^
-WorkbookPath "..\..\encryptedWorkbook.xlsm"

exit
