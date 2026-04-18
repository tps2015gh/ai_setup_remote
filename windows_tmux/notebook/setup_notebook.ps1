# setup_notebook.ps1
# Setup OpenSSH Server for Remote CLI Access (LAN ONLY)

# Check for Administrator privileges
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "ERROR: This script must be run as Administrator." -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as administrator'." -ForegroundColor Yellow
    Exit
}

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
    $sshServer = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
    
    if ($sshServer.State -ne 'Installed') {
        Write-Host "Installing OpenSSH Server..." -ForegroundColor Yellow
        Add-WindowsCapability -Online -Name $sshServer.Name
    } else {
        Write-Host "OpenSSH Server is already installed." -ForegroundColor Green
    }

    # Start SSH service
    Write-Host "Starting SSH service..." -ForegroundColor Green
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'

    # Check firewall rule
    $sshRule = Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
    if (-not $sshRule) {
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
Show-SystemInfo
Setup-SSHServer
Show-NetworkInfo

Write-Host "`nSetup Complete! The server is now waiting for connection." -ForegroundColor Green
Write-Host "To talk to Gemini CLI, make sure it is installed and added to PATH."
