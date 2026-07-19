@echo off
title Generate Password File
color 0F
cls

@REM echo.
@REM echo ===============================================
@REM echo      QUALITY HUB - PASSWORD FILE GENERATOR
@REM echo ===============================================
@REM echo.

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0GeneratePasswordFile.ps1"

echo.
pause