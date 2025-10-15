# RDP and SOCKS Tunneling with SocksOverRDP

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[Port Forwarding with Windows- Netsh|Netsh]], [[SSH for Windows- plink.exe|Plink.exe]], [[SOCKS5 Tunneling with Chisel|Chisel]]

---

## Overview

SocksOverRDP leverages Dynamic Virtual Channels (DVC) in RDP to tunnel SOCKS5 traffic through an existing RDP session. Essential for Windows-only environments where SSH tunneling isn't available.

**Key Features:**
- SOCKS5 tunnel over RDP
- Uses RDP Dynamic Virtual Channels
- No SSH required
- Works in Windows-only environments
- Integrated with RDP session

**Use Cases:**
- Windows-only network
- SSH not available/blocked
- Already have RDP access
- Need to pivot through Windows host
- Multiple RDP sessions in chain

**Advantages:**
- Uses legitimate RDP protocol
- No SSH needed
- Tunnels within encrypted RDP
- Works on any Windows with RDP

**Requirements:**
- RDP access to Windows pivot
- Administrator rights (for registration)
- SocksOverRDP binaries
- Proxifier (or similar) on pivot

---

## Network Topology

```
Attack Machine → RDP → Windows Pivot → SocksOverRDP → Internal Network
                       (10.129.x.x)     127.0.0.1:1080   (172.16.5.0/24)
                                             ↓
                                        Proxifier routes
                                        all apps through
                                        SOCKS tunnel
```

---

## Required Tools

### Download Components

1. **SocksOverRDP**: https://github.com/nccgroup/SocksOverRDP/releases
   - SocksOverRDP-Plugin.dll
   - SocksOverRDP-Server.exe

2. **Proxifier Portable**: https://www.proxifier.com/download/
   - ProxifierPE.zip

---

## Setup Process

### Step 1: Transfer Files to Pivot

```bash
# From attack machine, RDP to pivot
xfreerdp /v:10.129.x.x /u:username /p:password /drive:share,/path/to/tools

# Or use RDP clipboard/drag-and-drop
# Copy SocksOverRDP files to pivot
```

---

### Step 2: Register SocksOverRDP Plugin

```cmd
# On Windows Pivot - Run as Administrator
cd C:\Tools\SocksOverRDP
regsvr32.exe SocksOverRDP-Plugin.dll
```

**Success Message:**
```
DllRegisterServer in SocksOverRDP-Plugin.dll succeeded.
```

**Important:** This must be done as Administrator!

---

### Step 3: Connect to Intermediate Target

```cmd
# From Pivot, RDP to internal target
mstsc.exe

# Connect to: 172.16.5.19
# Username: victor
# Password: pass@123
```

**Plugin Notification:**
```
SocksOverRDP-Plugin loaded successfully
Listening on 127.0.0.1:1080
```

---

### Step 4: Start SocksOverRDP Server

```cmd
# On internal target (172.16.5.19)
# Transfer SocksOverRDP-Server.exe first
# Run as Administrator:
C:\Tools\SocksOverRDP-Server.exe
```

**Output:**
```
SocksOverRDP Server listening on dynamic channel
Ready to accept connections
```

---

### Step 5: Verify SOCKS Listener

```cmd
# On Windows Pivot
netstat -antb | findstr 1080

# Should show:
TCP    127.0.0.1:1080         0.0.0.0:0              LISTENING
```

---

## Configure Proxifier

### Step 6: Setup Proxifier on Pivot

```
1. Extract and run ProxifierPE.exe
2. Profile → Proxy Servers → Add
3. Configure:
   - Address: 127.0.0.1
   - Port: 1080
   - Protocol: SOCKS Version 5
4. Check "Default proxy"
5. Test → Should show "OK"
```

---

### Step 7: Configure Proxification Rules

```
Profile → Proxification Rules → Add

Rule: RDP Through Tunnel
- Applications: mstsc.exe
- Target hosts: 172.16.6.0/24
- Action: Proxy SOCKS5 127.0.0.1:1080

Rule: All Internal Traffic
- Applications: Any
- Target hosts: 172.16.0.0/12;10.0.0.0/8;192.168.0.0/16
- Action: Proxy SOCKS5 127.0.0.1:1080

Rule: Direct Internet
- Applications: Any
- Target hosts: *
- Action: Direct
```

---

### Step 8: Access Deeper Internal Resources

```cmd
# From Windows Pivot with Proxifier running
# RDP to next-level internal host
mstsc.exe → 172.16.6.155

# Traffic flows:
Pivot → Proxifier → SOCKS (127.0.0.1:1080) → RDP session → Target
```

---

## Performance Optimization

### Reduce RDP Bandwidth

```
In mstsc.exe:
1. Show Options → Experience tab
2. Connection speed: Modem (56 Kbps)
3. Disable:
   - Desktop background
   - Font smoothing
   - Desktop composition
   - Menu and window animation
```

### Adjust RDP Quality

```cmd
# Low bandwidth settings
mstsc.exe /v:172.16.6.155 /compression /span
```

---

## Troubleshooting

### Plugin Not Loading

```cmd
# Verify registration
regsvr32.exe /u SocksOverRDP-Plugin.dll
regsvr32.exe SocksOverRDP-Plugin.dll

# Check if DLL is correct architecture (x64 vs x86)
# Ensure running as Administrator

# Restart RDP service
net stop TermService
net start TermService
```

### SOCKS Listener Not Starting

```cmd
# Check if port 1080 is in use
netstat -ano | findstr :1080

# Kill conflicting process
taskkill /PID <PID> /F

# Verify server is running on target
# Run SocksOverRDP-Server.exe as Administrator
```

### Proxifier Not Routing Traffic

```
1. Verify proxy is active (green icon in Proxifier)
2. Check rules order (specific rules first)
3. View Proxifier log for errors
4. Test proxy manually:
   - Profile → Proxy Servers → Test
5. Ensure SOCKS proxy is reachable
```

### RDP Connection Drops

```cmd
# Increase RDP timeout
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v KeepAliveTimeout /t REG_DWORD /d 1 /f

# Disable UDP in RDP
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /v fClientDisableUDP /t REG_DWORD /d 1 /f
```

---

## Alternative: Manual SOCKS Configuration

Without Proxifier, configure applications manually:

### Configure Browser

```
Firefox:
Settings → Network Settings → Manual Proxy
SOCKS Host: 127.0.0.1
Port: 1080
SOCKS v5: Checked
Proxy DNS: Checked
```

### Configure Tools via Command Line

```cmd
# Some tools support SOCKS proxy
curl --socks5 127.0.0.1:1080 http://172.16.6.155

# PowerShell with proxy
$proxy = [System.Net.WebProxy]::new('socks5://127.0.0.1:1080')
$handler = [System.Net.Http.HttpClientHandler]::new()
$handler.Proxy = $proxy
```

---

## Multi-Hop RDP Tunneling

### Chain Multiple RDP Sessions

```
Attack Machine 
    ↓ RDP
Windows Pivot 1 (SocksOverRDP Plugin)
    ↓ RDP with tunnel
Windows Pivot 2 (SocksOverRDP Server + Plugin)
    ↓ RDP with tunnel
Final Target

Each hop creates a new SOCKS tunnel!
```

**Setup:**
1. On Pivot 1: Register plugin, connect to Pivot 2
2. On Pivot 2: Run server, register plugin, connect to Target
3. Configure Proxifier on each pivot
4. Chain SOCKS proxies if needed

---

## Comparison with Other Windows Pivoting

| Method | Setup | Admin Needed | RDP Required | Persistence |
|--------|-------|--------------|--------------|-------------|
| SocksOverRDP | Medium | Yes | Yes | No |
| [[Port Forwarding with Windows- Netsh\|Netsh]] | Easy | Yes | No | Yes |
| [[SSH for Windows- plink.exe\|Plink]] | Easy | No | No | No |
| [[SOCKS5 Tunneling with Chisel\|Chisel]] | Easy | No | No | No |

**Use SocksOverRDP When:**
- Already have RDP access
- Windows-only environment
- Need to pivot through RDP sessions
- SSH not available

**Use Alternatives:**
- [[Port Forwarding with Windows- Netsh|Netsh]]: Simple port forward, no RDP needed
- [[SSH for Windows- plink.exe|Plink]]: SSH available, want more flexibility
- [[SOCKS5 Tunneling with Chisel|Chisel]]: No RDP, want modern tool

---

## Operational Security

### Detection Indicators
- SocksOverRDP DLL registered
- SocksOverRDP-Server.exe process
- Proxifier running
- Unusual RDP session patterns
- High bandwidth on RDP sessions
- Registry keys for plugin

### Evasion Techniques

```cmd
# Rename binaries
ren SocksOverRDP-Plugin.dll msrdp-plugin.dll
ren SocksOverRDP-Server.exe rdpservice.exe

# Clean up after
regsvr32.exe /u SocksOverRDP-Plugin.dll
del /f /q SocksOverRDP-*
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SocksOverRDP" /f

# Use legitimate port
# (1080 is common SOCKS port, may be monitored)
```

---

## Quick Reference

```cmd
# Register plugin (as Admin)
regsvr32.exe SocksOverRDP-Plugin.dll

# Unregister
regsvr32.exe /u SocksOverRDP-Plugin.dll

# Start server (on target)
SocksOverRDP-Server.exe

# Verify listener
netstat -ano | findstr :1080

# Proxifier config
Address: 127.0.0.1
Port: 1080
Type: SOCKS5

# RDP with reduced bandwidth
mstsc.exe /v:TARGET /compression

# Kill SocksOverRDP
taskkill /IM SocksOverRDP-Server.exe /F
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[Port Forwarding with Windows- Netsh|Windows Netsh Port Forwarding]]
- [[SSH for Windows- plink.exe|Plink SSH for Windows]]
- [[SOCKS5 Tunneling with Chisel|Chisel SOCKS5 Tunneling]]

**Tags:** #socksoverrdp #rdp #windows-pivoting #socks5 #proxifier #dvc #remote-desktop