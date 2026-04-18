# uninstall_notebook.ps1
# Rollback OpenSSH Server and Firewall configuration

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Exit
}

$stateFile = Join-Path $PSScriptRoot ".setup_state.json"

if (-not (Test-Path $stateFile)) {
    Write-Host "No setup state found. Cannot perform a targeted rollback." -ForegroundColor Red
    Write-Host "Standard cleanup will be performed instead." -ForegroundColor Yellow
    $setupState = @{
        SSHInitiallyInstalled = $true # Assume it was there to be safe
        SSHInitiallyRunning   = $false
        FirewallRuleInitiallyExists = $false
    }
} else {
    $setupState = Get-Content $stateFile | ConvertFrom-Json
}

Write-Host "--- ROLLBACK PROCESS STARTED ---" -ForegroundColor Cyan

# 1. Firewall Rollback
if ($setupState.FirewallRuleInitiallyExists -eq $false) {
    Write-Host "Removing Firewall rule 'OpenSSH-Server-In-TCP'..." -ForegroundColor Yellow
    Remove-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
} else {
    Write-Host "Keeping existing Firewall rule." -ForegroundColor Green
}

# 2. Service Rollback
if ($setupState.SSHInitiallyRunning -eq $false) {
    Write-Host "Stopping SSH service..." -ForegroundColor Yellow
    Stop-Service sshd -ErrorAction SilentlyContinue
    Set-Service -Name sshd -StartupType 'Manual'
} else {
    Write-Host "Keeping SSH service running as it was previously active." -ForegroundColor Green
}

# 3. Component Rollback (Uninstall)
if ($setupState.SSHInitiallyInstalled -eq $false) {
    Write-Host "Uninstalling OpenSSH Server..." -ForegroundColor Yellow
    $sshCapability = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
    Remove-WindowsCapability -Online -Name $sshCapability.Name
} else {
    Write-Host "Keeping OpenSSH Server as it was previously installed." -ForegroundColor Green
}

# Cleanup
if (Test-Path $stateFile) {
    Remove-Item $stateFile
}

Write-Host "--- ROLLBACK COMPLETE ---" -ForegroundColor Cyan
