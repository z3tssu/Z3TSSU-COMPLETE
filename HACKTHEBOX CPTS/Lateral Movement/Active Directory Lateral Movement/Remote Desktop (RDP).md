

## Purpose / When to use

Access GUI session on target host when a user or group has RDP rights. Useful for lateral movement, data collection, and local privilege escalation.

## Fast checks

- Does `Domain Users` or other broad group have RDP rights on any host? (BloodHound queries: "Find Workstations where Domain Users can RDP.")
    
- Enumerate Remote Desktop Users on a host.
    

## Enumerating the Remote Desktop Users Group

```powershell
Get-NetLocalGroupMember -ComputerName ACADEMY-EA-MS01 -GroupName "Remote Desktop Users"
```
## Checking the Domain Users Group's Local Admin & Execution Rights using BloodHound

![[Pasted image 20251004191419.png]]

## Checking Remote Access Rights using BloodHound

![[Pasted image 20251004191459.png]]
## Tools

- From Linux: `xfreerdp`, `remmina`
    
- From Windows: `mstsc.exe`
    
- AD analysis: BloodHound, PowerView
    

## Typical post-access actions

1. Search for credentials: `Credential Manager`, cached logons, `lsass` artifacts (only if authorized).
    
2. Inspect scheduled tasks, services, open ports, and shared folders.
    
3. Look for local privilege escalation vectors (unquoted service paths, weak service permissions, outdated software).
    
4. Harvest tokens / run `whoami /priv`, check for token-related privileges.
    
5. Pivot: use host as jump for further RDP/WinRM/SQL access.
    

## Quick commands / examples

```powershell
# Enumerate Remote Desktop Users
Get-NetLocalGroupMember -ComputerName ACADEMY-EA-MS01 -GroupName "Remote Desktop Users"

# RDP from Windows
mstsc /v:ACADEMY-EA-MS01

# RDP from Linux (xfreerdp example)
xfreerdp /v:ACADEMY-EA-MS01 /u:username /p:password
```

## Operational notes

- Hosts configured as RDS or jump hosts are high-value targets.
    
- If Domain Users can RDP, prioritize auditing and harvesting on those hosts.
    
- Noisy actions (LSASS dumps, credential theft) may trigger defenses — balance with rules of engagement.
    

---

