> Sshuttle is another tool written in Python which removes the need to configure proxychains.

### Overview

**Sshuttle** is a Python-based tool that creates a **transparent proxy** over SSH. It allows routing of network traffic through a remote server **without needing to configure proxychains or SOCKS**.

Sshuttle automates:

- Creation of `iptables` rules
- Redirection of traffic through the SSH connection  
    It is ideal for **pivoting through SSH** to access internal networks from a compromised or accessible pivot point.

---

### Environment Setup

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Attacker Machine|10.10.14.18|Running `sshuttle` and scanning tools (e.g., Nmap)|
|Pivot Host|10.129.202.64|Ubuntu server with SSH access|
|Target Machine|172.16.5.19|Windows machine with RDP (port 3389)|

|   |   |
|---|---|
|Port|Description|
|22|SSH port on pivot host|
|3389|RDP port on Windows target|
|12300|Local redirector port created by sshuttle|

---

## 1. Installing sshuttle on the Attacker Machine

```Shell
sudo apt-get install sshuttle
```

Installs the sshuttle tool to enable transparent proxying over SSH.

---

## 2. Running sshuttle to Pivot via SSH

```Shell
sudo sshuttle -r ubuntu@10.129.202.64 172.16.5.0/23 -v
```

- `r ubuntu@10.129.202.64`: SSH into pivot host
- `172.16.5.0/23`: Subnet to be routed through the pivot
- Creates iptables NAT rules and a transparent proxy at `127.0.0.1:12300`

**Effect:**  
All traffic to the `172.16.5.0/23` network is transparently routed through the Ubuntu pivot host over SSH.

---

## 3. Verifying Routing with Nmap

```Shell
nmap -v -sV -p3389 172.16.5.19 -A -Pn
```

- Performs a service/version scan on the Windows target
- Traffic reaches the internal network via sshuttle without needing proxychains

**Expected Output:**

- Port 3389 open
- Windows Terminal Services (RDP)
- Domain and computer name details (via rdp-ntlm-info)

---