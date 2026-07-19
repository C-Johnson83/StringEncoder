# output all the colour combinations for text/background
# https://stackoverflow.com/questions/20541456/list-of-all-colors-available-for-powershell/41954792#41954792

# run in the terminal using execution bypass
# powershell -ExecutionPolicy Bypass -File .\colours.ps1

$colors = [enum]::GetValues([System.ConsoleColor])
Foreach ($bgcolor in $colors) {
    Foreach ($fgcolor in $colors) { Write-Host "$fgcolor|" -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine }
    Write-Host " on $bgcolor"
}
pause
