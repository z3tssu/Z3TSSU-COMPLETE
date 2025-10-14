The complete course is [[Index |here]]
# Background
A team member started an External Penetration Test and was moved to another urgent project before they could finish. The team member was able to find and exploit a file upload vulnerability after performing recon of the externally-facing web server. Before switching projects, our teammate left a password-protected web shell (with the credentials: ***admin:My_W3bsH3ll_P@ssw0rd!)*** in place for us to start from in the /uploads directory. As part of this assessment, our client, Inlanefreight, has authorized us to see how far we can take our foothold and is interested to see what types of high-risk issues exist within the AD environment. Leverage the web shell to gain an initial foothold in the internal network. Enumerate the Active Directory environment looking for flaws and misconfigurations to move laterally and ultimately achieve domain compromise.

# Submit the contents of the flag.txt file on the administrator Desktop of the web server

## Nmap Scan
```
┌──(root㉿kali)-[/home/z3tssu/Downloads]
└─# nmap -p80,445,135,139 -v -Pn 10.129.202.242
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-10-14 21:19 +04
Initiating Parallel DNS resolution of 1 host. at 21:19
Completed Parallel DNS resolution of 1 host. at 21:19, 0.00s elapsed
Initiating SYN Stealth Scan at 21:19
Scanning 10.129.202.242 [4 ports]
Discovered open port 135/tcp on 10.129.202.242
Discovered open port 80/tcp on 10.129.202.242
Discovered open port 139/tcp on 10.129.202.242
Discovered open port 445/tcp on 10.129.202.242
Completed SYN Stealth Scan at 21:19, 0.28s elapsed (4 total ports)
Nmap scan report for 10.129.202.242
Host is up (0.25s latency).

PORT    STATE SERVICE
80/tcp  open  http
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds

```

There seems to be a webserver running on port 80, lets check it out
![[Pasted image 20251014212045.png]]

The webserver allows for file upload, so we can exploit this an gain a reverse shell through the file upload. 
## Gaining a reverse shell through file upload on webserver

Basically to gain a shell, we need two things, seen below:

1. Create a payload
2. Setup a listener

### Creating a Payload 
I like to use the following website; [Online - Reverse Shell Generator](https://www.revshells.com/)
![[Pasted image 20251014212732.png]]
Basically specific the LHOST and LPORT, then it will provide a msfvenom command query and you can copy and past that in the terminal to create the payload


