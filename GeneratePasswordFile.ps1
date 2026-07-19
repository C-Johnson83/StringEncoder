Function New-ANSIBar {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory,HelpMessage= "Enter a range of 256 color values, e.g. (232..255)")]
        [ValidateNotNullOrEmpty()]
        [int[]]$Range,
        [Parameter(HelpMessage = "How many spaces do you want in the bar? This will increase the length of the bar.")]
        [int]$Spacing = 1
    )
    $esc = "$([char]0x1b)"
    $out = @()
    $blank = " "*$spacing
    $out += $range | ForEach-Object {
        "$esc[48;5;$($_)m$($blank)$esc[0m"
    }

    $out += $range | Sort-Object -Descending | ForEach-Object {
        "$esc[48;5;$($_)m$($blank)$esc[0m"
    }
    $out -join ""
}


New-ANSIBar -Range (196..201) -Spacing 10
Write-Host ""


$bannerLines = @(
'<>====================================================================================================================<>'
'||\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/||'
'||<> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <>||'
'||/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\||'
'||====================================================================================================================||'
'||                                                                                                                    ||'
'||                     ______     ______   ______     __     __   __     ______                                       ||'
'||                    /\  ___\   /\__  _\ /\  == \   /\ \   /\ "-.\ \   /\  ___\                                      ||'
'||                    \ \___  \  \/_/\ \/ \ \  __<   \ \ \  \ \ \-.  \  \ \ \__ \                                     ||'
'||                     \/\_____\    \ \_\  \ \_\ \_\  \ \_\  \ \_\\"\_\  \ \_____\                                    ||'
'||                      \/_____/     \/_/   \/_/ /_/   \/_/   \/_/ \/_/   \/_____/                                    ||'
'||                     ______     __   __     ______     ______     _____     ______     ______                       ||'
'||                    /\  ___\   /\ "-.\ \   /\  ___\   /\  __ \   /\  __-.  /\  ___\   /\  == \                      ||'
'||                    \ \  __\   \ \ \-.  \  \ \ \____  \ \ \/\ \  \ \ \/\ \ \ \  __\   \ \  __<                      ||'
'||                     \ \_____\  \ \_\\"\_\  \ \_____\  \ \_____\  \ \____-  \ \_____\  \ \_\ \_\                    ||'
'||                      \/_____/   \/_/ \/_/   \/_____/   \/_____/   \/____/   \/_____/   \/_/ /_/                    ||'
'||                                                                                                                    ||'
'||                                                                                                                    ||'
'||====================================================================================================================||'
'||/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\||'
'||<> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <> <>||'
'||\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/||'
'<>====================================================================================================================<>'
)

# Change these colors however you like.
$lineColors = @{
    1  = 'Red'   # Top slash pattern
    2  = 'Magenta'      # Top <> pattern
    3  = 'Blue'    # Top /\/ pattern
    4  = 'Cyan'  # Inner separator

    18 = 'Cyan'  # Inner separator
    19 = 'Blue'    # Bottom /\/ pattern
    20 = 'Magenta'      # Bottom <> pattern
    21 = 'Red'   # Bottom slash pattern
}

for ($i = 0; $i -lt $bannerLines.Count; $i++) {
    $line = $bannerLines[$i]

    # The very top and bottom borders are entirely red.
    if ($i -eq 0 -or $i -eq ($bannerLines.Count - 1)) {
        Write-Host $line -ForegroundColor DarkRed
        continue
    }

    # Outer left border.
    Write-Host $line.Substring(0, 2) `
        -ForegroundColor DarkRed `
        -NoNewline

    # Everything between the outer borders.
    $middle = $line.Substring(2, $line.Length - 4)

    # ASCII-art words are lines 5 through 14.
    if ($i -ge 6 -and $i -le 15) {
        $middleColor = 'White'
    }
    elseif ($lineColors.ContainsKey($i)) {
        $middleColor = $lineColors[$i]
    }
    else {
        $middleColor = 'White'
    }

    Write-Host $middle `
        -ForegroundColor $middleColor `
        -NoNewline

    # Outer right border.
    Write-Host $line.Substring($line.Length - 2) `
        -ForegroundColor DarkRed
}


$plain = Read-Host "Enter the password to encode" -AsSecureString
Write-Host ""
New-ANSIBar -Range (220..225) -Spacing 10
Write-Host ""
$bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($plain)
$plainText = [Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)

Write-Host "Enter the full path without the quotes to save the .dat file (e.g. J:\...\.sysconfig\qh_42a.dat)" -ForegroundColor Yellow
$outputPath = Read-Host


$folder = Split-Path $outputPath -Parent
if (-not (Test-Path $folder)) {
    New-Item -Path $folder -ItemType Directory -Force | Out-Null
    Write-Host "Created folder: $folder" -ForegroundColor Yellow
}

$bytes = [System.Text.Encoding]::UTF8.GetBytes($plainText)
$b64 = [Convert]::ToBase64String($bytes)

Set-Content -Path $outputPath -Value $b64 -NoNewline

Write-Host "Process is complete"
Write-Host ""
New-ANSIBar -Range 49,50,51,87,123,159 -Spacing 10
Write-Host ""
Write-Host "String file written to:" -ForegroundColor Cyan
Write-Host  "     $outputPath"
Write-Host ""
New-ANSIBar -Range (232..237) -Spacing 10
