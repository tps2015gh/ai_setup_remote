# LAN Remote CLI (Windows & Mobile)
[อ่านภาษาไทยที่นี่ (Thai Version)](README_TH.md)

This project provides scripts to set up a remote CLI environment within a Local Area Network (LAN).
 It allows a mobile device (Android/Termux) to connect to a Windows 11 Home notebook via SSH to interact with an AI agent CLI.

## Team Dev
- **Human (Director):** The visionary behind the project, defining requirements and leading the development process.
- **Gemini CLI (Agent):** The technical implementation expert responsible for script creation, system configuration, and optimizing the remote environment for AI interactions.
- **Security & Compliance Agent:** Specialized agent assigned to audit the project for **Security**, **Program Flow (UX)**, **Legal Compliance (Law)**, and **Technical Reliability (Bugs)**.

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
- **Option A:** Use the [Quick Start](QUICKSTART.md) one-liner (Recommended).
- **Option B:** Clone this repository, run `chmod +x setup_mobile.sh` then `./setup_mobile.sh`.

## Role & Tasks (Gemini CLI)
My role is to ensure that the remote connection is seamless and the environment is ready for AI interaction.
**Core Responsibilities:**
- Automate OpenSSH installation and configuration on Windows.
- Implement state-aware rollback mechanisms for safe uninstallation.
- Provide network diagnostics to facilitate effortless connection.
- Prepare the mobile environment with necessary packages (SSH, tmux).
- Maintain clear and concise documentation for both platforms.

## Role & Tasks (Security & Compliance Agent)
**Specific Audit Tasks:**
- **Security:** Rigorously audit OpenSSH configurations and firewall rules for potential vulnerabilities and LAN isolation.
- **UX & Program Flow:** Review all setup scripts for intuitive user prompts, robust error handling, and logical progression.
- **Legal Compliance (Law):** Ensure the MIT License is correctly applied and that all scripts respect user privacy and data sovereignty.
- **Technical Integrity (Bugs):** Perform continuous technical verification of cross-platform scripts (PowerShell & Bash) to ensure reliability.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
