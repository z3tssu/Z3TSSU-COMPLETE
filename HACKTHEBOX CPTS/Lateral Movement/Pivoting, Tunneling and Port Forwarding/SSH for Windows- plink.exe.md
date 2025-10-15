# SSH for Windows - Plink.exe

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SSH Socks Tunnel PF|SSH Dynamic SOCKS]], [[Port Forwarding with Windows- Netsh|Netsh]], [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP]]

---

## Overview

Plink (PuTTY Link) is a command-line SSH client for Windows, part of the PuTTY suite. It enables SSH tunneling from Windows systems when native SSH isn't available or desired.

**Key Features:**
- SSH client for Windows
- Dynamic port forwarding (SOCKS)
- Local/Remote port forwarding
- Part of PuTTY (often pre-installed)
- Command-line interface

**Use Cases:**
- Windows pivot host without OpenSSH
- Legacy Windows systems (pre-Windows 10)
- Need SSH tunnel from Windows
- "Living off the land" with existing tools
- Bypass application whitelisting (PuTTY often allowed)

**Advantages:**
- Often already present on Windows systems
- Part of legitimate PuTTY suite
- Full SSH functionality
- Supports all SSH tunnel types

---

## Installation

### Download Plink
```powershell
# Download from official site
Invoke-WebRequest -Uri "https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe" -OutFile "C:\Windows\Temp\plink.exe"

# Or entire PuTTY suite
Invoke-WebRequest -Uri "https://the.earth.li/~sgtatham/putty/latest/w64/putty.zip" -OutFile "putty.zip"
Expand-Archive putty.zip
```

### Verify Installation
```powershell
plink.exe -V
# Output: plink: Release 0.XX
```

---

## Network Topology

```
Windows Attack/Pivot → Plink SSH → Ubuntu Pivot → Internal Network
(10.10.15.5)          SOCKS 9050   (10.129.15.50)   (172.16.5.0/24)
```

### Environment Details

| Component | IP Address | Description |
|-----------|------------|-------------|
| Windows Attack Host | 10.10.15.5 | Runs plink.exe and Proxifier |
| Ubuntu Pivot | 10.129.15.50 | SSH server for tunnel |
| Windows Target | 172.16.5.19 | Internal RDP target |

---

## Dynamic Port Forwarding (SOCKS Proxy)

### Step 1: Create SSH SOCKS Tunnel

```powershell
# Basic SOCKS tunnel
plink.exe -ssh -D 9050 ubuntu@10.129.15.50

# With password on command line (non-interactive)
plink.exe -ssh -D 9050 -pw "password" ubuntu@10.129.15.50

# With private key
plink.exe -ssh -D 9050 -i C:\keys\private.ppk ubuntu@10.129.15.50

# Background mode (no console window)
start /B plink.exe -ssh -D 9050 -N ubuntu@10.129.15.50
```

**Parameters:**
- `-ssh`: Use SSH protocol
- `-D 9050`: Dynamic forward (SOCKS) on port 9050
- `-N`: No command execution (tunnel only)
- `-pw`: Password (avoid for security)
- `-i`: Private key file (.ppk format)

**Output:**
```
Using username "ubuntu".
ubuntu@10.129.15.50's password:
```

Once connected, SOCKS proxy listening on `127.0.0.1:9050`

---

### Step 2: Configure Proxifier (Windows Proxy Tool)

#### Install Proxifier
```powershell
# Download from https://www.proxifier.com/
# Or use portable version
```

#### Configure SOCKS Proxy
1. Open Proxifier
2. Profile → Proxy Servers → Add
3. Configure:
   - **Address**: `127.0.0.1`
   - **Port**: `9050`
   - **Protocol**: `SOCKS Version 4`
   - **Test**: Click to verify connection

#### Add Proxification Rules
```
Profile → Proxification Rules → Add

Rule 1: RDP through SOCKS
- Name: RDP Tunnel
- Applications: mstsc.exe
- Target hosts: 172.16.5.19
- Action: Proxy SOCKS 127.0.0.1:9050

Rule 2: All browsers
- Applications: chrome.exe;firefox.exe;iexplore.exe
- Target: 172.16.5.0/24
- Action: Proxy SOCKS 127.0.0.1:9050
```

---

### Step 3: Access Internal Services

#### RDP to Internal Host
```powershell
# Start RDP client (routed through Proxifier)
mstsc.exe

# Connect to: 172.16.5.19
# Proxifier will route through SOCKS tunnel
```

#### Other Applications
```powershell
# Any application configured in Proxifier
# will route through the tunnel

# Example: PowerShell web requests
Invoke-WebRequest -Uri "http://172.16.5.20"

# Example: SMB access
net use Z: \\172.16.5.25\share
```

---

## Local Port Forwarding

Forward specific port through tunnel (alternative to SOCKS).

```powershell
# Forward local 3389 to internal RDP server
plink.exe -ssh -L 3389:172.16.5.19:3389 ubuntu@10.129.15.50

# Multiple ports
plink.exe -ssh -L 3389:172.16.5.19:3389 -L 445:172.16.5.20:445 ubuntu@10.129.15.50

# Then connect to localhost
mstsc.exe /v:localhost:3389
```

---

## Remote/Reverse Port Forwarding

Forward ports FROM remote server TO your Windows machine.

```powershell
# Remote forward - catch reverse shells
plink.exe -ssh -R 10.129.15.50:8080:127.0.0.1:4444 ubuntu@10.129.15.50

# Then start listener on Windows
nc.exe -nlvp 4444
```

**Use Case:** Internal target sends reverse shell to Ubuntu:8080, forwarded to Windows:4444

---

## Advanced Plink Usage

### Persistent Tunnel with Auto-Reconnect

```powershell
# PowerShell script for persistent tunnel
while ($true) {
    plink.exe -ssh -D 9050 -N -pw "password" ubuntu@10.129.15.50
    Start-Sleep -Seconds 5
}
```

### Background Tunnel (No Window)

```powershell
# Start hidden
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "plink.exe"
$psi.Arguments = "-ssh -D 9050 -N -pw password ubuntu@10.129.15.50"
$psi.WindowStyle = "Hidden"
$psi.CreateNoWindow = $true
[System.Diagnostics.Process]::Start($psi)
```

### Use SSH Key (PPK Format)

```powershell
# Convert OpenSSH key to PuTTY format with PuTTYgen
# Then use with plink
plink.exe -ssh -D 9050 -i C:\keys\id_rsa.ppk ubuntu@10.129.15.50
```

### Compression for Slow Links

```powershell
# Enable compression
plink.exe -ssh -D 9050 -C ubuntu@10.129.15.50
```

### Session Logging

```powershell
# Log all session output
plink.exe -ssh -D 9050 ubuntu@10.129.15.50 -sessionlog C:\logs\plink.log
```

---

## Alternative: Native Windows OpenSSH

Modern Windows 10/11/Server 2019+ include native OpenSSH.

```powershell
# Check if installed
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*'

# Install if needed
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Use native SSH (same syntax as Linux)
ssh -D 9050 ubuntu@10.129.15.50
```

**When to Use:**
- **Plink**: Older Windows, PuTTY already present, need .ppk keys
- **Native SSH**: Modern Windows, prefer standard tools

---

## Proxifier Alternatives

### Option 1: Proxychains for Windows (Proxychains-NG)
```powershell
# Use with Windows Subsystem for Linux
wsl proxychains mstsc.exe
```

### Option 2: ProxyCap
Commercial alternative to Proxifier with similar functionality.

### Option 3: Application-Specific Proxies
```powershell
# Firefox with SOCKS
# Settings → Network → Manual Proxy
# SOCKS Host: 127.0.0.1
# Port: 9050

# Chrome with SOCKS
chrome.exe --proxy-server="socks5://127.0.0.1:9050"
```

---

## Troubleshooting

### Plink Connection Fails

```powershell
# Test SSH connectivity
plink.exe -ssh ubuntu@10.129.15.50 echo "test"

# Verbose output
plink.exe -ssh -D 9050 -v ubuntu@10.129.15.50

# Check if port 9050 is listening
netstat -an | findstr :9050
```

### Host Key Verification

```powershell
# Accept host key automatically (first connection)
echo y | plink.exe -ssh -D 9050 ubuntu@10.129.15.50

# Or store key in registry first
plink.exe -ssh ubuntu@10.129.15.50 exit
# Then connect normally
```

### Proxifier Not Routing Traffic

```powershell
# Verify proxy is reachable
Test-NetConnection -ComputerName 127.0.0.1 -Port 9050

# Check Proxifier rules
# Profile → Proxification Rules → Verify order

# Check Proxifier log
# View → Log
```

### Performance Issues

```powershell
# Enable compression
plink.exe -ssh -D 9050 -C ubuntu@10.129.15.50

# Use different cipher
plink.exe -ssh -D 9050 -cipher aes128-ctr ubuntu@10.129.15.50
```

---

## Comparison with Other Windows Pivoting Methods

| Method | Setup | Stealth | Performance | Requirements |
|--------|-------|---------|-------------|--------------|
| Plink | Easy | Medium | Good | PuTTY suite |
| [[Port Forwarding with Windows- Netsh\|Netsh]] | Easy | High | Excellent | Admin rights |
| [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP\|SocksOverRDP]] | Medium | Medium | Good | RDP access |
| [[SSH Socks Tunnel PF\|Native SSH]] | Easy | High | Excellent | Win10+/OpenSSH |

**Use Plink When:**
- PuTTY already installed
- Older Windows versions
- Need SSH features without OpenSSH
- PPK key format required

**Use Alternatives:**
- [[Port Forwarding with Windows- Netsh|Netsh]]: Admin rights, want native tool
- [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP]]: Pivoting through RDP session
- [[SSH Socks Tunnel PF|Native SSH]]: Modern Windows with OpenSSH

---

## Operational Security

### Detection Indicators
- Plink.exe process running
- Outbound SSH connection (port 22)
- PuTTY registry keys
- Proxifier process and rules
- SSH traffic patterns

### Evasion Techniques
```powershell
# Rename binary
Copy-Item plink.exe update.exe
.\update.exe -ssh -D 9050 ubuntu@10.129.15.50

# Use non-standard SSH port
plink.exe -ssh -D 9050 -P 443 ubuntu@10.129.15.50

# Clean registry after use
Remove-Item -Path "HKCU:\Software\SimonTatham\PuTTY\SshHostKeys" -Recurse -Force

# Clear command history
Clear-History
```

---

## Quick Reference

```powershell
# Basic SOCKS tunnel
plink.exe -ssh -D 9050 ubuntu@IP

# With password
plink.exe -ssh -D 9050 -pw "pass" ubuntu@IP

# With key
plink.exe -ssh -D 9050 -i key.ppk ubuntu@IP

# Background mode
start /B plink.exe -ssh -D 9050 -N ubuntu@IP

# Local port forward
plink.exe -ssh -L LOCAL:TARGET:PORT ubuntu@IP

# Remote port forward
plink.exe -ssh -R REMOTE:LOCAL:PORT ubuntu@IP

# Compression
plink.exe -ssh -D 9050 -C ubuntu@IP

# Verbose
plink.exe -ssh -D 9050 -v ubuntu@IP

# Kill plink processes
taskkill /F /IM plink.exe
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel (Linux)]]
- [[Port Forwarding with Windows- Netsh|Windows Netsh Port Forwarding]]
- [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP Tunneling]]

**Tags:** #plink #putty #windows-pivoting #ssh #socks #proxifier #windows