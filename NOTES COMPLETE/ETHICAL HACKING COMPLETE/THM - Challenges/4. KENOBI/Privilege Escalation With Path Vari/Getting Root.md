---
title: Getting Root
updated: 2023-03-24T16:46:32.0000000+04:00
created: 2023-03-24T16:38:25.0000000+04:00
---

Getting Root
Friday, March 24, 2023
4:38 PM

![image1](image1-244.png)

**<u>Step By step gaining root access:</u>**

**IMPORTANT ( PERFORM IN TMP DIRECTORY)**

1.  echo /bin/sh \> curl
2.  chmod 777 curl
3.  export PATH=/tmp:\$PATH
4.  /usr/bin/menu

- echo /bin/sh \> curl: This command creates a new file called curl in the current directory (assuming you have write permissions in that directory). The contents of the file are the string "/bin/sh", which is the path to the Bourne shell executable (a commonly used Unix shell).

- chmod 777 curl: This command changes the permissions of the curl file so that it is executable (x) by all users and writable (w) by the owner and group. This allows any user on the system to execute the curl file and get a shell as the owner of the file (which will be root if the file is executed by a privileged user).

- export PATH=/tmp:\$PATH: This command temporarily modifies the system's PATH environment variable to include the /tmp directory before the system's default PATH. This means that if a user runs a command with the same name as a system binary (such as curl), the system will look for that command in /tmp before the default locations. This allows an attacker to replace a system binary with their own version (in this case, the curl file we created in step 1), and have the system use that version instead of the legitimate one.

- /usr/bin/menu: This is the vulnerable program that the attacker is targeting. By manipulating the PATH environment variable, the attacker can cause the program to execute their malicious curl file instead of the legitimate curl program. If the menu program is running with root privileges (which is often the case with setuid programs), the attacker's curl file will be executed with root privileges, and they will have a shell with root access to the system.

![image2](image2-108.png)

