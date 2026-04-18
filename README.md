# LAN Remote CLI (Windows & Mobile)

This project provides scripts to set up a remote CLI environment within a Local Area Network (LAN). It allows a mobile device (Android/Termux) to connect to a Windows 11 Home notebook via SSH to interact with an AI agent CLI.

## Team Dev
- **Human (Director):** The visionary behind the project, defining requirements and leading the development process.
- **Gemini CLI (Agent):** The technical expert responsible for implementation, script creation, system configuration, and remote environment optimization.
- **Security & Compliance Agent:** Responsible for auditing code for bugs, legal compliance (licensing/privacy), security best practices, and ensuring a seamless program flow (UX).

## Master Menus
For easier setup, use the master menu scripts located in the root directory:

- **Windows:** Run `.\menu.ps1` in PowerShell.
- **Mobile/Linux:** Run `./menu.sh` in Bash (Termux).

## Project Structure
- `windows_tmux/notebook/`: Contains the setup script for the Windows 11 host.
- `windows_tmux/mobile/`: Contains the setup script for the Android (Termux) client.

## Setup Instructions

### 1. Notebook (Windows 11 Home)
- Navigate to `windows_tmux/notebook/`.
- Run `setup_notebook.ps1` with Administrator privileges in PowerShell.
- This script will install OpenSSH Server, enable the service, and configure the firewall.
- Take note of the IP address shown at the end of the script.

### 2. Mobile (Android / Termux)
- Open Termux on your Android device.
- Clone this repository or fetch the `setup_mobile.sh` script.
- Run `chmod +x setup_mobile.sh` then `./setup_mobile.sh`.
- This script will install `openssh` and `tmux`, then provide a menu to connect to your notebook.

## Role & Tasks (Gemini CLI)
My role is to ensure that the remote connection is seamless and the environment is ready for AI interaction.
**Tasks:**
- Automate OpenSSH installation on Windows.
- Implement state-aware rollback mechanisms.
- Provide network diagnostics to facilitate easy connection.
- Prepare the mobile environment with necessary packages (SSH, tmux).
- Document the workflow and ensure clarity for the user.

## Role & Tasks (Security & Compliance Agent)
**Tasks:**
- **Security:** Audit OpenSSH configurations and firewall rules for potential vulnerabilities.
- **UX/Flow:** Review setup scripts for user-friendly prompts, error handling, and logical progression.
- **Law:** Ensure licensing (MIT) is correctly applied and privacy is maintained in all scripts.
- **Bugs:** Perform technical verification of cross-platform scripts (PowerShell & Bash).

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
