---
title: Setting up C2 Framework (Armitage)
updated: 2023-01-20T21:34:01.0000000+04:00
created: 2023-01-18T19:11:37.0000000+04:00
---

Setting up C2 Framework (Armitage)
Wednesday, January 18, 2023
7:11 PM
1.  **<u>Download Armitage using git clone</u>**

| Command | git clone <https://gitlab.com/kalilinux/packages/armitage.git> && cd armitage |
|---------|-------------------------------------------------------------------------------|

2.  **<u>build the current release</u>**

| Command | bash package.sh |
|---------|-----------------|

3.  **<u>check and verify that Armitage was able to be built successfully</u>**

| Command | cd ./release/unix/ && ls -la |
|---------|------------------------------|

In this folder, there are two key files that we will be using:

**Teamserver -**
This is the file that will start the Armitage server that multiple users will be able to connect to. This file takes two arguments:

- IP Address

Your fellow Red Team Operators will use the IP Address to connect to your Armitage server.

- Shared Password

Your fellow Red Team Operators will use the Shared Password to access your Armitage server.

5.  **<u>Preparing the Environment:</u>**

- start and initialize the Metasploit database before launching Armitage

| Command | systemctl start postgresql && systemctl status postgresql |
|---------|-----------------------------------------------------------|

6.  **<u>initialize the Database so that Metasploit can use it. It's important to note that you cannot be the root user when attempting to initialize the Metasploit Database</u>**

| Command | msfdb --use-defaults delete |
|---------|-----------------------------|
| Command | msfdb --use-defaults init   |

**<u>View the installation location of Armitage</u>**

| Command | cd ./release/unix/ && ls -la |
|---------|------------------------------|

7.  **<u>Starting and Connecting to Armitage</u>**

| Command | cd /opt/armitage/release/unix && ./teamserver YourIP P@ssw0rd123 |
|---------|------------------------------------------------------------------|

8.  **<u>Start the Armitage Client</u>**

| Command | cd /opt/armitage/release/unix && ./armitage |
|---------|---------------------------------------------|

