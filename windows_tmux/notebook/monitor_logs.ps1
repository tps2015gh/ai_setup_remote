# monitor_logs.ps1
# Continuously monitor OpenSSH Server Event Logs (Live View)

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator to access system logs." -ForegroundColor Red
    Exit
}

Clear-Host
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   MONITORING OPENSSH EVENT LOGS (LIVE VIEW)" -ForegroundColor Cyan
Write-Host "   Press any key to stop monitoring and return to menu." -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor Cyan

$lastLogTime = (Get-Date).AddMinutes(-10) # Start by showing logs from the last 10 minutes

while (-not $Host.UI.RawUI.KeyAvailable) {
    try {
        # Try Operational channel first
        $logs = Get-WinEvent -LogName "OpenSSH/Operational" -MaxEvents 50 -ErrorAction SilentlyContinue | Where-Object { $_.TimeCreated -gt $lastLogTime }
        
        if (-not $logs) {
             # Fallback to Admin channel if Operational is empty/disabled
             $logs = Get-WinEvent -LogName "OpenSSH/Admin" -MaxEvents 50 -ErrorAction SilentlyContinue | Where-Object { $_.TimeCreated -gt $lastLogTime }
        }

        if ($logs) {
            # Sort oldest to newest for the "tail" feel
            $logs | Sort-Object TimeCreated | ForEach-Object {
                Write-Host "[$($_.TimeCreated.ToString("HH:mm:ss"))] " -NoNewline -ForegroundColor Gray
                Write-Host "(ID: $($_.Id)) " -NoNewline -ForegroundColor DarkGray
                Write-Host "$($_.Message)" -ForegroundColor White
                $lastLogTime = $_.TimeCreated
            }
        }
    } catch {
        # Handle cases where channels might not be available
    }
    Start-Sleep -Milliseconds 500
}

# Clear the key buffer
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host "`nMonitoring stopped." -ForegroundColor Green
