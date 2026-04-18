#!/bin/bash
# setup_mobile.sh
# Setup Remote CLI Access for Android (using Termux)

show_system_info() {
    echo -e "\e[36m--- SYSTEM INFORMATION ---\e[0m"
    echo "OS: $(uname -o)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo -e "\e[36m--------------------------\e[0m"
}

setup_packages() {
    echo -e "\e[32mChecking required packages (openssh, tmux)...\e[0m"
    
    # Update package list
    pkg update -y
    
    # Install OpenSSH
    if ! command -v ssh &> /dev/null; then
        echo -e "\e[33mInstalling OpenSSH...\e[0m"
        pkg install openssh -y
    else
        echo -e "\e[32mOpenSSH is already installed.\e[0m"
    fi
    
    # Install tmux
    if ! command -v tmux &> /dev/null; then
        echo -e "\e[33mInstalling tmux...\e[0m"
        pkg install tmux -y
    else
        echo -e "\e[32mtmux is already installed.\e[0m"
    fi
}

show_menu() {
    while true; do
        echo ""
        echo -e "\e[32mRemote CLI Setup Menu\e[0m"
        echo "1. Connect to Notebook (SSH)"
        echo "2. Start tmux Session"
        echo "3. Exit"
        read -p "Choose an option [1-3]: " choice
        
        case $choice in
            1)
                read -p "Enter Windows IP: " win_ip
                read -p "Enter Windows Username: " win_user
                echo "Connecting to $win_user@$win_ip..."
                ssh "$win_user@$win_ip"
                ;;
            2)
                echo "Starting tmux..."
                tmux
                ;;
            3)
                exit 0
                ;;
            *)
                echo "Invalid choice."
                ;;
        esac
    done
}

# Main Execution
show_system_info
setup_packages
show_menu
