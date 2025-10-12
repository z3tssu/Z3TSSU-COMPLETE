---
title: Crackmapexec Enumeration
updated: 2023-04-11T14:33:03.0000000+04:00
created: 2023-04-11T14:14:39.0000000+04:00
---

Crackmapexec Enumeration
Tuesday, April 11, 2023
2:14 PM
## Use crackmapexec to enumerate a list of user accounts
if**IPC\$**share is accessible, indicating that I could perform user enumeration with**crackmapexec**.

| Command | crackmapexec smb 10.10.222.122 -u 'guest' -p '' --rid-brute |
|---------|-------------------------------------------------------------|

## Example found user accounts:

1.  Administrator
2.  Guest
3.  krbtgt
4.  WIN-2BO8M1OE1M1\$
5.  enterprise-core-vn
6.  a-whitehat
7.  t-skid
8.  j-goldenhand
9.  j-leet

**
