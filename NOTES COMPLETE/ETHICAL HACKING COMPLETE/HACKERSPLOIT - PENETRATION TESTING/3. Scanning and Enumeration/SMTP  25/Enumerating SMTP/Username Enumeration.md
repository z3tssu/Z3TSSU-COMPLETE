---
title: Username Enumeration
updated: 2023-03-24T10:35:38.0000000+04:00
created: 2023-03-24T09:49:11.0000000+04:00
---

Username Enumeration
Friday, March 24, 2023
9:49 AM

\# ----------------------------------------- USERNAME ENUMERATION --------------------------------------------------------

1.  Use the module metasploit smtp_enum \| search smtp_enum

![image1](image1-35.png)

1.  Use the module \| use auxiliary/scanner/smtp/smtp_enum

1.  Set the options \| show options \| set options

![image2](image2-18.png)

1.  Set the wordlist file

![image3](image3-11.png)

Results:

![image4](image4-9.png)

- It found the username: administrator

