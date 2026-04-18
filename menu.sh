#!/bin/bash
# menu.sh
# Master Menu for Bash/Linux/Termux Users

show_menu() {
    clear
    echo -e "\e[32m==========================================\e[0m"
    echo -e "\e[32m   LAN Remote CLI - Master Setup Menu\e[0m"
    echo -e "\e[32m==========================================\e[0m"
    echo "1. Run Mobile Setup (Android/Termux)"
    echo "2. View Notebook Setup Instructions"
    echo "3. Exit"
    echo -e "\e[32m==========================================\e[0m"
}

while true; do
    show_menu
    read -p "Please choose an option [1-3]: " choice
    case $choice in
        1)
            bash ./windows_tmux/mobile/setup_mobile.sh
            read -p "Press Enter to return to menu..."
            ;;
        2)
            echo ""
            echo -e "\e[36m--- Notebook Setup (Windows 11) ---\e[0m"
            echo "1. Open PowerShell as Administrator."
            echo "2. Run: cd windows_tmux/notebook"
            echo "3. Run: .\setup_notebook.ps1"
            echo ""
            read -p "Press Enter to return to menu..."
            ;;
        3)
            exit 0
            ;;
        *)
            echo "Invalid option."
            sleep 1
            ;;
    esac
done
