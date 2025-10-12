---
title: Enumerating SMB Shares with Metasploit
updated: 2023-03-24T15:41:58.0000000+04:00
created: 2023-03-21T16:45:12.0000000+04:00
---

Enumerating SMB Shares with Metasploit
Tuesday, March 21, 2023
4:45 PM
1.  Msfconsole
2.  Search enum smb
3.  Use scanner/smb/smb_enumshares
4.  Set RHOSTS (Ip address)

You will find the shares if its vulnerable

![image1](image1-28.png)

- print\$ - a share used for printer drivers
- anonymous - a share with an unknown purpose
- IPC\$ - a special share used for inter-process communication (IPC) between SMB clients and servers

