### Overview

**Netsh (Network Shell)** is a built-in Windows command-line utility used to configure and manage network settings. In the context of internal penetration testing, it can be used for **port forwarding**, allowing us to pivot through a compromised Windows host by redirecting traffic to internal resources such as RDP servers.

---

### Environment Setup

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Attacker Machine|10.10.15.5|Runs RDP client (e.g., xfreerdp)|
|Pivot Host (Windows 10 User PC)|10.129.15.150|Compromised IT admin workstation (Windows)|
|Target Host (Windows Server)|172.16.5.25|Internal server with RDP running on port 3389|

|   |   |
|---|---|
|Port|Description|
|8080|Port listening on the pivot host (Netsh)|
|3389|RDP port on the internal Windows server|

---

## 1. Using Netsh to Create Port Forward

```Shell
netsh.exe interface portproxy add v4tov4 listenport=8080 listenaddress=10.129.15.150 connectport=3389 connectaddress=172.16.5.25
```

- **listenport=8080**: Port to listen on the pivot host
- **listenaddress=10.129.15.150**: IP of the pivot host (Windows 10)
- **connectport=3389**: Port to forward to on the target machine
- **connectaddress=172.16.5.25**: IP of the internal RDP target

---

## 2. Verifying the Port Forward Rule

```Shell
netsh.exe interface portproxy show v4tov4
```

Outputs configured port forwarding rules:

```Plain
Listen on ipv4:             Connect to ipv4:
Address         Port        Address         Port
--------------- ----------  --------------- ----------
10.129.15.150   8080        172.16.5.25     3389
```

---

## 3. Connecting to the Internal Host via Port Forward

```Shell
xfreerdp /v:10.129.15.150:8080 /u:victor /p:pass@123
```

- Sends the RDP request to **10.129.15.150:8080 (pivot host)**
- Traffic is forwarded by Netsh to **172.16.5.25:3389 (target server)**
- Establishes a full RDP session to the internal machine through the compromised workstation