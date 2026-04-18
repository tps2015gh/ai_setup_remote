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
    echo -e "\e[32mChecking required packages (openssh, tmux, nmap)...\e[0m"
    
    # Update package list
    pkg update -y
    
    # Install OpenSSH
    if ! command -v ssh &> /dev/null; then
        echo -e "\e[33mInstalling OpenSSH...\e[0m"
        pkg install openssh -y
    fi
    
    # Install tmux
    if ! command -v tmux &> /dev/null; then
        echo -e "\e[33mInstalling tmux...\e[0m"
        pkg install tmux -y
    fi

    # Install nmap
    if ! command -v nmap &> /dev/null; then
        echo -e "\e[33mInstalling nmap...\e[0m"
        pkg install nmap -y
    fi
}

scan_lan() {
    echo -e "\e[36mScanning local network for SSH servers...\e[0m"
    # Get local IP and determine subnet
    local_ip=$(ifconfig wlan0 | grep "inet " | awk '{print $2}')
    if [ -z "$local_ip" ]; then
        echo -e "\e[31mError: Could not determine local IP. Are you connected to Wi-Fi?\e[0m"
        return
    fi
    
    subnet=$(echo $local_ip | cut -d. -f1-3).0/24
    echo "Your IP: $local_ip | Scanning Subnet: $subnet"
    echo "Please wait (this may take a few seconds)..."
    
    # Scan for port 22 (SSH) and 8022 (Termux)
    nmap -p 22,8022 --open $subnet | grep "Nmap scan report for"
    echo -e "\e[32mScan complete.\e[0m"
}

show_menu() {
    while true; do
        echo ""
        echo -e "\e[32mRemote CLI Setup Menu\e[0m"
        echo "1. Connect to Notebook (SSH)"
        echo "2. Scan LAN for Notebook"
        echo "3. Start tmux Session"
        echo "4. Exit"
        read -p "Choose an option [1-4]: " choice
        
        case $choice in
            1)
                read -p "Enter Windows IP: " win_ip
                read -p "Enter Windows Username: " win_user
                echo "Connecting to $win_user@$win_ip..."
                ssh "$win_user@$win_ip"
                ;;
            2)
                scan_lan
                ;;
            3)
                echo "Starting tmux..."
                tmux
                ;;
            4)
                exit 0
                ;;
            *)
                echo "Invalid choice."
                ;;
        esac
    done
}

# Main Execution
echo -e "\e[36m--- PRE-SETUP NOTICE ---\e[0m"
echo "This script will perform the following actions in Termux:"
echo "1. Update package list."
echo "2. Install OpenSSH client (for remote connection)."
echo "3. Install tmux (for session management)."
echo ""

read -p "Do you want to proceed? (y/n): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo -e "\e[33mSetup cancelled by user.\e[0m"
    exit 0
fi

show_system_info
setup_packages

echo -e "\e[36m--- SETUP SUMMARY ---\e[0m"
echo "Operation: Mobile Termux Setup"
echo "Status: Complete"
echo "Actions Taken:"
echo "- Updated package list."
echo "- Verified/Installed OpenSSH client."
echo "- Verified/Installed tmux."

show_menu
