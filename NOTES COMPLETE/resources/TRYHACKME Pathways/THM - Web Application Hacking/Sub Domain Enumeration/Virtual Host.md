---
title: Virtual Host
updated: 2022-11-23T15:01:58.0000000+04:00
created: 2022-11-23T11:43:17.0000000+04:00
---

AM

- Some subdomains aren't always hosted in publically accessible DNS results\\
  
  Instead, the DNS record could be kept on a private DNS server or recorded on the developer's machines in their **/etc/hosts file (or c:\windows\system32\drivers\etc\hosts file** for Windows users) which maps domain names to IP addresses.
- web servers can host multiple websites from one server
- when a website is requested from a client, **the server knows which website the client wants from the Host header**.
- We can utilise this host header by making changes to it and monitoring the response to see if we've discovered a new website.
  
  **<u>Discovering a new subdomain using Ffuf:</u>**
  
  ffuf -w /usr/share/wordlists/SecLists/Discovery/DNS/namelist.txt -H **"Host: FUZZ.acmeitsupport.thm"** -u <http://MACHINE_IP>