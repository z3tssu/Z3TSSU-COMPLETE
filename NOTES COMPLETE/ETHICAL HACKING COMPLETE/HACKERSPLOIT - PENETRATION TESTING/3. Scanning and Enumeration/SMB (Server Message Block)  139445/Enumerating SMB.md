---
title: Enumerating SMB
updated: 2023-03-24T15:42:49.0000000+04:00
created: 2022-08-09T21:09:27.0000000+04:00
---

1.  **What is SMB?**

\- it is a drive that you access
\- it is a file share

Typically, there are SMB share drives on a server that can be connected to and used to view or transfer files. SMB can often be a great starting point for an attacker looking to discover sensitive information — you'd be surprised what is sometimes included on these shares.

3.  **Using smbclient**

It is going to attempt to the file share with anonymous access

**<u>command:</u>**

\> **smbclient -L of the target}\\\\**

if it connects and displays the different directories

\> **smbclient address}\\\\{directory you want}**

5.  **Nmap SMB Vulnerability Script scan**

| **Command** | Nmap -p 445,139 --script smb-vuln-\* (Ip address) |
|-------------|---------------------------------------------------|
