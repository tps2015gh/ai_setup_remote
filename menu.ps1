# menu.ps1
# Master Menu for Windows Users

function Show-Menu {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "   LAN Remote CLI - Master Setup Menu" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "1. Run Notebook Setup (Windows 11)"
    Write-Host "2. Run Notebook Uninstall (Rollback)"
    Write-Host "3. View Mobile Setup Instructions"
    Write-Host "4. Exit"
    Write-Host "==========================================" -ForegroundColor Green
}

do {
    Show-Menu
    $input = Read-Host "Please choose an option [1-4]"
    switch ($input) {
        '1' {
            Powershell -ExecutionPolicy Bypass -File ".\windows_tmux\notebook\setup_notebook.ps1"
            Read-Host "`nPress Enter to return to menu..."
        }
        '2' {
            Powershell -ExecutionPolicy Bypass -File ".\windows_tmux\notebook\uninstall_notebook.ps1"
            Read-Host "`nPress Enter to return to menu..."
        }
        '3' {
            Write-Host "`n--- Mobile Setup (Android/Termux) ---" -ForegroundColor Cyan
            Write-Host "Copy and paste this command directly into Termux (No clone needed):"
            Write-Host "pkg install curl -y && curl -LO https://raw.githubusercontent.com/tps2015gh/ai_setup_remote/master/windows_tmux/mobile/setup_mobile.sh && chmod +x setup_mobile.sh && ./setup_mobile.sh" -ForegroundColor Yellow
            Read-Host "`nPress Enter to return to menu..."
        }
        '4' {
            exit
        }
    }
} while ($true)
