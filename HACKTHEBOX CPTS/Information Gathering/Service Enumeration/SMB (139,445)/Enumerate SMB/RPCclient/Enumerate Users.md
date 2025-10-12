
### **1. Enumerate Users**

```bash
rpcclient $> enumdomusers
```

**Output:**

- `user:[mrb3n] rid:[0x3e8]`
    
- `user:[cry0l1t3] rid:[0x3e9]`
    

---

### **2. Query User Info**

Use the RID (Relative Identifier) from `enumdomusers`.

**Command:**

```bash
rpcclient $> queryuser <RID>
```

---

#### **User: cry0l1t3**

**Command:**

```bash
rpcclient $> queryuser 0x3e9
```

**Key Info:**

- **Username:** `cry0l1t3`
    
- **Home Drive:** `\\devsmb\cry0l1t3`
    
- **Profile Path:** `\\devsmb\cry0l1t3\profile`
    
- **Password Last Set:** `22 Sep 2021 17:50:56`
    
- **Group RID:** `0x201`
    
- **Logon Count:** `0`
    

---

#### **User: mrb3n**

**Command:**

```bash
rpcclient $> queryuser 0x3e8
```

**Key Info:**

- **Username:** `mrb3n`
    
- **Home Drive:** `\\devsmb\mrb3n`
    
- **Profile Path:** `\\devsmb\mrb3n\profile`
    
- **Password Last Set:** `22 Sep 2021 17:47:59`
    
- **Group RID:** `0x201`
    
- **Logon Count:** `0`
    

---

### **3. Key Takeaways**

- Both users (`mrb3n`, `cry0l1t3`) are present.
    
- Passwords last updated **September 2021**.
    
- No logon activity recorded.
    
- Useful for **further enumeration** or **brute force/password spraying** attempts.
    

---

Would you like me to create a printable **cheat sheet PDF** version of these notes?