# setup_notebook.ps1
# Setup OpenSSH Server for Remote CLI Access (LAN ONLY)

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Exit
}

$stateFile = Join-Path $PSScriptRoot ".setup_state.json"

function Show-SystemInfo {
    Write-Host "--- SYSTEM INFORMATION ---" -ForegroundColor Cyan
    Write-Host "OS: $((Get-ComputerInfo).OsName)"
    Write-Host "Version: $((Get-ComputerInfo).OsDisplayVersion)"
    Write-Host "Computer Name: $env:COMPUTERNAME"
    Write-Host "User: $env:USERNAME"
    Write-Host "-------------------------" -ForegroundColor Cyan
}

function Setup-SSHServer {
    Write-Host "Checking OpenSSH Server status..." -ForegroundColor Green
    
    # Check if OpenSSH.Server is installed
    $sshCapability = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
    $initiallyInstalled = ($sshCapability.State -eq 'Installed')
    
    # Check if sshd service was running
    $sshService = Get-Service -Name sshd -ErrorAction SilentlyContinue
    $initiallyRunning = ($sshService -and $sshService.Status -eq 'Running')
    
    # Check firewall rule
    $sshRule = Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
    $initiallyRuleExists = ($null -ne $sshRule)

    # Save initial state
    $setupState = @{
        SSHInitiallyInstalled = $initiallyInstalled
        SSHInitiallyRunning   = $initiallyRunning
        FirewallRuleInitiallyExists = $initiallyRuleExists
    }
    $setupState | ConvertTo-Json | Out-File $stateFile

    if (-not $initiallyInstalled) {
        Write-Host "Installing OpenSSH Server..." -ForegroundColor Yellow
        Add-WindowsCapability -Online -Name $sshCapability.Name
    } else {
        Write-Host "OpenSSH Server is already installed." -ForegroundColor Green
    }

    # Start SSH service
    Write-Host "Starting SSH service..." -ForegroundColor Green
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'

    # Check firewall rule
    if (-not $initiallyRuleExists) {
        Write-Host "Creating Firewall rule for SSH (Port 22)..." -ForegroundColor Yellow
        New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -LocalPort 22 -Action Allow
    } else {
        Write-Host "Firewall rule for SSH is already enabled." -ForegroundColor Green
    }
}

function Show-NetworkInfo {
    Write-Host "--- NETWORK INFORMATION ---" -ForegroundColor Cyan
    $ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "*Loopback*" }
    foreach ($ip in $ipAddresses) {
        Write-Host "IP Address ($($ip.InterfaceAlias)): $($ip.IPAddress)"
    }
    Write-Host "---------------------------" -ForegroundColor Cyan
    Write-Host "Use these IP addresses to connect from your Mobile device via SSH." -ForegroundColor Yellow
}

# Main Execution
Write-Host "--- PRE-SETUP NOTICE ---" -ForegroundColor Cyan
Write-Host "This script will perform the following actions:"
Write-Host "1. Check for Administrator privileges."
Write-Host "2. Install OpenSSH Server (if not present)."
Write-Host "3. Start and set OpenSSH service to Automatic."
Write-Host "4. Create a Windows Firewall rule for Port 22."
Write-Host "5. Save the initial state for future rollback."

$confirmation = Read-Host "Do you want to proceed? (Y/N)"
if ($confirmation -ne "Y") {
    Write-Host "Setup cancelled by user." -ForegroundColor Yellow
    Exit
}

Show-SystemInfo
Setup-SSHServer
Show-NetworkInfo

Write-Host "`n--- SETUP SUMMARY ---" -ForegroundColor Cyan
Write-Host "Operation: OpenSSH Server Setup"
Write-Host "Status: Complete"
Write-Host "Actions Taken:"
if ($setupState.SSHInitiallyInstalled -eq $false) { Write-Host "- Installed OpenSSH Server capability." }
Write-Host "- Configured 'sshd' service to Start and Auto-start."
if ($setupState.FirewallRuleInitiallyExists -eq $false) { Write-Host "- Created 'OpenSSH-Server-In-TCP' firewall rule." }
Write-Host "- State saved to: $stateFile"

Write-Host "`nSetup Complete! The server is now waiting for connection." -ForegroundColor Green
Write-Host "To talk to Gemini CLI, make sure it is installed and added to PATH."
