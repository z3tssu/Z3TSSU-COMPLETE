
## **Overview**

- NSE (Nmap Scripting Engine) allows the **creation and execution of Lua scripts** to interact with various services.
    
- Scripts are divided into **14 categories** based on the type of tasks they perform.
    

---

## **Defining Scripts in Nmap**

### **1. Default Scripts**

- **Command Example:**
    
    ```bash
    sudo nmap <target> -sC
    ```
    

### **2. Specific Script Category**

- **Command Example:**
    
    ```bash
    sudo nmap <target> --script <category>
    ```
    

### **3. Defined Scripts (Multiple Specific Scripts)**

- **Command Example:**
    
    ```bash
    sudo nmap <target> --script <script-name>,<script-name>
    ```
    

---

## **Example: Specifying Scripts on an SMTP Port**

**Scenario:** Use two scripts (`banner` and `smtp-commands`) against SMTP port (25).

- **Command:**
    
    ```bash
    sudo nmap 10.129.2.28 -p 25 --script banner,smtp-commands
    ```
    

**Sample Output:**

```
PORT   STATE SERVICE
25/tcp open  smtp
|_banner: 220 inlane ESMTP Postfix (Ubuntu)
|_smtp-commands: inlane, PIPELINING, SIZE 10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN, SMTPUTF8,
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

**Options Explained:**

- `10.129.2.28` → Target IP
    
- `-p 25` → Scan only port 25
    
- `--script banner,smtp-commands` → Run specified NSE scripts
    

**Key Observations:**

- `banner` script reveals SMTP server banner (Ubuntu distribution info)
    
- `smtp-commands` script enumerates available SMTP commands (useful for user identification)
    

---

## **Aggressive Scan Option (-A)**

**Purpose:** Combines multiple options:

- Service detection (`-sV`)
    
- OS detection (`-O`)
    
- Traceroute (`--traceroute`)
    
- Default NSE scripts (`-sC`)
    

**Command Example:**

```bash
sudo nmap 10.129.2.28 -p 80 -A
```

**Sample Output (Partial):**

```
PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
|_http-generator: WordPress 5.3.4
|_http-server-header: Apache/2.4.29 (Ubuntu)
|_http-title: blog.inlanefreight.com
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)
```

**Options Explained:**

- `10.129.2.28` → Target IP
    
- `-p 80` → Scan only port 80
    
- `-A` → Aggressive scan (combines multiple advanced scan options)
    

**Key Findings:**

- Identifies web server (Apache 2.4.29 on Ubuntu)
    
- Detects web application (WordPress 5.3.4) and page title
    
- Provides OS detection (Linux, ~96% confidence)
    

---

## **Vulnerability Assessment (Vuln Category)**

**Goal:** Check HTTP service (port 80) for known vulnerabilities.

**Command:**

```bash
sudo nmap 10.129.2.28 -p 80 -sV --script vuln
```

**Sample Output (Partial):**

```
PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.29 ((Ubuntu))
| http-enum:
|   /wp-login.php: Possible admin folder
|   /: WordPress version: 5.3.4
| http-wordpress-users:
|   Username found: admin
| vulners:
|   cpe:/a:apache:http_server:2.4.29:
|      CVE-2019-0211   7.2  https://vulners.com/cve/CVE-2019-0211
|      CVE-2018-1312   6.8  https://vulners.com/cve/CVE-2018-1312
```

**Options Explained:**

- `10.129.2.28` → Target IP
    
- `-p 80` → Scan only port 80
    
- `-sV` → Service version detection
    
- `--script vuln` → Run all vulnerability-related NSE scripts
    

**What the Scripts Do:**

- Enumerate web directories and server information
    
- Check version details
    
- Query vulnerability databases for known exploits (e.g., via `vulners` script)
    

---

## **Additional Resources**

- [Nmap Scripting Engine Documentation](https://nmap.org/book/nse.html)
    
- [Nmap Script Categories](https://nmap.org/nsedoc/)

## Updating Scripting Engine
```bash
z3tssu@htb[/htb]$ sudo nmap --script-updatedb

Starting Nmap 7.80 ( https://nmap.org ) at 2021-09-19 13:49 CEST
NSE: Updating rule database.
NSE: Script Database updated successfully.
Nmap done: 0 IP addresses (0 hosts up) scanned in 0.28 seconds
```
## Nmap Script Location
All the NSE scripts are located on the Pwnbox in `/usr/share/nmap/scripts/`, but on our systems, we can find them using a simple command on our system.

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FK3YP1U2Fck03eUZ2XijJ%2Fuploads%2FZu1gj9Tyh982jh45irhF%2Fimage.png?alt=media&token=5259f28e-9f36-49ec-a856-d736e1e7ea08)

```bash

z3tssu@htb[/htb]$ find / -type f -name ftp* 2>/dev/null | grep scripts

/usr/share/nmap/scripts/ftp-syst.nse

/usr/share/nmap/scripts/ftp-vsftpd-backdoor.nse

/usr/share/nmap/scripts/ftp-vuln-cve2010-4221.nse

/usr/share/nmap/scripts/ftp-proftpd-backdoor.nse

/usr/share/nmap/scripts/ftp-bounce.nse

/usr/share/nmap/scripts/ftp-libopie.nse

/usr/share/nmap/scripts/ftp-anon.nse

/usr/share/nmap/scripts/ftp-brute.nse
```