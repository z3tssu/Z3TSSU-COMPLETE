

## MITRE ATT&CK Framework

- **Initial Access**
    
    - Public-facing services (web apps, SMB, RDP)
        
    - Weak authentication or misconfigurations
        
    - Reference: MITRE, OWASP Top 10
        
- **Execution**
    
    - Code execution on victim host
        
    - Examples: PowerShell, webshells, Metasploit payloads
        
    - Often tied to exploits or command injection
        
- **Command & Control (C2)**
    
    - Remote interaction after gaining shell access
        
    - Common channels: HTTP(S), DNS, Slack, Discord, Netcat, Meterpreter
        
    - Blends with normal traffic to avoid detection
        

---

## Key Events to Monitor

- **File Uploads**
    
    - Watch for suspicious uploads (e.g., shell.php, upload.aspx)
        
    - Monitor app logs, AV alerts, firewall logs
        
    - Mitigate with WAFs, AV scanning, restricted file types
        
- **Suspicious User Actions**
    
    - Non-admins running `whoami`, `net user`, `ipconfig`, etc.
        
    - Lateral SMB traffic between hosts (rare for normal users)
        
    - Use command-line logging, PowerShell transcripts, SIEM alerts
        
- **Anomalous Network Sessions**
    
    - Unusual ports (e.g., 4444) or uncommon protocols
        
    - Bulk POST/GET requests
        
    - Netcat sessions: cleartext traffic, easy to spot in Wireshark, Zeek, NetFlow
        

---

## Establish Network Visibility

- **Good Practices**
    
    - Document hosts, flows, and devices
        
    - Create network topology diagrams
        
    - Understand baseline traffic (apps, IPs, protocols, ports)
        
- **Tools**
    
    - **NetBrain:** Interactive network maps, config management
        
    - **Cisco Meraki / Ubiquiti / Palo Alto / Check Point:** Cloud dashboards, Layer 7 visibility
        
    - **SIEM (Splunk, ELK):** Log correlation, event triage
        
    - **Firewall/IDS logs:** Monitor traffic, unusual access, shell usage
        

---

## Real-World Example

- **Wireshark Capture**
    
    - Reverse shell to port 4444
        
    - Commands observed:
        
        ```
        net user hacker Passw0rd! /add
        net localgroup administrators hacker /add
        ```
        

---

## Endpoint Protection

- **What Counts as Endpoints**
    
    - Workstations, servers, printers, NAS, smart devices, cameras
        
- **Basic Defenses**
    
    - Enable Windows Defender and Firewall (all profiles ON)
        
    - Patch management strategy in place
        
    - Behavioral monitoring (Sysmon, EDR)
        
    - Restrict admin rights via Group Policy or LAPS
        
    - Monitor process creation and parent-child process relationships
        

---

## Common Mitigations

- **Application Sandboxing**
    
    - Isolate apps to reduce risk (e.g., Docker, AppArmor)
        
- **Least Privilege**
    
    - Limit access rights to what’s necessary
        
    - No domain admin rights for regular users
        
- **Host Segmentation & Hardening**
    
    - Follow STIGs for hardening
        
    - Place exposed hosts in DMZs
        
- **Firewalls**
    
    - Filter unnecessary ports
        
    - Deny inbound on common shell ports (e.g., 4444)
        
    - Use NAT and strict ACLs
        

---

## Core Defensive Takeaways

- Detect webshell uploads using AV/WAF and strict filetype filters
    
- Monitor for unauthorized commands and behavior
    
- Watch NetFlow and look for unusual traffic (port 4444, DNS tunneling, etc.)
    
- Correlate endpoint and network data (e.g., Wireshark + Sysmon logs)
    
- Harden exposed systems, patch quickly, and enforce least privilege