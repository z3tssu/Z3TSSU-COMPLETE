### Overview

**Plink** is a command-line SSH client for Windows, part of the **PuTTY** suite. It can be used for:

- Creating **dynamic port forwarding**
- Establishing **SOCKS proxy tunnels**
- Enabling **pivoting** from a compromised Windows system  
    It is especially useful in older environments or when tools must be used stealthily (“living off the land”).

---

### Environment Setup

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Windows Attack Host|10.10.15.5|Hosts Plink.exe and Proxifier|
|Pivot Host (Ubuntu)|10.129.15.50|SSH server for Plink tunnel|
|Windows Target (RDP)|172.16.5.19|Victim host with RDP service|

|   |   |
|---|---|
|Port|Description|
|9050|SOCKS proxy listener on the attacker's local host|
|3389|RDP service on the Windows target|

---

## 1. Using Plink for Dynamic Port Forwarding

```Shell
plink -ssh -D 9050 ubuntu@10.129.15.50
```

- Creates an SSH connection from the **Windows attack host** to the **Ubuntu pivot host**
- Starts a **SOCKS proxy listener on 127.0.0.1:9050** on the Windows host
- Traffic sent to this port will be forwarded dynamically through the SSH tunnel

---

## 2. Configuring Proxifier (Windows Tool)

- **Add SOCKS Proxy:**
    - Address: `127.0.0.1`
    - Port: `9050`
    - Type: `SOCKS4`
- Proxifier will route selected application traffic through this proxy.

---

## 3. Starting RDP Connection via Tunnel

```Shell
mstsc.exe
```

- Use **Proxifier** to route the RDP session via the SOCKS proxy on port 9050
- Enables access to **172.16.5.19:3389 (RDP target)** through the SSH tunnel

---

## Use Case Scenarios

- Pivoting from a **Windows machine without native SSH**
- Leveraging already-installed tools (e.g., PuTTY suite)
- Creating stealthy tunnels to bypass firewall restrictions

---

Let me know if you'd like to expand this into a visual workflow or need an export format like PDF or DOCX.