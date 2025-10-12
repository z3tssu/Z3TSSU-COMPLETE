
## Overview
Post-initial access in Win AD: Enum defenses to assess visibility, barriers; tailor tools/methods. Key: Defender, AppLocker, PS modes, LAPS.

## 1. Windows Defender Status Check
Objective: Check Microsoft Defender op status/config.

Command (PS on target):
```
Get-MpComputerStatus
```

Output Analysis:
- RealTimeProtectionEnabled: Real-time scanning active?
- AntivirusEnabled: AV on?
- BehaviorMonitorEnabled, IoavProtectionEnabled, OnAccessProtectionEnabled: Extra protections.

Summary: Defender hinders tools (e.g., PowerView); informs tool selection/use.

## 2. AppLocker Policy Enumeration
Objective: ID app whitelisting (restricts exe/script exec).

Command (PS on target):
```
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```

Example Findings:
- PS blocked for Domain Users at: %SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
- Default allow rules: %PROGRAMFILES%\*, %WINDIR%\*

Summary: Understand rules for alt exec paths; leverage whitelisted apps.

## 3. PowerShell Language Mode Check
Objective: Detect Constrained Language Mode (limits capabilities).

Command (PS on target):
```
$ExecutionContext.SessionState.LanguageMode
```

Output:
- ConstrainedLanguage or FullLanguage

Summary: Constrained restricts advanced scripting/.NET; impacts tools.

## 4. LAPS (Local Administrator Password Solution) Enumeration
Objective: Enum LAPS machines; ID users/groups w/ read rights to local admin pws.

Tools: PowerView / LAPSToolkit (https://github.com/leoloobeek/LAPSToolkit) or equiv PS scripts.

### a. Delegated Group Enumeration
Command:
```
Find-LAPSDelegatedGroups
```

### b. Extended Rights Enumeration
Command:
```
Find-AdmPwdExtendedRights
```

### c. Retrieve LAPS Passwords (if perms allow)
Command:
```
Get-LAPSComputers
```

Example Output:
- Groups: Domain Admins / LAPS Admins delegated rights.
- Get-LAPSComputers: Cleartext pws + exp dates.

Summary: LAPS reduces lateral; target if read-access users/groups compromisable.

## Conclusion
Enum defenses post-access shapes attack path. Defender configs, AppLocker, PS restrictions, LAPS influence tool selection/mod for stealthy AD exploit in pentest/red team.