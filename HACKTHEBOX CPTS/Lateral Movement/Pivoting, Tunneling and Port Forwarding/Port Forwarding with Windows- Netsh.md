# Port Forwarding with Windows Netsh

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]
**Related:** [[SSH for Windows- plink.exe|Plink.exe]], [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP]], [[Socat Redirection with Bind Shell|Socat]]

---

## Overview

Netsh (Network Shell) is a built-in Windows command-line utility for network configuration. It provides native port forwarding capabilities without requiring additional tools, making it ideal for pivoting through compromised Windows systems.

**Key Features:**
- Built-in to Windows (no upload required)
- Port forwarding (portproxy)
- IPv4 and IPv6 support
- Persistent across reboots
- No external dependencies

**Use Cases:**
- Windows pivot host
- Need port forwarding without external tools
- "Living off the land" techniques
- Persistent port forward required
- Admin access available

**Advantages:**
- Native Windows tool (no AV alerts)
- Persistent configuration
- Supports multiple forwards
- Simple syntax
- IPv6 capable

**Requirements:**
- Administrator privileges
- Windows XP and later
- IP Helper service running

---

## Network Topology

```
Attack Machine → Windows Pivot (Netsh) → Internal Target
(10.10.15.5)     (10.129.15.150:8080)    (172.16.5.25:3389)
  Connects        Port Forward            RDP Server
```

### Environment Details

| Component | IP/Port | Description |
|-----------|---------|-------------|
| Attack Machine | 10.10.15.5 | Runs RDP client |
| Windows Pivot | 10.129.15.150:8080 | Compromised workstation |
| Internal Target | 172.16.5.25:3389 | Windows Server with RDP |

---

## Basic Port Forwarding

### Create Port Forward Rule

```cmd
netsh.exe interface portproxy add v4tov4 listenport=8080 listenaddress=10.129.15.150 connectport=3389 connectaddress=172.16.5.25
```

**Parameters:**
- `listenport=8080`: Port on pivot to listen
- `listenaddress=10.129.15.150`: Pivot's external IP
- `connectport=3389`: Target service port
- `connectaddress=172.16.5.25`: Internal target IP

### Verify Port Forward

```cmd
netsh.exe interface portproxy show v4tov4
```

### Connect Through Forward

```bash
# From attack machine
xfreerdp /v:10.129.15.150:8080 /u:victor /p:pass@123 /cert-ignore
```

---

## Management Commands

### Show All Rules

```cmd
netsh.exe interface portproxy show v4tov4
```

### Delete Specific Rule

```cmd
netsh.exe interface portproxy delete v4tov4 listenport=8080 listenaddress=10.129.15.150
```

### Delete All Rules

```cmd
netsh.exe interface portproxy reset
```

---

## Firewall Configuration

### Allow Port Through Firewall

```cmd
netsh advfirewall firewall add rule name="Port Forward 8080" dir=in action=allow protocol=TCP localport=8080
```

---

## Quick Reference

```cmd
# Add forward
netsh interface portproxy add v4tov4 listenport=LP listenaddress=LIP connectport=CP connectaddress=CIP

# Show rules
netsh interface portproxy show v4tov4

# Delete specific
netsh interface portproxy delete v4tov4 listenport=LP listenaddress=LIP

# Delete all
netsh interface portproxy reset

# Add firewall rule
netsh advfirewall firewall add rule name="NAME" dir=in action=allow protocol=TCP localport=PORT
```

---

**See Also:**
- [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
- [[SSH for Windows- plink.exe|Plink SSH for Windows]]
- [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP|SocksOverRDP Tunneling]]
- [[Socat Redirection with Bind Shell|Socat Port Redirection]]

**Tags:** #netsh #windows-pivoting #port-forwarding #native-tool #portproxy #living-off-the-land