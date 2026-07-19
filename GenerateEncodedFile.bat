@echo off
title Encode A String
color 0F
cls

@REM echo.
@REM echo ===============================================
@REM echo      PASSWORD STRING ENCODER
@REM echo ===============================================
@REM echo.

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0StringEncoder.ps1"

echo.
pause
