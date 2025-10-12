# Hardening Active Directory

Goal: Understand defenses against common TTPs (e.g., from this module) to improve client security posture as pentesters. Basic hardening > fancy EDR/SIEM without baseline (logging, docs, host tracking).

## Step One: Document and Audit
AD hardening contains attackers, prevents lateral movement/priv esc/access to sensitive data. Key: Know your AD env fully. Audit annually (or every few months) for up-to-date records.

### Things To Document and Track
- Naming conventions of OUs, computers, users, groups
- DNS, network, and DHCP configurations
- Intimate understanding of all GPOs and the objects they are applied to
- Assignment of FSMO roles
- Full and current application inventory
- A list of all enterprise hosts and their location
- Any trust relationships we have with other domains or outside entities
- Users who have elevated permissions

## People, Processes, and Technology
Breakdown: Hardening covers hardware/software/human aspects.

### People
Users = weakest link even in hardened envs. Enforce best practices for users/admins to prevent easy wins. Educate on threats.

Measures:
- Strong password policy + filter disallowing common words (e.g., welcome, password, months/days/seasons, company name). Use enterprise password manager for complex pw help.
- Rotate passwords periodically for all service accounts.
- Disallow local admin access on user workstations unless specific business need.
- Disable default RID-500 local admin; create new admin acct subject to LAPS pw rotation.
- Implement split tiers of admin for admin users (avoid DA creds on daily workstations).
- Clean up privileged groups (e.g., limit Domain/Enterprise Admins to essential users only).
- Where appropriate, place accounts in Protected Users group.
- Disable Kerberos delegation for admin accts (Protected Users may not cover this).

#### Protected Users Group
Introduced in Windows Server 2012 R2. Restricts privileged members' actions in domain. Prevents cred abuse from memory on hosts.

Command to view:
```
PS C:\Users\htb-student> Get-ADGroup -Identity "Protected Users" -Properties Name,Description,Members
```
Output example:
```
Description       : Members of this group are afforded additional protections against authentication security threats.
                    See http://go.microsoft.com/fwlink/?LinkId=298939 for more information.
DistinguishedName : CN=Protected Users,CN=Users,DC=INLANEFREIGHT,DC=LOCAL
GroupCategory     : Security
GroupScope        : Global
Members           : {CN=sqlprod,OU=Service Accounts,OU=IT,OU=Employees,DC=INLANEFREIGHT,DC=LOCAL, CN=sqldev,OU=Service
                    Accounts,OU=IT,OU=Employees,DC=INLANEFREIGHT,DC=LOCAL}
Name              : Protected Users
ObjectClass       : group
ObjectGUID        : e4e19353-d08f-4790-95bc-c544a38cd534
SamAccountName    : Protected Users
SID               : S-1-5-21-2974783224-3764228556-2640795941-525
```

From Microsoft docs:
- Title: Protected Users Security Group
- Key points: Domain global group in Win Server 2012 R2 (applies to Win 8.1/2012 R2). Non-configurable protections reduce cred compromise risk. Restrictive membership, secure by default. SID: S-1-5-21-<domain>-525. In CN=Users container. No default members/member-of. Not protected by ADMINSDHOLDER. Safe to move container, but don't delegate mgmt to non-service admins. No default user rights.
- Protections: Auto on Win Server 2012 R2/Win 8.1 devices/hosts and DCs in 2012 R2+ domains. Minimizes cred memory footprint on non-compromised computers.
  - No NTLM, Digest Auth, CredSSP auth; no pw caching on Win 8.1 (fails these SSPs).
  - Kerberos pre-auth skips DES/RC4 (needs AES support).
  - No constrained/unconstrained Kerberos delegation (may fail prior connections).
  - TGT lifetime: 4 hrs (600 min), non-renewable w/o re-auth; configurable via Auth Policies/Silos in ADAC.
  - At 2012 R2 domain func level: No plain text cred caching for CredSSP (even if GPO allows), no Windows Digest caching (even if enabled), no NTLM NTOWF caching, no Kerberos long-term key caching (per-request verify), no offline sign-in verifier.
  - Built-in: No NTLM, no DES/RC4 in Kerberos pre-auth, no delegation, no TGT renewal >4 hrs.
- Apply after group add + domain sign-in. Replicate to all DCs in acct domain for client protection; devices must be Win 8.1/2012 R2+. Domain func level 2012 R2 for DC protection. Pre-2012 R2 levels: Protections activate post-replication + sign-in.
- Notes: Don't add service/computer accts (no local protection, auth fails w/ "incorrect pw"). Troubleshooting: Event logs (Applications/Services Logs\Microsoft\Windows\Auth\ProtectedUser-Client: IDs 104/304 for cred issues; ProtectedUserFailures-DomainController: 100/104 for NTLM/Kerberos fails; ProtectedUserSuccesses-DomainController: 303 for TGT issuance). Create/replicate group by transferring PDC emulator to 2012 R2 DC if needed.

Note: Can cause auth issues/lockouts. Never add all privileged users w/o staged testing.

### Processes
	Enforce policies/procedures for security posture. Defined policies enable accountability; practiced procedures (e.g., DR plan) aid incident response.
	
	Items:
	- Proper policies/procedures for AD asset mgmt.
	- AD host audit, asset tags, periodic inventories to prevent lost hosts.
	- Access control policies (user provisioning/de-provisioning), MFA mechanisms.
	- Processes for provisioning/decommissioning hosts (e.g., baseline hardening guidelines, gold images).
	- AD cleanup policies:
	  - Former employee accts: Removed or just disabled?
	  - Process for removing stale AD records?
	- Processes for decommissioning legacy OS/services (e.g., proper Exchange uninstall on O365 migration).
	- Schedule for user/groups/hosts audit.

### Technology
Periodic AD review for legacy misconfigs/new threats. Avoid introducing misconfigs w/ changes. Watch AD/tool/app vulns.

Measures:
- Run tools like BloodHound, PingCastle, Grouper periodically for AD misconfigs.
- Ensure admins not storing pws in AD acct description fields.
- Review SYSVOL for scripts w/ pws/sensitive data.
- Avoid normal service accts; use gMSA/MSA to mitigate Kerberoasting.
- Disable Unconstrained Delegation where possible.
- Prevent direct DC access via hardened jump hosts.
- Set ms-DS-MachineAccountQuota to 0 (disallows user-added machine accts; prevents noPac/RBCD attacks).
- Disable print spooler service where possible (prevents attacks).
- Disable NTLM auth on DCs if possible.
- Use Extended Protection for Auth + Require SSL only for HTTPS on CA Web Enrollment/Cert Enrollment Web Service.
- Enable SMB signing + LDAP signing.
- Prevent enumeration w/ tools like BloodHound.
- Quarterly pentests/AD sec assessments (annual min if budget-constrained).
- Test backups validity; review/practice DR plans.
- Restrict anonymous access/prevent null session enum: Set RestrictNullSessAccess reg key to 1.

## Protections By Section
Alt view: Major actions by TTP + MITRE tag (from Enterprise ATT&CK Matrix: https://attack.mitre.org/matrices/enterprise/). TA### = tactic; T### = technique.

| TTP                     | MITRE Tag    | Description |
|-------------------------|--------------|-------------|
| External Reconnaissance | T1589       | Hard to detect/defend (no direct interaction). Monitor/control public data release: Scrub docs/metadata (prevent user naming leaks); limit job postings on tools/equip. Control BGP/DNS records. |
| Internal Reconnaissance | T1595       | More options (active phase = network traffic). Monitor suspicious packet bursts/large vol from source(s) = scanning. Use Firewall/NIDS for alerts/auto-blocks. Network monitoring + SIEM key. Tune Win Firewall/EDR to ignore ICMP/other traffic (deny attacker info). |
| Poisoning              | T1557       | Use SMB msg signing + strong enc (stops poisoning/MitM). SMB signing: Hashed auth codes verify sender/recipient (breaks relay/spoofing). |
| Password Spraying      | T1110/003   | Easiest to defend/detect. Log/monitor: Watch Event IDs 4624/4648 for invalid login strings (spray/brute). Strong pw policies, lockout policy, 2FA/MFA prevent success. Recommended settings: Microsoft pw policy recs, NIST docs (e.g., SP 800-63B: Min 8 chars user-created, 15 high-sec; max 64; all printing ASCII; no complexity rules, check breached pws). |
| Credentialed Enumeration| TA0006      | No direct defense (valid creds = user actions). Detect: Monitor unusual activity (CLI cmds when unneeded, multi RDP host-hops, file moves). Harder w/ admin privs; use network heuristics for anomalies. Network segmentation helps. |
| LOTL                   | N/A         | Hard to spot (uses built-in OS tools). Baseline traffic/user behavior to spot abnormal. Watch cmd shells; AppLocker policy prevents unneeded app/tool access. |
| Kerberoasting          | T1558/003   | Well-doc'd; defend/spot ways. #1: Stronger enc than RC4 for Kerberos. Strong pw policies prevent success. Best: gMSAs (makes Kerberoasting impossible). Audit user perms for excessive groups. |

## MITRE ATT&CK Breakdown




Explore example: Kerberoasting under TA0006 Credential Access (tactic: actor goal w/ techniques). Scroll to T1558 Steal/Forge Kerberos Tickets (technique w/ sub-techs: .001 Golden Ticket, .002 Silver Ticket, .003 Kerberoasting, .004 AS-REP Roasting). Select T1558.003: Explanation, platform info, real-world examples, mitigate/detect ways, refs.

Technique: TA0006/T1558.003. Framework navigation: Tactics vs techniques clarified. Great for Tactic/Technique info.

## Closing Thoughts
Not exhaustive, but strong start. As attackers: Know defenses for alt exploit/movement planning. Not all wins; some envs locked/monitor everything. Explore all; help defenders w/ best results. Understand attacks/defenses = better cyber pros.