
### **1. List SMB Shares**

```bash
smbclient -N -L //<IP>
```

**Example:**

```bash
smbclient -N -L //10.129.14.128
```

**Output:**

|**Sharename**|**Type**|**Comment**|
|---|---|---|
|`print$`|Disk|Printer Drivers|
|`home`|Disk|INFREIGHT Samba|
|`dev`|Disk|DEVenv|
|`notes`|Disk|CheckIT|
|`IPC$`|IPC|IPC Service (DEVSM)|

> **Tip:**  
> If SMB1 is disabled, you’ll see:  
> `SMB1 disabled -- no workgroup available`

---

### **2. Connect to a Share**

```bash
smbclient //<IP>/<share>
```

**Example:**

```bash
smbclient //10.129.14.128/notes
```

- When prompted for a password, **press Enter** for **anonymous login** if allowed.
    

---

### **3. Inside the SMB Session**

Use `help` to list all available commands:

```bash
smb: \> help
```

Commonly used commands:

|**Command**|**Description**|
|---|---|
|`ls`|List files in the share|
|`cd <dir>`|Change directory|
|`get <file>`|Download a file|
|`put <file>`|Upload a file (if write perms)|
|`mget *`|Download multiple files|
|`recurse on`|Enable recursive mode for deep directories|
|`exit`|Close session|

---

### **4. Example: Listing Files**

```bash
smb: \> ls
```

**Output:**

```
  .                                   D        0  Wed Sep 22 18:17:51 2021
  ..                                  D        0  Wed Sep 22 12:03:59 2021
  prep-prod.txt                       N       71  Sun Sep 19 15:45:21 2021

                30313412 blocks of size 1024. 16480084 blocks available
```

**Takeaway:**

- Found file: `prep-prod.txt`
    
- Size: `71 bytes`
    
- Modified: `19 Sep 2021`
    

---

### **5. Quick Workflow**

1. **Enumerate shares**
    
    ```bash
    smbclient -N -L //<IP>
    ```
    
2. **Connect to share**
    
    ```bash
    smbclient //<IP>/<share>
    ```
    
3. **List files and download**
    
    ```bash
    smb: \> ls
    smb: \> get <file>
    ```
    
4. **Check permissions** for uploads with:
    
    ```bash
    smb: \> put <file>
    ```
    

---

