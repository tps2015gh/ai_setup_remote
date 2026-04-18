# check_status.ps1
# Check SSH Service and Firewall Status

Write-Host "--- SYSTEM STATUS CHECK ---" -ForegroundColor Cyan

# 1. Check SSH Service
$sshService = Get-Service -Name sshd -ErrorAction SilentlyContinue
if ($null -eq $sshService) {
    Write-Host "SSH Service: NOT INSTALLED" -ForegroundColor Red
} else {
    $color = if ($sshService.Status -eq 'Running') { "Green" } else { "Yellow" }
    Write-Host "SSH Service: $($sshService.Status)" -ForegroundColor $color
    Write-Host "Startup Type: $($sshService.StartType)"
}

# 2. Check Firewall Rule
$sshRule = Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
if ($null -eq $sshRule) {
    Write-Host "Firewall Rule (Port 22): NOT FOUND (CLOSED)" -ForegroundColor Red
} else {
    $ruleStatus = if ($sshRule.Enabled -eq 'True') { "ENABLED (OPEN)" } else { "DISABLED (CLOSED)" }
    $ruleColor = if ($sshRule.Enabled -eq 'True') { "Green" } else { "Yellow" }
    Write-Host "Firewall Rule (Port 22): $ruleStatus" -ForegroundColor $ruleColor
}

# 3. Network Info
Write-Host "`n--- NETWORK INFO ---" -ForegroundColor Cyan
$ipAddresses = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike "*Loopback*" }
foreach ($ip in $ipAddresses) {
    Write-Host "IP Address ($($ip.InterfaceAlias)): $($ip.IPAddress)"
}

Write-Host "`nCheck Complete." -ForegroundColor Green
