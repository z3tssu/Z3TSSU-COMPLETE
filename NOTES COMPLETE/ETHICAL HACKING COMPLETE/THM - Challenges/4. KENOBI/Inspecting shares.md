---
title: Inspecting shares
updated: 2023-03-24T15:48:34.0000000+04:00
created: 2023-03-24T15:34:03.0000000+04:00
---

Inspecting shares
Friday, March 24, 2023
3:34 PM

1.  First inspect the anonymous shared drive using:

Command: smbclient [\\\\\\\ip_address\\\share](file://ip_address/share)

- Smbclient [\\\\\\\10.10.94.61\\\anonymous](file://10.10.94.61/anonymous)

![image1](image1-235.png)

2.  List files:

Command \| ls

![image2](image2-102.png)

