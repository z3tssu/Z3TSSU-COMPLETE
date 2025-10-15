# ICMP Tunneling with SOCKS

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[DNS Tunnelling with Dnscat2|DNS Tunneling]], [[SSH Socks Tunnel PF|SSH SOCKS Tunnel]], [[Web Server Pivoting with Rpivot|Rpivot]]

---

## Overview

ICMP tunneling encapsulates traffic within ICMP echo request/response packets (ping). This covert channel bypasses firewalls that allow ICMP but block other protocols. Useful for exfiltration and pivoting when only ICMP egress is permitted.

**Key Features:**
- Tunnels data in ICMP packets
- Bypasses strict firewalls
- Covert communication channel
- SSH-over-ICMP capable
- Stealth data exfiltration

**Use Cases:**
- Only ICMP allowed outbound
- All TCP/UDP ports blocked
- Extreme firewall restrictions
- Need covert C2 channel
- Data exfiltration via ping

**Requirements:**
- Root/admin on both ends
- ICMP echo allowed through firewall
- Network stack manipulation capability

---

## Tool: ptunnel-ng

### Installation

```bash
# Clone and build
git clone https://github.com/utoni/ptunnel-ng.git
cd ptunnel-ng
sudo apt-get install automake autoconf -y
sudo ./autogen.sh
```

### Transfer to Pivot

```bash
scp -r ptunnel-ng ubuntu@10.129.202.64:~/
```

---

## Basic Setup

### Server on Pivot

```bash
cd ptunnel-ng/src
sudo ./ptunnel-ng -r10.129.202.64 -R22
```

### Client on Attack Machine

```bash
sudo ./ptunnel-ng -p10.129.202.64 -l2222 -r10.129.202.64 -R22
```

### Connect via SSH

```bash
ssh -p 2222 -l ubuntu 127.0.0.1
```

---

## SOCKS Proxy Over ICMP

### Enable Dynamic Forward

```bash
ssh -D 9050 -p 2222 -l ubuntu 127.0.0.1
```

### Configure Proxychains

```bash
# /etc/proxychains.conf
socks5 127.0.0.1 9050
```

### Use Tools

```bash
proxychains nmap -sT -Pn 172.16.5.19
proxychains xfreerdp /v:172.16.5.19 /u:admin /p:pass
```

---

## Performance Notes

**Expected Speed:** 1-5 KB/s (very slow)
**Latency:** High
**Best for:** C2 channels, not bulk transfer

---

## Comparison with Other Covert Channels

| Feature | ICMP | [[DNS Tunnelling with Dnscat2\|DNS]] | [[Web Server Pivoting with Rpivot\|HTTP]] |
|---------|------|------|------|
| Speed | Very Slow | Slow | Fast |
| Stealth | Very High | High | Medium |
| Firewall Bypass | Excellent | Excellent | Good |

---

## Quick Reference

```bash
# Server (pivot)
sudo ./ptunnel-ng -r PIVOT_IP -R22

# Client (attacker)
sudo ./ptunnel-ng -p PIVOT_IP -l2222 -r PIVOT_IP -R22

# SSH through tunnel
ssh -p 2222 ubuntu@127.0.0.1

# SSH with SOCKS
ssh -D 9050 -p 2222 ubuntu@127.0.0.1

# With password
sudo ./ptunnel-ng -p PIVOT_IP -l2222 -r PIVOT_IP -R22 -xPASSWORD
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[DNS Tunnelling with Dnscat2|DNS Covert Channel]]
- [[SSH Socks Tunnel PF|SSH SOCKS Tunnel]]
- [[Defending and Detection/Defending and Detection|Detection & Defense]]

**Tags:** #icmp-tunnel #covert-channel #ptunnel-ng #firewall-bypass #stealth #ping-tunnel