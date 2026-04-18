# create_shim.ps1
# Create SSH-compatible Gemini CLI shims (bat/ps1) in the User's Home directory

Write-Host "--- CREATING GEMINI SSH SHIMS ---" -ForegroundColor Cyan

# 1. Find Node.exe
$nodePath = where.exe node | Select-Object -First 1
if (-not $nodePath) {
    Write-Host "ERROR: Node.js not found in PATH." -ForegroundColor Red
    Exit
}

# 2. Find Gemini JS (Specifically looking for Volta or global installation)
Write-Host "Searching for Gemini CLI installation..." -ForegroundColor Yellow
$geminiJs = Get-ChildItem -Path "$env:LOCALAPPDATA\Volta\tools\image\packages\@google\gemini-cli" -Filter "gemini.js" -Recurse | Where-Object { $_.FullName -like "*bundle\gemini.js" } | Select-Object -First 1

if (-not $geminiJs) {
    # Fallback search in usual npm global locations if not Volta
    $npmPath = Join-Path $env:APPDATA "npm\node_modules\@google\gemini-cli\bundle\gemini.js"
    if (Test-Path $npmPath) {
        $geminiJs = Get-Item $npmPath
    }
}

if (-not $geminiJs) {
    Write-Host "ERROR: Could not locate gemini.js in standard Volta or NPM paths." -ForegroundColor Red
    Write-Host "Please ensure Gemini CLI is installed ('npm install -g @google/gemini-cli')." -ForegroundColor Yellow
    Exit
}

Write-Host "Found Node: $nodePath" -ForegroundColor Green
Write-Host "Found Gemini JS: $($geminiJs.FullName)" -ForegroundColor Green

# 3. Create .bat shims (Works in both CMD and PowerShell)
$batContent = "@echo off`n`"$nodePath`" `"$($geminiJs.FullName)`" %*"
$batPaths = @(
    (Join-Path $HOME "gemini.bat"),
    (Join-Path $HOME "g.bat")
)

foreach ($path in $batPaths) {
    $batContent | Out-File -FilePath $path -Encoding ascii -Force
    Write-Host "Created Shim: $path" -ForegroundColor Green
}

# 4. Create .ps1 shims (Optional, but good for PowerShell pure users)
$psContent = "function gemini { & `"$nodePath`" `"$($geminiJs.FullName)`" `$args }; gemini @args"
# Note: Simple alias or function in profile is better, but a physical file works for direct calls
$psPaths = @(
    (Join-Path $HOME "gemini.ps1"),
    (Join-Path $HOME "g.ps1")
)

foreach ($path in $psPaths) {
    $psContent | Out-File -FilePath $path -Encoding utf8 -Force
    Write-Host "Created Shim: $path" -ForegroundColor Green
}

Write-Host "`nShims created successfully in $HOME." -ForegroundColor Cyan
Write-Host "You can now type 'gemini' or 'g' immediately after SSHing into this machine." -ForegroundColor Yellow
