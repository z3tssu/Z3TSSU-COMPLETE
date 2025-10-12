---
title: Enumerating FTP
updated: 2023-01-29T16:22:45.0000000+04:00
created: 2022-08-09T21:35:37.0000000+04:00
---

\- port 21/FTP is open
\- anonymous login is allowed
\- service version is found

Exploiting FTP is typically useless unless you can execute any files that you put on that server

\- ssh/22 is open
\- typically you will brute force the ssh

**<u>To list out all the possible FTP nmap Scripts</u>**

l**s -al /usr/share/nmap/scripts/ \| grep -e "ftp"**

![image1](image1-31.png)

nmap command for FTP only

\> **nmap sV -p 21 --script ftp-vsftp-backdoor IP_Address**

• If the Port is vulnerable it will identify as being vulnerable
• it will provide the CVE

**<u>Example from THM:</u>**

1.  Nmap scan:
- Nmap {Ip address} -p 21 -A -T4
![image2](image2-14.png)

2.  Version discovery

![image3](image3-7.png)

3.  Seeing if we can log in anonymously

![image4](image4-6.png)

We enter the username: anonymous
Then Password we can enter anything

![image5](image5-4.png)

