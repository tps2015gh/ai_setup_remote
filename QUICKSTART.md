# Quick Start Guide

Get your LAN Remote CLI up and running in 3 minutes.

## Prerequisites
- **Notebook:** Windows 11 Home connected to LAN.
- **Mobile:** Android with [Termux](https://termux.dev/) installed.

---

## Step 0: Clone the Repository
Open your terminal (PowerShell on Windows or Termux on Android) and run:
```bash
git clone https://github.com/tps2015gh/ai_setup_remote.git
cd ai_setup_remote
```

## Step 1: Notebook Setup (Windows)
1. Open **PowerShell** as **Administrator**.
2. Navigate to the project folder:
   ```powershell
   cd .\windows_tmux\notebook\
   ```
3. Run the setup script:
   ```powershell
   .\setup_notebook.ps1
   ```
4. **Note the IP Address** displayed at the end (e.g., `192.168.1.15`).

## Step 1.5: Rollback (Optional)
If you wish to remove the SSH server and revert firewall changes:
1. Run `.\uninstall_notebook.ps1` as Administrator.
   - This will only remove components that were NOT present before the setup.

## Step 2: Mobile Setup (Android)
1. Open **Termux**.
2. Navigate to the project folder (or download the script):
   ```bash
   cd windows_tmux/mobile/
   ```
3. Run the setup script:
   ```bash
   chmod +x setup_mobile.sh
   ./setup_mobile.sh
   ```
4. Select **Option 1** from the menu.
5. Enter the **IP Address** from Step 1 and your Windows **Username**.

## Step 3: Start Talking to AI
Once connected via SSH:
1. Type `gemini` (or your specific CLI command) to start the agent.
2. Use `tmux` (Option 2 on mobile) to keep the session alive even if your phone screen turns off.

---
> [!TIP]
> For security, privacy, and bug reports, see the [AGENT_REVIEW.md](AGENT_REVIEW.md).
