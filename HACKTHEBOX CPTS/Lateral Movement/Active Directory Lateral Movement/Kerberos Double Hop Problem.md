
## TL;DR

- Kerberos tickets authorize access to a **specific** service/host. They are not passwords and aren’t reused across hops.
    
- WinRM/PowerShell remoting typically gives you a TGS to the first box only; no password/hash is cached, so you can’t hop again to another host (e.g., DC) from that remote session.
    
- NTLM-based logons (e.g., PSExec, SMB/LDAP) cache an NT hash in memory, which can be reused for subsequent access.
    
- Fixes: send credentials explicitly per-hop (PSCredential), or use a **RunAs** PSSession configuration (requires GUI/elevated PS), or use other approaches (CredSSP, port forwarding, process injection, RDP).
    

---

## Model the Issue

- Path: **Attack host → Host A (WinRM/PowerShell) → Host B (e.g., DC)**
    
- With Kerberos via WinRM:
    
    - You get a TGS for HTTP/WSMAN on Host A.
        
    - Your **TGT is not sent** to Host A, so Host A can’t request TGS on your behalf for Host B.
        
    - Result: AD queries, SMB/CIFS, LDAP, CIFS to Host B fail (no creds to forward).
        

---

## Indicators and Quick Checks

- From the WinRM session, `klist` shows only 1 cached ticket (e.g., HTTP/).
    
- Tools like PowerView fail to query AD: DirectoryServices “operations error occurred”.
    
- `mimikatz sekurlsa::logonpasswords` on Host A shows no user password/NTLM cached for your session (typical for Kerberos network logon).
    
- Processes like `wsmprovhost.exe` run as your user but without reusable credentials.
    

---

## When You Don’t Hit Double Hop

- **Unconstrained delegation** on Host A: your TGT accompanies the TGS; Host A can request TGS to Host B on your behalf.
    
- **RDP / Interactive logon**: password material is present; `klist` shows TGT + multiple TGS (krbtgt, CIFS, etc.); multi-hop works.
    

---

## Workaround #1 — Send Credentials with Each Hop (PSCredential)

Use when you’re inside an evil-winrm or standard WinRM shell and need to query other hosts.

1. Prepare a credential object:
    

```powershell
$SecPassword = ConvertTo-SecureString '<PASSWORD>' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('DOMAIN\User',$SecPassword)
```

2. Run your domain query/tools with `-Credential`:
    

```powershell
Import-Module .\PowerView.ps1
Get-DomainUser -SPN -Credential $Cred | Select-Object samaccountname
```

3. Verify tickets:
    

```powershell
klist
# Expect only HTTP/<this-host> (still one ticket), but queries succeed because you sent creds on each call.
```

Notes:

- Omit `-Credential` and the same command fails again.
    
- This method works even inside evil-winrm, as long as the tool supports `-Credential`.
    

---

## Workaround #2 — Register a RunAs PSSession Configuration (Eliminates Double Hop)

Use when you have **GUI access** to a Windows box (attack host/jump box) and can run **elevated** PowerShell. Not viable from evil-winrm.

1. On your GUI/elevated PS:
    

```powershell
Register-PSSessionConfiguration -Name backupadmsess -RunAsCredential DOMAIN\backupadm
# You’ll get a Windows credential prompt. Confirm warnings.
```

2. Restart WinRM on the target where you registered the config:
    

```powershell
Restart-Service WinRM
```

3. Connect using the named configuration:
    

```powershell
Enter-PSSession -ComputerName DEV01 -Credential DOMAIN\backupadm -ConfigurationName backupadmsess
```

4. Validate tickets:
    

```powershell
klist
# Expect a krbtgt ticket present (PRIMARY). Multi-hop now works.
```

5. Run tools without passing `-Credential` each time:
    

```powershell
Import-Module .\PowerView.ps1
Get-DomainUser -SPN | Select-Object samaccountname
```

Constraints:

- Requires an elevated PS console and GUI credential prompt.
    
- Not supported in evil-winrm or typical Linux PowerShell environments due to Kerberos/RunAs limitations.
    

---

## Other Approaches (Brief)

- **CredSSP**: Allows delegation of credentials to the remote server. Useful but increases credential exposure risk.
    
- **RDP**: Interactive logon gives you TGT/TGS and often bypasses double hop.
    
- **Port forwarding / Proxying**: Run tools locally through tunnels to the DC instead of from the remote session.
    
- **Sacrificial process injection**: Inject into a process running under a target user that already has reusable credentials.
    
- **PSExec / SMB**: Authenticate via NTLM; hash material is available and often allows multi-hop.
    

---

## Playbooks

### A. Evil-WinRM and Need AD Enumeration Now

```powershell
# Inside evil-winrm session on Host A
$SecPassword = ConvertTo-SecureString '<PASSWORD>' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('DOMAIN\User',$SecPassword)

Import-Module .\PowerView.ps1
Get-DomainUser -SPN -Credential $Cred | Select samaccountname
```

### B. Windows Jump Host (GUI) to Remote Host via WinRM (No Credential Flags Later)

```powershell
# Elevated PS on jump host
Register-PSSessionConfiguration -Name JumpSess -RunAsCredential DOMAIN\User
Restart-Service WinRM

Enter-PSSession -ComputerName HOSTA -Credential DOMAIN\User -ConfigurationName JumpSess
klist    # Should show krbtgt ticket
# Now run multi-hop commands/tools without -Credential
```

### C. Prove It’s Double Hop

```powershell
# From WinRM session:
klist
# Only HTTP/<hostA> ticket visible

# Try AD query without creds
Import-Module .\PowerView.ps1
Get-DomainUser -SPN
# Expect DirectoryServices COM error
```

---

