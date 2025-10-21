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


