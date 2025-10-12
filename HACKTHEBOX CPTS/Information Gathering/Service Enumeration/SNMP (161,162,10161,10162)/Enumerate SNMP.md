
---

## **Basics**

- **Purpose:** Monitor and manage network devices (routers, switches, servers, IoT, etc.).
    
- **Protocol:**
    
    - UDP/161 → Queries & management
        
    - UDP/162 → Traps (asynchronous alerts)
        
- **Data Model:**
    
    - **MIB** (Management Information Base) – text file defining structure
        
    - **OID** (Object Identifier) – unique address in a hierarchical tree
        
- **Versions:**
    
    - **v1:** No authentication, no encryption.
        
    - **v2c:** Supports communities, still plain text.
        
    - **v3:** Auth + encryption, but more complex.
        
- **Community Strings:**
    
    - Act like passwords (e.g., `public`, `private`).
        
    - Sent in **plain text** (unless v3).
        
    - Weak/default strings often lead to full network enumeration.
        

---

## **Default SNMP Configuration**

Check `/etc/snmp/snmpd.conf`:

```bash
cat /etc/snmp/snmpd.conf | grep -v "#" | sed -r '/^\s*$/d'
```

Typical default settings:

```
sysLocation    Sitting on the Dock of the Bay
sysContact     Me <me@example.org>
sysServices    72
master  agentx
agentaddress  127.0.0.1,[::1]
view   systemonly  included   .1.3.6.1.2.1.1
view   systemonly  included   .1.3.6.1.2.1.25.1
rocommunity  public default -V systemonly
rocommunity6 public default -V systemonly
rouser authPrivUser authpriv -V systemonly
```

---

## **Dangerous Settings**

|Setting|Description|
|---|---|
|`rwuser noauth`|Full OID tree access **without authentication**|
|`rwcommunity <string> <IP>`|Full access from any IPv4 source|
|`rwcommunity6 <string> <IPv6>`|Same as above but for IPv6|

---

## **Enumeration & Exploitation**

### **Cheat Sheet**

|Command|Description|
|---|---|
|`snmpwalk -v2c -c <community> <IP>`|Enumerate OIDs|
|`onesixtyone -c community-strings.list <IP>`|Bruteforce community strings|
|`braa <community>@<IP>:.1.*`|Bruteforce SNMP OIDs|

---

### **1. Footprinting with snmpwalk**

Query system info when community string is known:

```bash
snmpwalk -v2c -c public 10.129.14.128
```

Key info retrieved:

- OS & version
    
- Hostname & location
    
- Running services
    
- Installed software
    
- Uptime and network interfaces
    

Example:

```
iso.3.6.1.2.1.1.1.0 = STRING: "Linux htb ..."
iso.3.6.1.2.1.1.4.0 = STRING: "mrb3n@inlanefreight.htb"
iso.3.6.1.2.1.1.5.0 = STRING: "htb"
...
```

---

### **2. Bruteforce Community Strings with OneSixtyOne**

```bash
onesixtyone -c /path/to/snmp.txt 10.129.14.128
```

Example:

```
10.129.14.128 [public] Linux htb 5.11.0-37-generic x86_64
```

**Tips:**

- Use **SecLists** wordlists.
    
- For custom naming patterns (hostnames, symbols), generate wordlists with `crunch`.
    

---

### **3. Enumerate OIDs with braa**

```bash
braa public@10.129.14.128:.1.3.6.*
```

Example output:

```
10.129.14.128:20ms:.1.3.6.1.2.1.1.1.0:Linux htb 5.11.0-34-generic
10.129.14.128:20ms:.1.3.6.1.2.1.1.4.0:mrb3n@inlanefreight.htb
10.129.14.128:20ms:.1.3.6.1.2.1.1.5.0:htb
```

---

## **Attack Flow**

1. **Port Scan**
    
    ```bash
    nmap -sU -p161 10.129.14.128
    ```
    
2. **Enumerate**
    
    - Try `snmpwalk` with `public`, `private`, etc.
        
3. **Bruteforce**
    
    - Use `onesixtyone` for guessing community strings.
        
4. **Extract Sensitive Info**
    
    - Look for:
        
        - Usernames
            
        - Network interfaces
            
        - Routing tables
            
        - Software version details
            
5. **Privilege Escalation**
    
    - Use misconfigured strings with write (`rwcommunity`) access to alter configs or pivot.
        

---

## **Key Takeaways**

- Always check for **weak or default community strings**.
    
- SNMP **v1/v2c = unencrypted**, easy to intercept and abuse.
    
- **v3 = secure** but often misconfigured.
    
- Enumerate OIDs systematically to reveal device/network details.
    

---

Would you like me to create a **cheat sheet card** with just the commands and usage examples?