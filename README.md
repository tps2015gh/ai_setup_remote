# LAN Remote CLI (Windows & Mobile)
[อ่านภาษาไทยที่นี่ (Thai Version)](README_TH.md)

This project provides scripts to set up a remote CLI environment within a Local Area Network (LAN).
 It allows a mobile device (Android/Termux) to connect to a Windows 11 Home notebook via SSH to interact with an AI agent CLI.

## Team Dev
- **Human (Director):** Product Owner and Visionary; defines core requirements, sets architectural direction, and provides final approval on all implementations.
- **Gemini CLI (Lead Agent):** Senior AI Software Engineer and **Interactive CLI Orchestrator**; responsible for end-to-end technical implementation, cross-platform script architecture, and coordinating specialized audit agents.
- **Security Auditor Agent:** Specialized entity mandated to perform deep-dive reviews of system security, SSH hardening, and infrastructure integrity.
- **UX & Flow Auditor Agent:** Dedicated reviewer of the end-to-end program logic, user journey, and cross-platform interaction consistency.
- **Legal & Compliance (Law) Agent:** Specialized auditor for ensuring strict adherence to the MIT License, privacy standards, and regional technology regulations.

## Master Menus
For easier setup, use the master menu scripts located in the root directory:

- **Windows:** Run `.\menu.ps1` in PowerShell.
- **Mobile/Linux:** Run `./menu.sh` in Bash (Termux).

## Project Structure
- `windows_tmux/notebook/`: Contains the setup script for the Windows 11 host.
- `windows_tmux/mobile/`: Contains the setup script for the Android (Termux) client.

## Setup Instructions

### 0. Clone the Repository (Step 0)
Open your terminal (PowerShell on Windows or Termux on Android) and run:
```bash
git clone https://github.com/tps2015gh/ai_setup_remote.git
cd ai_setup_remote
```

#### 0.1 Install Git (If not installed)
- **Windows:** Download and install from [git-scm.com](https://git-scm.com/download/win) or run `winget install --id Git.Git -e --source winget` in PowerShell.
- **Android (Termux):** Run `pkg install git -y`.

### 1. Notebook (Windows 11 Home)
- Navigate to `windows_tmux/notebook/`.
- Run `setup_notebook.ps1` with Administrator privileges in PowerShell.
- This script will install OpenSSH Server, enable the service, and configure the firewall.
- Take note of the IP address shown at the end of the script.

### 2. Mobile (Android / Termux)
- **Option A:** Use the [Quick Start](QUICKSTART.md) one-liner (Recommended).
- **Option B:** Clone this repository, run `chmod +x setup_mobile.sh` then `./setup_mobile.sh`.

## Role & Tasks (Gemini CLI - Lead Agent)
My mission is to architect and implement a robust remote CLI environment that is safe, efficient, and user-friendly.
**Strategic Responsibilities:**
- **System Automation:** Engineer the deployment of OpenSSH and firewall configurations on Windows 11.
- **State Integrity:** Implement state-aware rollback mechanisms to guarantee a clean uninstallation process.
- **Diagnostic Intelligence:** Provide high-signal network diagnostics, including a **Native Bash LAN Scanner** for rapid device discovery.
- **Cross-Platform Parity:** Ensure feature and logic parity between PowerShell (Windows) and Bash (Termux) environments.
- **SSH Compatibility:** Implement specific fixes for Volta-based CLI installations to ensure they execute correctly over SSH.
- **Orchestration:** Coordinate with specialized audit agents to maintain the highest standards of quality and security.

## Assigned Auditor Agents
**Specialized Audit Mandates:**
- **Security Auditor Agent:** Rigorously audit OpenSSH configurations and firewall policies to prevent unauthorized access and maintain strict LAN isolation.
- **UX & Flow Auditor Agent:** Review the end-to-end user journey for intuitive prompts, robust error handling, and logical progression across both platforms.
- **Legal & Compliance (Law) Agent:** Ensure the MIT License is correctly applied and that all scripts respect user privacy and system sovereignty.
- **Technical Verification (Bugs):** Perform continuous verification of scripts to identify and resolve race conditions, permission conflicts, or logic errors.
- **Audit Reports:** Maintain the **AGENT_REVIEW.md** with the latest security and technical findings.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
