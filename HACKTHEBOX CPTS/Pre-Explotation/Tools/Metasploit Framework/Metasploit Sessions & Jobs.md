

## Purpose

- Control multiple modules **simultaneously**
    
- Switch, background, and manage active connections
    
- Each session provides a **dedicated interface** for communication with a target
    

---

## Managing Sessions

### Background a Session

After successful exploitation:

- Keyboard shortcut:
    

```
CTRL + Z
```

- Or command:
    

```
background
```

---

### List Active Sessions

```
sessions
```

**Example output:**

```
Id  Name  Type                     Information                 Connection
--  ----  ----                     -----------                 ----------
1         meterpreter x86/windows  NT AUTHORITY\SYSTEM @ MS01  10.10.10.129:443 -> 10.10.10.205:50501
```

---

### Interact with a Session

```
sessions -i 1
```

**Output:**

```
[*] Starting interaction with 1...
meterpreter >
```

---

### Post-Exploitation Modules

Run modules against active sessions by setting the **SESSION** parameter.

**Common Categories:**

- `post/windows/gather/` – Collect info from Windows targets
    
- `post/multi/recon/` – Network or host recon
    
- `post/multi/manage/` – Manage sessions or hosts
    

---

## Jobs

### What Are Jobs

- **Background tasks** created with modules
    
- Useful for persistence, multi-tasking, or freeing up ports
    

---

### View Running Jobs

```
jobs -l
```

**Example:**

```
Id  Name                    Payload                    Payload opts
--  ----                    -------                    ------------
0   Exploit: multi/handler  generic/shell_reverse_tcp  tcp://10.10.14.34:4444
```

---

### Kill Jobs

**Kill one job by ID:**

```
jobs -k 0
```

**Kill all jobs:**

```
jobs -K
```

---

### Jobs Help Menu

```
jobs -h
```

**Options:**

- `-l` : List all jobs
    
- `-k` : Kill job by ID
    
- `-K` : Kill all jobs
    
- `-i` : Detailed job info
    

---

## Running Exploits as Jobs

Run an exploit in the background:

```
exploit -j
```

**Example output:**

```
[*] Exploit running as background job 0.
[*] Exploit completed, but no session was created.
[*] Started reverse TCP handler on 10.10.14.34:4444
```

---

### Exploit Help Menu

```
exploit -h
```

Use this to view **options and flags** for running exploits efficiently.