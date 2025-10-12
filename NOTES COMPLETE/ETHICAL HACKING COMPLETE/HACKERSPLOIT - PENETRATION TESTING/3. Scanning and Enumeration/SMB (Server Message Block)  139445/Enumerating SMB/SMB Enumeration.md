---
title: SMB Enumeration
updated: 2023-04-11T14:14:22.0000000+04:00
created: 2023-04-11T14:09:57.0000000+04:00
---

SMB Enumeration
Tuesday, April 11, 2023
2:09 PM

## If ports 139,445 are open, that means they have SMB

### You can use: Smbclient

| Command | Smbclient -L //10.10.222.122 -N |
|---------|---------------------------------|

![image1](image1-27.png)

## We can see there is the IPC\$ share,

Try accessing it using the below command:

| Command | Smbclient //ip_address/IPC\$ |
|---------|------------------------------|

If you can access it, it means that you can perform user enumeration with crackmapexec

