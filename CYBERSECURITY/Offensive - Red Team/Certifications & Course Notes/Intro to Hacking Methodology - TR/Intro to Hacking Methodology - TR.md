- [[#Enumeration (Silver Platter THM)]]
    - [[#Nmap SCAN]]
    - [[#Rustscan SCAN]]
    - [[#SSH [22] ]]
    - [[#HTTP (80)]]
        - [[#Dirsearch]]
        - [[#Vhosts]]
        - [[#Website Features]]
    - [[#HTTP (8080)]]
- [[#Hacking all the Things]]
    - [[#Creating a Custom Password List (CEWL)]]
    - [[#Performing Password Spraying with Burp Suite]]
        - [[#Turbo Intruder Extension]]
    - [[#Performing Password Spraying with Hydra]]
        - [[#Example]]
    - [[#Performing Password Spraying with Caido]]
    - [[#Alternative Exploit - Authentication Bypass]]
    - [[#Identifying and Exploiting IDORs]]
- [[#Privilege Escalation]]
    - [[#Manual Priv Esc]]
    - [[#Automated Priv Esc]]

---

# Enumeration (==Silver Platter THM==)

## Nmap SCAN

```JavaScript
┌──(kali㉿kali)-[~/THM/easy/SilverPlatter]
└─$ nmap silverplatter.thm -p22,80,8080 -T5 -A --min-rate=5000 -v

PORT     STATE SERVICE    VERSION
22/tcp   open  ssh        OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 1b:1c:87:8a:fe:34:16:c9:f7:82:37:2b:10:8f:8b:f1 (ECDSA)
|_  256 26:6d:17:ed:83:9e:4f:2d:f6:cd:53:17:c8:80:3d:09 (ED25519)
80/tcp   open  http       nginx 1.18.0 (Ubuntu)
|_http-title: Hack Smarter Security
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-server-header: nginx/1.18.0 (Ubuntu)
8080/tcp open  http-proxy
|_http-title: Error
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.1 404 Not Found
|     Connection: close
|     Content-Length: 74
|     Content-Type: text/html
|     Date: Mon, 07 Jul 2025 18:20:11 GMT
|     <html><head><title>Error</title></head><body>404 - Not Found</body></html>
|   GenericLines, Help, Kerberos, LDAPSearchReq, LPDString, RTSPRequest, SMBProgNeg, SSLSessionReq, Socks5, TLSSessionReq, TerminalServerCookie: 
|     HTTP/1.1 400 Bad Request
|     Content-Length: 0
|     Connection: close
|   GetRequest, HTTPOptions: 
|     HTTP/1.1 404 Not Found
|     Connection: close
|     Content-Length: 74
|     Content-Type: text/html
|     Date: Mon, 07 Jul 2025 18:20:10 GMT
|_    <html><head><title>Error</title></head><body>404 - Not Found</body></html>
```

## Rustscan SCAN

1. Download and Install: [https://github.com/bee-san/RustScan/releases](https://github.com/bee-san/RustScan/releases)
2. Unzip the file: **unzip file_name**
3. Run the Program

```Bash
rustscan -a ip_address -- -A
```

```Bash
┌──(kali㉿kali)-[~/THM/easy/SilverPlatter]
└─$ sudo rustscan -a silverplatter.thm -- -A
.----. .-. .-. .----..---.  .----. .---.   .--.  .-. .-.
| {}  }| { } |{ {__ {_   _}{ {__  /  ___} / {} \ |  `| |
| .-. \| {_} |.-._} } | |  .-._} }\     }/  /\  \| |\  |
`-' `-'`-----'`----'  `-'  `----'  `---' `-'  `-'`-' `-'
The Modern Day Port Scanner.
________________________________________
: http://discord.skerritt.blog         :
: https://github.com/RustScan/RustScan :
 --------------------------------------
Nmap? More like slowmap.🐢

[~] The config file is expected to be at "/root/.rustscan.toml"
[!] File limit is lower than default batch size. Consider upping with --ulimit. May cause harm to sensitive servers
[!] Your file limit is very small, which negatively impacts RustScan's speed. Use the Docker image, or up the Ulimit with '--ulimit 5000'. 
Open 10.10.168.250:22
Open 10.10.168.250:80
Open 10.10.168.250:8080
[~] Starting Script(s)
[>] Running script "nmap -vvv -p {{port}} -{{ipversion}} {{ip}} -A" on ip 10.10.168.250
Depending on the complexity of the script, results may take some time to appear.
[~] Starting Nmap 7.95 ( https://nmap.org ) at 2025-07-07 14:42 EDT
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 14:42
Completed NSE at 14:42, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 14:42
Completed NSE at 14:42, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 14:42
Completed NSE at 14:42, 0.00s elapsed
Initiating Ping Scan at 14:42
Scanning 10.10.168.250 [4 ports]
Completed Ping Scan at 14:43, 0.24s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 14:43
Scanning silverplatter.thm (10.10.168.250) [3 ports]
Discovered open port 80/tcp on 10.10.168.250
Discovered open port 8080/tcp on 10.10.168.250
Discovered open port 22/tcp on 10.10.168.250
Completed SYN Stealth Scan at 14:43, 0.28s elapsed (3 total ports)
Initiating Service scan at 14:43
Scanning 3 services on silverplatter.thm (10.10.168.250)
Completed Service scan at 14:44, 88.85s elapsed (3 services on 1 host)
Initiating OS detection (try #1) against silverplatter.thm (10.10.168.250)
Retrying OS detection (try #2) against silverplatter.thm (10.10.168.250)
WARNING: OS didn't match until try #2
Initiating Traceroute at 14:44
Completed Traceroute at 14:44, 0.24s elapsed
Initiating Parallel DNS resolution of 1 host. at 14:44
Completed Parallel DNS resolution of 1 host. at 14:44, 0.11s elapsed
DNS resolution of 1 IPs took 0.11s. Mode: Async [#: 1, OK: 0, NX: 1, DR: 0, SF: 0, TR: 1, CN: 0]
NSE: Script scanning 10.10.168.250.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 13.36s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 1.24s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 0.00s elapsed
Nmap scan report for silverplatter.thm (10.10.168.250)
Host is up, received echo-reply ttl 63 (0.25s latency).
Scanned at 2025-07-07 14:43:00 EDT for 110s

PORT     STATE SERVICE    REASON         VERSION
22/tcp   open  ssh        syn-ack ttl 63 OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 1b:1c:87:8a:fe:34:16:c9:f7:82:37:2b:10:8f:8b:f1 (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJ0ia1tcuNvK0lfuy3Ep2dsElFfxouO3VghX5Rltu77M33pFvTeCn9t5A8NReq3felAqPi+p+/0eRRfYuaeHRT4=
|   256 26:6d:17:ed:83:9e:4f:2d:f6:cd:53:17:c8:80:3d:09 (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKecigNtiy6tW5ojXM3xQkbtTOwK+vqvMoJZnIxVowju
80/tcp   open  http       syn-ack ttl 63 nginx 1.18.0 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-server-header: nginx/1.18.0 (Ubuntu)
|_http-title: Hack Smarter Security
8080/tcp open  http-proxy syn-ack ttl 62
|_http-title: Error
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.1 404 Not Found
|     Connection: close
|     Content-Length: 74
|     Content-Type: text/html
|     Date: Mon, 07 Jul 2025 18:43:07 GMT
|     <html><head><title>Error</title></head><body>404 - Not Found</body></html>
|   GenericLines, Help, Kerberos, LDAPSearchReq, LPDString, RTSPRequest, SMBProgNeg, SSLSessionReq, Socks5, TLSSessionReq, TerminalServerCookie: 
|     HTTP/1.1 400 Bad Request
|     Content-Length: 0
|     Connection: close
|   GetRequest, HTTPOptions: 
|     HTTP/1.1 404 Not Found
|     Connection: close
|     Content-Length: 74
|     Content-Type: text/html
|     Date: Mon, 07 Jul 2025 18:43:06 GMT
|_    <html><head><title>Error</title></head><body>404 - Not Found</body></html>
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port8080-TCP:V=7.95%I=7%D=7/7%Time=686C153B%P=x86_64-pc-linux-gnu%r(Get
SF:Request,C9,"HTTP/1\.1\x20404\x20Not\x20Found\r\nConnection:\x20close\r\
SF:nContent-Length:\x2074\r\nContent-Type:\x20text/html\r\nDate:\x20Mon,\x
SF:2007\x20Jul\x202025\x2018:43:06\x20GMT\r\n\r\n<html><head><title>Error<
SF:/title></head><body>404\x20-\x20Not\x20Found</body></html>")%r(HTTPOpti
SF:ons,C9,"HTTP/1\.1\x20404\x20Not\x20Found\r\nConnection:\x20close\r\nCon
SF:tent-Length:\x2074\r\nContent-Type:\x20text/html\r\nDate:\x20Mon,\x2007
SF:\x20Jul\x202025\x2018:43:06\x20GMT\r\n\r\n<html><head><title>Error</tit
SF:le></head><body>404\x20-\x20Not\x20Found</body></html>")%r(RTSPRequest,
SF:42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConne
SF:ction:\x20close\r\n\r\n")%r(FourOhFourRequest,C9,"HTTP/1\.1\x20404\x20N
SF:ot\x20Found\r\nConnection:\x20close\r\nContent-Length:\x2074\r\nContent
SF:-Type:\x20text/html\r\nDate:\x20Mon,\x2007\x20Jul\x202025\x2018:43:07\x
SF:20GMT\r\n\r\n<html><head><title>Error</title></head><body>404\x20-\x20N
SF:ot\x20Found</body></html>")%r(Socks5,42,"HTTP/1\.1\x20400\x20Bad\x20Req
SF:uest\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(Generi
SF:cLines,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r
SF:\nConnection:\x20close\r\n\r\n")%r(Help,42,"HTTP/1\.1\x20400\x20Bad\x20
SF:Request\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(SSL
SF:SessionReq,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x2
SF:00\r\nConnection:\x20close\r\n\r\n")%r(TerminalServerCookie,42,"HTTP/1\
SF:.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConnection:\x20c
SF:lose\r\n\r\n")%r(TLSSessionReq,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r
SF:\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(Kerberos,42,
SF:"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConnecti
SF:on:\x20close\r\n\r\n")%r(SMBProgNeg,42,"HTTP/1\.1\x20400\x20Bad\x20Requ
SF:est\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(LPDStri
SF:ng,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nCo
SF:nnection:\x20close\r\n\r\n")%r(LDAPSearchReq,42,"HTTP/1\.1\x20400\x20Ba
SF:d\x20Request\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n");
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running: Linux 4.X
OS CPE: cpe:/o:linux:linux_kernel:4.15
OS details: Linux 4.15
TCP/IP fingerprint:
OS:SCAN(V=7.95%E=4%D=7/7%OT=22%CT=%CU=31036%PV=Y%DS=2%DC=T%G=N%TM=686C15A2%
OS:P=x86_64-pc-linux-gnu)SEQ(SP=105%GCD=1%ISR=104%TI=Z%CI=Z%II=I%TS=A)SEQ(S
OS:P=105%GCD=1%ISR=10C%TI=Z%CI=Z%II=I%TS=A)OPS(O1=M508ST11NW7%O2=M508ST11NW
OS:7%O3=M508NNT11NW7%O4=M508ST11NW7%O5=M508ST11NW7%O6=M508ST11)WIN(W1=F4B3%
OS:W2=F4B3%W3=F4B3%W4=F4B3%W5=F4B3%W6=F4B3)ECN(R=Y%DF=Y%T=40%W=F507%O=M508N
OS:NSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=
OS:Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=A
OS:R%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=4
OS:0%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=
OS:G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)

Uptime guess: 14.092 days (since Mon Jun 23 12:32:28 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=261 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 80/tcp)
HOP RTT       ADDRESS
1   237.44 ms 10.9.0.1
2   237.50 ms silverplatter.thm (10.10.168.250)

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 14:44
Completed NSE at 14:44, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 110.34 seconds
           Raw packets sent: 61 (4.280KB) | Rcvd: 43 (3.180KB)
```

## SSH [22]

- First thing to check is if it is password or key based authentication

```Bash
┌──(root㉿kali)-[/home/kali/THM/easy/SilverPlatter]
└─# ssh root@silverplatter.thm
The authenticity of host 'silverplatter.thm (10.10.168.250)' can't be established.
ED25519 key fingerprint is SHA256:WFcHcO+oxUb2E/NaonaHAgqSK3bp9FP8hsg5z2pkhuE.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'silverplatter.thm' (ED25519) to the list of known hosts.
root@silverplatter.thm's password: 
```

- SSH Uses Password Based Authentication

## HTTP (80)

- This will typically be the way to being exploiting the machine
- Check Brute-force Directory

### Dirsearch

```Bash
# Install
sudo apt install dirsearch
```

```Bash
┌──(root㉿kali)-[/home/kali/THM/easy/SilverPlatter]
└─# dirsearch -u http://silverplatter.thm
/usr/lib/python3/dist-packages/dirsearch/dirsearch.py:23: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
  from pkg_resources import DistributionNotFound, VersionConflict

  _|. _ _  _  _  _ _|_    v0.4.3
 (_||| _) (/_(_|| (_| )

Extensions: php, aspx, jsp, html, js | HTTP method: GET | Threads: 25 | Wordlist size: 11460

Output File: /home/kali/THM/easy/SilverPlatter/reports/http_silverplatter.thm/_25-07-07_14-55-35.txt

Target: http://silverplatter.thm/

[14:55:35] Starting: 
[14:56:19] 301 -  178B  - /assets  ->  http://silverplatter.thm/assets/     
[14:56:19] 403 -  564B  - /assets/
[14:56:46] 301 -  178B  - /images  ->  http://silverplatter.thm/images/     
[14:56:46] 403 -  564B  - /images/                                          
[14:56:52] 200 -   17KB - /LICENSE.txt                                      
[14:57:12] 200 -  771B  - /README.txt 
```

### Vhosts

```Bash
# Copy the Raw File and Past into a Bash, make it executable 
https://github.com/TeneBrae93/offensivesecurity/blob/main/vhost-fuzzer.sh
```

```Bash
┌──(kali㉿kali)-[~/THM/easy/SilverPlatter]
└─$ ls
reports  vhost.sh
                                                                                                                    
┌──(kali㉿kali)-[~/THM/easy/SilverPlatter]
└─$ ./vhost.sh -h
Usage: ./vhost.sh <DOMAIN> <WORDLIST> <URL> <FS Filter>
   -h, --help     Display this help and exit

This script is a vhost fuzzer using ffuf for people who may forget the syntax.
```

### Website Features

- Interesting Username: scr1ptkiddy

![[/image 48.png|image 48.png]]

![[/image 1 4.png|image 1 4.png]]

## HTTP (8080)

1. Go to [http://silverplatter.thm:8080/silverpeas](http://silverplatter.thm:8080/silverpeas/defaultLogin.jsp)

![[/image 2 5.png|image 2 5.png]]

1. We can try default logins silveradmin:silveradmin

![[/image 3 3.png|image 3 3.png]]

  

---

# Hacking all the Things

## Creating a Custom Password List (CEWL)

```Bash
cewl http://silverplatter.thm > custom_passwords.txt
```

![[/image 4 3.png|image 4 3.png]]

## Performing Password Spraying with Burp Suite

1. Open Burp-suite
2. Install Turbo Intruder
    1. To Bypass Rate Limiting

![[/image 5 3.png|image 5 3.png]]

1. Get a request ready on the website
    1. On Burp Suite go to Proxy Tab
    2. Enable Intercept

![[/image 6 3.png|image 6 3.png]]

1. Go back to the login page and enter a random credential for burpsuite to capture the packet

![[/image 7 3.png|image 7 3.png]]

- Burp has captured the packet of the credentials

1. Sent the packet to repeater
    - Right click on the packet data and select “Send to repeater”
2. Open the repeater tab
    - You basically will be able to replay packets

![[/image 8 3.png|image 8 3.png]]

Send the password field to Turbo Intruder Extension

![[/image 9 3.png|image 9 3.png]]

### Turbo Intruder Extension

![[/image 10 3.png|image 10 3.png]]

- Select the script to be: examples/basic.py
- You need to change the path, to the path of were the word lists is located

![[/image 11 3.png|image 11 3.png]]

Now press attack at the bottom of the extension page

We want to identify changes in the Status codes and the length

![[/image 12 3.png|image 12 3.png]]

- We see that the row 49 payload values are completely different to the rest of the other values, this could mean that a valid password was found
- We can test it back on the login page: ==scr1ptkiddy:adipiscing==
- ==**and BOOM, it worked**==

![[/image 13 3.png|image 13 3.png]]

## Performing Password Spraying with Hydra

```Bash
hydra -l [Username] -P [Password List] [Target Hostname] -s [Port] http-post-form "[Request URL Ending]:[Request-Body]:[Error Message for Invalid Login]"
```

### Example

```Bash
hydra -l scr1ptkiddy -P custom_passwords.txt silverplatter.thm -s 8080 http-post-form "/silverpeas/AuthenticationServlet:Login=^USER^&Password=^PASS^&DomainId=0:Login or password incorrect" -V -t 2
```

![[/image 14 3.png|image 14 3.png]]

## Performing Password Spraying with Caido

Install: [https://caido.io/download](https://caido.io/download)

```Bash
chmod +x caido.deb

dpkg -i caido.deb
```

Now run it, from either terminal or through GUI

- It will guide you through some steps to setup a project, install the certificate, etc
- Once completed, go to the Intercept ta and open the default browser

![[/image 15 3.png|image 15 3.png]]

Do the same process as before an initiate a data packet capture on the login page

- Make sure Queuing is enabled on Caido

![[/image 16 3.png|image 16 3.png]]

- Now either press CTRL + R or right click and sent to replay

![[/image 17 3.png|image 17 3.png]]

- Right click again and sent to “Automate”
- Select a placeholder of the password field and then select the type to be Simple List, now paste in the password list data

[](https://www.notion.soundefined)

## Alternative Exploit - Authentication Bypass

  

## Identifying and Exploiting IDORs

  

---

# Privilege Escalation

## Manual Priv Esc

## Automated Priv Esc