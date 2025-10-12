---
title: 'crackmapexec '
updated: 2023-04-11T14:03:54.0000000+04:00
created: 2023-02-23T20:51:29.0000000+04:00
---

crackmapexec
Thursday, February 23, 2023
8:51 PM
\#
CrackMapExec (CME) is a popular open-source post-exploitation tool used by ethical hackers, penetration testers, and security professionals for network reconnaissance, lateral movement, and privilege escalation in Windows networks. It leverages the Server Message Block (SMB) protocol to discover and exploit vulnerabilities in Windows systems.

Here are some example commands and their explanations:

cme smb \<target\> -u \<username\> -p \<password\>

: This command initiates an SMB scan against the specified target, using the provided username and password for authentication. CME will enumerate shares, users, groups, and other resources on the target system.

cme smb \<target\> -u \<username\> -p \<password\> --shares

: This command retrieves a list of accessible shares on the target system, including their permissions, which can help identify potential areas for further exploitation.

cme smb \<target\> -u \<username\> -p \<password\> -M \<module\>

: This command specifies a specific module to use for exploitation, such as winrm for WinRM-based exploitation or smbexec for launching commands on remote systems using SMB.

cme smb \<target\> -u \<username\> -p \<password\> -o \<outputfile\>

: This command saves the output of the scan to a file for later analysis, allowing you to review the results and identify potential vulnerabilities or misconfigurations.

cme smb \<target\> -u \<username\> -p \<password\> --local-auth

: This command attempts to perform local authentication using the credentials provided, which can be useful for privilege escalation by impersonating a local user on the target system.

cme smb \<target\> -u \<username\> -p \<password\> --exec-command "command"

: This command allows you to execute arbitrary commands on the target system, which can be used for various purposes, including lateral movement, data exfiltration, or privilege escalation.

cme smb \<target\> -u \<username\> -p \<password\> -H \<hash\>

: This command allows you to provide a password hash (NTLM or LM) instead of a plaintext password for authentication, which can be useful for pass-the-hash attacks.

