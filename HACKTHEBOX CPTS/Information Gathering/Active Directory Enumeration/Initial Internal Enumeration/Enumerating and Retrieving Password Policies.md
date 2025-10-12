
## Overview
Enum domain pw policies critical for int/ext pentests. Guides pw spraying/brute-force strategy. Retrieve w/ or w/o creds via tools/methods on Linux/Win.

## 1. Enumerating with Credentials (Linux)
Tools: CrackMapExec

Command:
```
crackmapexec smb 172.16.5.5 -u avazquez -p Password123 --pass-pol
```
- Req valid creds; retrieves detailed pw policy via SMB.

## 2. Enumerating via SMB NULL Sessions (Linux)
Tools: rpcclient, enum4linux, enum4linux-ng

### Using rpcclient
Commands:
```
# Connect to RPC Client
rpcclient -U "" -N 172.16.5.5

# querydominfo to obtain information about the domain and confirm NULL session access.
rpcclient $> querydominfo

# obtain the password policy
rpcclient $> getdompwinfo
```
Output Summary:
- Min Pw Length: 8
- Pw Complexity: Enabled

### Using enum4linux
Command:
```
enum4linux -P 172.16.5.5
```
- Output: Identical policy results to rpcclient.

### Using enum4linux-ng
Commands:
```
enum4linux-ng -P 172.16.5.5 -oA ilfreight

# Displaying the contents of the output
cat ilfreight.json
```
- Output Format: JSON/YAML; clear/structured policy results.
- Note: Works over port 445; useful for automation/parsing.

## 3. Enumerating via SMB NULL Sessions (Windows)
Tools: net.exe

Commands:
```
net use \\\\DC01\\ipc$ "" /u:""
```
- Use username/password combination to attempt to connect.
```
# use username to connect
net use \\\\DC01\\ipc$ "" /u:guest

# Use username/password to connect
net use \\\\DC01\\ipc$ "password" /u:guest
```

## 4. Enumerating via LDAP Anonymous Bind (Linux)
Tools: ldapsearch

Command:
```
ldapsearch -h 172.16.5.5 -x -b "DC=INLANEFREIGHT,DC=LOCAL" -s sub "*" | grep -m 1 -B 10 pwdHistoryLength
```
- Note: Anon LDAP bind must be permitted by DC.

## 5. Enumerating with Credentials (Windows)
### Using net.exe
Command:
```
net accounts
```

### Using PowerView
Commands:
```
Import-Module .\\PowerView.ps1
Get-DomainPolicy
```
- Output Summary: Same as net accounts + GPO path/complexity flag.

## Summary
INLANEFREIGHT.LOCAL allows cred/anon enum via SMB/LDAP. Pw policy reveals safe spraying ops if cautious. Stealth/timing/best practices essential to avoid lockouts.