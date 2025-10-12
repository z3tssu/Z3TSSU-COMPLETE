---
title: SSH | 22
updated: 2023-03-24T08:56:42.0000000+04:00
created: 2022-08-09T21:14:30.0000000+04:00
---

- Simply go to msfconsole and use an auxiliary scanner
- Use method as seen in enumerating smb in the previous page

**How to SSH to an IP Address**

**Command:**

\> ssh {IP Address}

**If the above doesn’t work use the following:**

\> ssh {Ip address} -oKexAlgorithms=+diffie-hellman-group1-sha1 -c aes128-cbc

