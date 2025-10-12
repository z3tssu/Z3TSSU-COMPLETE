
## **1. Installation**

Clone the repo and install dependencies:

```bash
git clone https://github.com/cddmp/enum4linux-ng.git
cd enum4linux-ng
pip3 install -r requirements.txt
```

---

## **2. Basic Enumeration**

Run a full aggressive scan:

```bash
./enum4linux-ng.py <TARGET-IP> -A
```

Example:

```bash
./enum4linux-ng.py 10.129.14.128 -A
```

---

## **3. Example Output Breakdown**

### **Target Info**

```
[*] Target ........... 10.129.14.128
[*] Username ......... ''
[*] Random Username .. 'juzgtcsu'
[*] Password ......... ''
[*] Timeout .......... 5 second(s)
```

- Defaults to **null session** (anonymous) unless credentials provided.
    

---

### **Service Scan**

```
[*] Checking LDAP
[-] Could not connect to LDAP on 389/tcp
[*] Checking LDAPS
[-] Could not connect to LDAPS on 636/tcp
[*] Checking SMB
[+] SMB is accessible on 445/tcp
[*] Checking SMB over NetBIOS
[+] SMB over NetBIOS is accessible on 139/tcp
```

- **Key Point:** SMB open on **ports 139 and 445**.
    

---

### **NetBIOS Info**

```
[+] Got domain/workgroup name: DEVOPS
- DEVSMB <00> Workstation Service
- DEVSMB <20> File Server Service
- DEVOPS <00> Domain/Workgroup
- DEVOPS <1d> Master Browser
- DEVOPS <1e> Browser Service Elections
```

- **Workgroup/Domain:** `DEVOPS`
    
- **Host NetBIOS name:** `DEVSMB`
    

---

### **SMB Dialect Check**

```
[*] Trying on 445/tcp
[+] Supported dialects:
SMB 1.0: false
SMB 2.02: true
SMB 2.1: true
SMB 3.0: true
SMB signing required: false
```

- Supports **SMB2/SMB3**.
    
- **No SMB signing** → vulnerable to certain attacks (e.g., SMB relay).
    

---

### **RPC Session Check**

```
[*] Check for null session
[+] Server allows session using username '', password ''
[*] Check for random user session
[+] Server allows session using username 'juzgtcsu', password ''
[H] Rerunning enumeration with user 'juzgtcsu' might give more results
```

- **Null session enabled** → anonymous enumeration possible.
    
- Try rerunning with the random user for **deeper info**.
    

---

## **4. Key Tips**

- Use `-A` for **aggressive** mode to grab everything.
    
- Use a **specific username** for better results:
    
    ```bash
    ./enum4linux-ng.py <TARGET-IP> -u <USERNAME>
    ```
    
- Combine with `smbclient`, `rpcclient`, or `crackmapexec` for post-enum actions.
    
- Lack of SMB signing = **pivot point for relay or hash attacks**.
    

---
