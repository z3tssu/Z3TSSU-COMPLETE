
### **1. Server Info**

**Command:**

```bash
rpcclient $> srvinfo
```

**Output Highlights:**

- **Server Name:** `DEVSMB`
    
- **OS Version:** `6.1`
    
- **Server Type:** `0x809a03`  
    _(Indicates Wk Sv PrQ Unx NT SNT — typical for SMB servers)_
    

---

### **2. Enumerate Domains**

**Command:**

```bash
rpcclient $> enumdomains
```

**Output:**

- `DEVSMB`
    
- `Builtin`
    

---

### **3. Query Domain Info**

**Command:**

```bash
rpcclient $> querydominfo
```

**Output:**

- **Domain:** `DEVOPS`
    
- **Server:** `DEVSMB`
    
- **Comment:** `DEVSM`
    
- **Total Users:** `2`
    
- **Total Groups:** `0`
    
- **Total Aliases:** `0`
    
- **Server Role:** `ROLE_DOMAIN_PDC`
    

---

### **4. Enumerate Network Shares**

**Command:**

```bash
rpcclient $> netshareenumall
```

**Discovered Shares:**

|**Share**|**Path**|**Remark**|
|---|---|---|
|`print$`|`C:\var\lib\samba\printers`|Printer Drivers|
|`home`|`C:\home\`|INFREIGHT Samba|
|`dev`|`C:\home\sambauser\dev\`|DEVenv|
|`notes`|`C:\mnt\notes\`|CheckIT|
|`IPC$`|`C:\tmp`|IPC Service (DEVSM)|

---

### **5. Inspect Share Permissions**

**Command:**

```bash
rpcclient $> netsharegetinfo notes
```

**Output:**

- **Share Name:** `notes`
    
- **Path:** `C:\mnt\notes\`
    
- **Permissions:**
    
    - **Generic All Access**
        
    - `WRITE_OWNER_ACCESS`, `WRITE_DAC_ACCESS`, `READ_CONTROL_ACCESS`, `DELETE_ACCESS`, `SYNCHRONIZE_ACCESS`
        
- **SID:** `S-1-1-0` _(Everyone group)_
    

**Takeaway:** The `notes` share grants **full access (0x101f01ff)** to **Everyone**.

---
