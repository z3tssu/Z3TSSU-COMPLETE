# SSH Dynamic SOCKS Tunnel & Port Forwarding

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Port Forward]], [[SSH Pivoting with Sshuttle|Sshuttle]]

---

## Overview
SSH dynamic port forwarding creates a SOCKS proxy allowing access to entire internal networks. Best used when you have SSH credentials to a pivot host.

**Use Cases:**
- Full internal network enumeration
- Multiple target access through single tunnel
- Works with any TCP-based tool via proxychains

**Advantages:**
- Built-in to SSH (no additional tools)
- Encrypted traffic
- Dynamic routing to any internal host

**Requirements:**
- SSH access to pivot host
- Proxychains installed on attacker machine

---

## Local Port Forward (Single Service)

### Scan Pivot Target
```bash
nmap -sT -p22,3306 10.129.202.64
```

### Forward Specific Port
```bash
# Forward local 1234 to pivot's MySQL (3306)
ssh -L 1234:localhost:3306 ubuntu@10.129.202.64
```
**Explanation:** Traffic to your `localhost:1234` → pivot's `localhost:3306`

### Verify Port Forward
```bash
# Check with netstat
netstat -antp | grep 1234

# Verify with nmap
nmap -v -sV -p1234 localhost
```

### Access the Service
```bash
# Connect to MySQL through tunnel
mysql -u user -p -h 127.0.0.1 -P 1234
```

### Forward Multiple Ports
```bash
# Forward MySQL and HTTP simultaneously
ssh -L 1234:localhost:3306 -L 8080:localhost:80 ubuntu@10.129.202.64
```

---

## Dynamic Port Forward (Full Network Access)

### Enable Dynamic Forwarding
```bash
ssh -D 9050 ubuntu@10.129.202.64
```

**Explanation:**
- `-D 9050` creates SOCKS proxy on local port 9050
- All traffic sent to localhost:9050 routes through pivot
- Pivot forwards to any destination you specify

### Configure Proxychains
Edit `/etc/proxychains.conf`:
```bash
tail -4 /etc/proxychains.conf

# Add this line at the end if not present
socks4 127.0.0.1 9050
```

**Alternative Config:**
```conf
[ProxyList]
# For SSH dynamic forward
socks4 127.0.0.1 9050

# Or use SOCKS5 (if supported)
socks5 127.0.0.1 9050
```

### Use Proxychains with Tools

#### Network Discovery
```bash
# Ping sweep internal network
proxychains nmap -v -sn 172.16.5.1-200
```

#### Port Scanning
```bash
# Scan Windows target
proxychains nmap -v -Pn -sT 172.16.5.19

# Full port scan
proxychains nmap -v -Pn -sT -p- 172.16.5.19

# Service detection
proxychains nmap -v -Pn -sT -sV -p80,443,445,3389 172.16.5.19
```

**Important Flags:**
- `-sT`: TCP connect scan (required with proxychains)
- `-Pn`: Skip ping (assume host is up)
- `-v`: Verbose output

#### Metasploit Through Proxy
```bash
# Start msfconsole with proxychains
proxychains msfconsole

# All modules will route through tunnel
msf6 > use auxiliary/scanner/rdp/rdp_scanner
msf6 > set rhosts 172.16.5.19
msf6 > run
```

#### RDP Connection
```bash
# Connect to internal RDP server
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123

# With additional options
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123 /cert-ignore +clipboard
```

#### Other Tools
```bash
# SMB enumeration
proxychains smbclient -L //172.16.5.19 -U username

# Web requests
proxychains curl http://172.16.5.20

# SSH to internal host
proxychains ssh user@172.16.5.30

# Database access
proxychains psql -h 172.16.5.40 -U dbuser
```

---

## Advanced Configurations

### Multiple Hop Tunneling
```bash
# Tunnel through Pivot1 to Pivot2
ssh -D 9050 user@pivot1
# On pivot1:
ssh -D 9051 user@pivot2

# Configure proxychains with chain
[ProxyList]
socks4 127.0.0.1 9050
socks4 pivot1 9051
```

### Persistent SSH Tunnel
```bash
# Keep tunnel alive with autossh
autossh -M 0 -D 9050 -N -f ubuntu@10.129.202.64

# -M 0: Disable monitoring port
# -N: No command execution
# -f: Background process
```

### SSH Config for Quick Access
Add to `~/.ssh/config`:
```
Host pivot-tunnel
    HostName 10.129.202.64
    User ubuntu
    DynamicForward 9050
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

Then simply:
```bash
ssh pivot-tunnel
```

---

## Troubleshooting

### Common Issues

**Tunnel Disconnects:**
```bash
# Add keepalive options
ssh -D 9050 -o ServerAliveInterval=60 -o ServerAliveCountMax=3 ubuntu@10.129.202.64
```

**Proxychains Not Working:**
```bash
# Verify SOCKS proxy is listening
netstat -tulpn | grep 9050

# Test proxychains config
proxychains4 -f /etc/proxychains.conf curl http://ifconfig.me

# Use proxychains4 explicitly
proxychains4 nmap -sT target
```

**Slow Performance:**
- Use `-sT` (TCP connect) not `-sS` (SYN scan)
- Reduce parallel connections in proxychains.conf
- Use specific port ranges instead of full scans

**DNS Resolution Issues:**
```bash
# Edit /etc/proxychains.conf
proxy_dns  # Uncomment this line
```

---

## Comparison with Other Methods

| Method | Speed | Stealth | Ease | Multi-Target |
|--------|-------|---------|------|--------------|
| SSH Dynamic Forward | Medium | High | Easy | Yes |
| [[Remote-Reverse Port Forwarding with SSH\|SSH Reverse Forward]] | Fast | High | Medium | No |
| [[SOCKS5 Tunneling with Chisel\|Chisel]] | Medium | Medium | Easy | Yes |
| [[SSH Pivoting with Sshuttle\|Sshuttle]] | Fast | High | Easy | Yes |
| [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding\|Meterpreter]] | Slow | Low | Hard | Yes |

**When to Use SSH Dynamic Forward:**
- You have SSH credentials
- Need access to multiple internal hosts
- Want encrypted traffic
- Proxychains is acceptable overhead

**When to Use Alternatives:**
- [[SSH Pivoting with Sshuttle|Sshuttle]]: Want transparent routing (no proxychains)
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse]]: Need specific port forward or reverse connection
- [[SOCKS5 Tunneling with Chisel|Chisel]]: Only HTTP/HTTPS allowed outbound
- [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter]]: Already have meterpreter session

---

## Operational Security

**Detection Indicators:**
- High data transfer on SSH connection
- Long-duration SSH sessions
- Proxychains process in memory
- Unusual internal network scanning patterns

**Evasion Tips:**
- Use common ports (22, 443) for SSH
- Limit scan intensity
- Mimic normal traffic patterns
- Use SSH over HTTPS ([[Web Server Pivoting with Rpivot|Rpivot alternative]])

---

## Quick Reference Card

```bash
# Basic dynamic tunnel
ssh -D 9050 user@pivot

# With keepalive
ssh -D 9050 -o ServerAliveInterval=60 user@pivot

# Background tunnel
ssh -D 9050 -N -f user@pivot

# Proxychains config
echo "socks4 127.0.0.1 9050" >> /etc/proxychains.conf

# Use with nmap
proxychains nmap -sT -Pn target

# Use with metasploit
proxychains msfconsole

# Kill tunnel
pkill -f "ssh -D 9050"
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Back to Main Index]]
- [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Port Forwarding]]
- [[SSH Pivoting with Sshuttle|Sshuttle VPN-like Pivoting]]
- [[SOCKS5 Tunneling with Chisel|Chisel SOCKS5 Alternative]]

**Tags:** #ssh #socks #dynamic-forward #proxychains #pivoting #port-forwarding