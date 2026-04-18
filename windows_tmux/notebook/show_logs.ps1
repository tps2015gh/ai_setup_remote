# show_logs.ps1
# Show OpenSSH Server Event Logs

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator to access system logs." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Exit
}

Write-Host "--- OPENSSH EVENT LOGS (Last 20 Events) ---" -ForegroundColor Cyan

try {
    # Attempt to get logs from the OpenSSH/Operational channel (most detailed for connections)
    $logs = Get-WinEvent -LogName "OpenSSH/Operational" -MaxEvents 20 -ErrorAction SilentlyContinue
    
    if (-not $logs) {
        # Fallback to OpenSSH/Admin
        $logs = Get-WinEvent -LogName "OpenSSH/Admin" -MaxEvents 20 -ErrorAction SilentlyContinue
    }
    
    if (-not $logs) {
        # Fallback to filtering Application log by Provider
        $logs = Get-WinEvent -ProviderName "OpenSSH" -MaxEvents 20 -ErrorAction SilentlyContinue
    }

    if ($logs) {
        $logs | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize -Wrap
    } else {
        Write-Host "No OpenSSH logs found." -ForegroundColor Yellow
        Write-Host "Check if OpenSSH is installed and has been running." -ForegroundColor Gray
    }
} catch {
    Write-Host "Error retrieving logs: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`nCheck Complete." -ForegroundColor Green
