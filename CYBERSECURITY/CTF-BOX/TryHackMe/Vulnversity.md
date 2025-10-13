# Vulnversity

> **Source:** TryHackMe  
> **Tags:** #ctf #tryhackme #web-exploitation #upload-bypass

---

## Enumeration

### Initial Nmap Scan
```bash
nmap -sv ip_address
```

**Results:** (Check screenshot for detailed output)

---

### Directory Bruteforce

**Tool:** Gobuster
```bash
gobuster dir -u http://10.10.120.83:3333 -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt
```

**Identified Directory:**
```bash
/internal/
```

The `/internal/` directory contains an upload page.

---

## Exploitation

### Compromising the Webserver

**Objective:** Exploit the upload functionality to gain access

**Steps:**
1. Identify upload restrictions
2. Bypass file upload filters
3. Upload reverse shell
4. Execute payload
5. Gain access

```bash
# Commands and payloads to be added here
```

---

## Notes

- Target IP: 10.10.120.83
- Open ports: 3333 (web service)
- Upload page location: /internal/

---

**Status:** In Progress  
**Difficulty:** Easy  
**Last Updated:** {{date}}