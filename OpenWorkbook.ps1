param(
    [Parameter(Mandatory=$true)]
    [string]$PwFilePath,

    [Parameter(Mandatory=$true)]
    [string]$WorkbookPath
)

Add-Type -AssemblyName System.Windows.Forms

try {
    if (-not (Test-Path $PwFilePath))   { throw "Password file not found:`n$PwFilePath" }
    if (-not (Test-Path $WorkbookPath)) { throw "Workbook not found:`n$WorkbookPath" }

    $encoded  = (Get-Content $PwFilePath -Raw).Trim()
    $password = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($encoded))

    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $true
    $excel.DisplayAlerts = $false
    $excel.Workbooks.Open($WorkbookPath, 0, $false, [Type]::Missing, $password) | Out-Null
    $excel.DisplayAlerts = $true
}
catch {
    [System.Windows.Forms.MessageBox]::Show($_.Exception.Message, "Quality Hub", "OK", "Error") | Out-Null
}