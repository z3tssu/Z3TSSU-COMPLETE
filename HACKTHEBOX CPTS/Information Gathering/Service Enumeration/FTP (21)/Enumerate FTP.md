# FTP Script Scanning
## Default FTP Script Scan 
```bash
sudo nmap -sV -p21 -sC -A 10.129.14.136
```
## Script Trace Scan
```bash
sudo nmap -sV -p21 -sC -A 10.129.14.136 --script-trace
```
## ftp-anon
```bash
sudo nmap target_ip -A -sV -p21 --script=ftp-anon 
```
# Service Interaction
## Netcat Banner Grab
```bash
nc -nv 10.129.14.136 21
```
## Telnet Banner Grab
```bash
telnet 10.129.14.136 21
```
## OpenSSL FTP Server Interaction
```bash
openssl s_client -connect 10.129.14.136:21 -starttls ftp

CONNECTED(00000003)                                                                                      
Can't use SSL_get_servername                        
depth=0 C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Dev, CN = master.inlanefreight.htb, emailAddress = admin@inlanefreight.htb
verify error:num=18:self signed certificate
verify return:1

depth=0 C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Dev, CN = master.inlanefreight.htb, emailAddress = admin@inlanefreight.htb
verify return:1
---                                                 
Certificate chain
 0 s:C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Dev, CN = master.inlanefreight.htb, emailAddress = admin@inlanefreight.htb
 
 i:C = US, ST = California, L = Sacramento, O = Inlanefreight, OU = Dev, CN = master.inlanefreight.htb, emailAddress = admin@inlanefreight.htb
---
 
Server certificate

-----BEGIN CERTIFICATE-----

MIIENTCCAx2gAwIBAgIUD+SlFZAWzX5yLs2q3ZcfdsRQqMYwDQYJKoZIhvcNAQEL
...SNIP...
```