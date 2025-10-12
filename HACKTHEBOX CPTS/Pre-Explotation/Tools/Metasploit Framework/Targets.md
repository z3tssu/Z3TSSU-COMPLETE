

## What Are Targets

- Targets define **specific OS and software combinations** an exploit is built for.
    
- Picking the correct target ensures **payload compatibility** and accurate return addresses.
    

---

## Showing Targets

**Command:**

```
msf6 > show targets
```

- Use this **inside an exploit module** to list all available configurations.
    
- Using it **outside a module** = error:
    
    ```
    No exploit module selected.
    ```
    

---

## Target Structure Example

```
msf6 exploit(windows/smb/ms17_010_psexec) > show targets

Id  Name
--  ----
0   Automatic
1   IE 7 on Windows XP SP3
2   IE 8 on Windows XP SP3
```

---

## Target Selection

**Command:**

```
msf6 exploit(windows/browser/ie_execcommand_uaf) > set target 6
```

- `set target <ID>` selects the target manually.
    
- If left as `0 (Automatic)`, Metasploit tries to auto-detect the version during exploitation.
    

---

## Checking Module Info

**Command:**

```
msf6 > info
```

- Always review module details to:
    
    - Understand what the exploit does.
        
    - Identify supported targets.
        
    - Read usage notes and warnings.
        

---

## Return Address Relevance

Target differences often include:

- OS version
    
- Service Pack level
    
- Language
    
- DLL versions
    

These impact return address logic:

- `jmp esp`
    
- `pop pop ret`
    
- Other return address offsets.
    

---

## Tools for Target Research

- **Exploit comments:** Often explain compatible OS/service versions.
    
- **msfpescan:** Finds return addresses in binaries — useful for exploit dev and custom payload tuning.
    

---

## Summary of Commands

```
# Show available targets (inside a module)
show targets

# Set a specific target
set target <ID>

# View module information
info
```