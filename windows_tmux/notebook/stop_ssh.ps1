# stop_ssh.ps1
# Stop SSH Service and Restore (Close) Firewall Port

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Exit
}

Write-Host "--- STOPPING SSH & RESTORING FIREWALL ---" -ForegroundColor Cyan

# 1. Stop SSH Service
$sshService = Get-Service -Name sshd -ErrorAction SilentlyContinue
if ($null -ne $sshService) {
    if ($sshService.Status -eq 'Running') {
        Write-Host "Stopping SSH service (sshd)..." -ForegroundColor Yellow
        Stop-Service -Name sshd -Force
    } else {
        Write-Host "SSH service is already stopped." -ForegroundColor Green
    }
    Set-Service -Name sshd -StartupType 'Manual'
    Write-Host "Set SSH service startup to 'Manual'." -ForegroundColor Green
} else {
    Write-Host "SSH Service is not installed." -ForegroundColor Red
}

# 2. Restore (Remove) Firewall Rule
$sshRule = Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
if ($null -ne $sshRule) {
    Write-Host "Removing Firewall rule 'OpenSSH-Server-In-TCP' (Port 22)..." -ForegroundColor Yellow
    Remove-NetFirewallRule -Name "OpenSSH-Server-In-TCP"
    Write-Host "Firewall port 22 is now CLOSED." -ForegroundColor Green
} else {
    Write-Host "Firewall rule for SSH (Port 22) not found." -ForegroundColor Green
}

# 3. Show Final Status
Write-Host "`n--- FINAL STATUS ---" -ForegroundColor Cyan
& (Join-Path $PSScriptRoot "check_status.ps1")

Write-Host "`nOperation Complete." -ForegroundColor Green
