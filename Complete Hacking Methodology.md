- Information Gathering
    
    - Service Enumeration
        
        - Services
            
            - FTP (21)
                
                - Dangerous Settings
                    
            - SSH (22)
                
                - Authentication
                    
                - Dangerous Settings
                    
            - SMTP (25,465,587)
                
                - Common Commands
                    
            - DNS (53)
                
                - Record Types
                    
                - Dangerous Settings
                    
            - TFTP (69)
                
            - Kerberos (88)
                
            - POP3 (110,995)
                
                - Commands
                    
                - Dangerous Settings
                    
            - IMAP (143,993)
                
                - Commands
                    
            - SMB (139,445)
                
                - Windows Specific
                    
                - Spidering
                    
                - RPCclient
                    
                - Dangerous Settings
                    
            - SNMP (161,162,10161,10162)
                
                - Dangerous Settings
                    
            - R‑Services (512, 513, 514)
                
                - Service Breakdown
                    
            - IPMI (623)
                
                - Authentication
                    
                - Default Credentials
                    
            - Rsync (873)
                
            - MSSQL (1433, 1434, 2433)
                
                - T‑SQL Commands
                    
                - Dangerous Settings
                    
            - Oracle TNS (1521)
                
                - SQLplus Commands
                    
                - Troubleshooting
                    
            - NFS (2049)
                
            - MySQL (3306)
                
                - Basic SQL Queries
                    
                - Dangerous Settings
                    
            - RDP (3389)
                
            - WinRM (5985,5986)
                
        - Tools
            
            - Nmap
                
                - Host Discovery
                    
                - Port Scanning
                    
                - Saving Output
                    
                - Scripts
                    
                - Firewall and IDS/IPS Evasion
                    
                - Options
                    
            - tcpdump
                
            - WMIexec
                
            - creds
                
    - Web Enumeration
        
        - Active
            
            - Web Server Enumeration
                
            - Directory & Page Fuzzing
                
            - Subdomain & Virtual Host Fuzzing
                
            - Parameter & Value Fuzzing
                
        - Passive
            
            - Passive Subdomain Enumeration
                
            - Passive Infrastructure Identification
                
            - Google Dorking
                
        - Tools
            
            - EyeWitness
                
    - Application Enumeration
        
        - Wordpress
            
        - Joomla
            
        - Drupal
            
        - Tomcat
            
        - Jenkins
            
        - Splunk
            
        - PRTG Network Monitor
            
        - osTicket
            
        - GitLab
            
        - ColdFusion
            
        - IIS Tilde Enumeration
            
    - Active Directory Enumeration
        
        - Hosts Enumeration
            
        - User Enumeration
            
            - Without Access
                
            - With Access
                
        - SMB Enumeration
            
        - Password Policy Enumeration
            
        - Enumerating Security Controls
            
        - ACL Enumeration
            
        - Tools
            
            - BloodHound
                
                - Analysis
                    
            - PowerView
                
- Pre‑Exploitation
    
    - Shells
        
        - Bind Shells
            
        - Reverse Shells
            
        - Web Shells
            
        - CMD vs. Powershell
            
        - Escape Shell Jail
            
    - Password Wordlist Generation
        
    - Tools
        
        - MSFConsole
            
            - Searching Module
                
            - Using Module
                
            - Payloads & Encoders
                
            - Sessions & Jobs
                
        - Meterpreter
            
            - Databases
                
        - MSFVenom
            
            - Common Payloads
                
            - Evasion
                
        - Searchsploit
            
- Exploitation
    
    - Service Exploitation
        
        - Services
            
            - FTP (21)
                
            - SSH (22)
                
            - SMTP (25,465,587) & POP3 (110,995)
                
                - Open Relay Attack
                    
            - DNS (53)
                
            - SMB (139, 445)
                
            - LDAP (389)
                
            - MSSQL (1433, 2433)
                
                - Manual
                    
                - Linked Servers
                    
            - MySQL (3306)
                
                - SQL Union Injections
                    
                - Reading Files
                    
                - Writing Files
                    
            - Oracle TNS (1521)
                
            - NFS (2049)
                
            - RDP (3389)
                
            - WinRM (5985,5986)
                
        - Tools
            
            - SQLMap
                
                - Advanced Enumeration
                    
                - WAF Evasion
                    
                - OS Exploitation
                    
            - Responder
                
	- Web Exploitation
            
            - HTTP Basic Auth Brute Forcing
                
            - Login Form Brute Forcing
                
            - Cross‑Site Scripting (XSS)
                
                - Discovery
                    
                - Phishing
                    
                - Session Hijacking
                    
            - Local File Inclusion (LFI)
                
                - File Disclosure
                    
                - Filter Bypass
                    
                - LFI to Remote Code Execution
                    
                - Vulnerable Code Examples
                    
            - File Upload Attacks
                
            - Command Injection
                
                - Filter Identification
                    
                - Filter Bypass
                    
            - HTTP Verb Tampering
                
            - IDOR
                
            - XXE
                
                - File Disclosure
                    
                - Blind
                    
                - RCE
                    
            - CGI Shellshock Attack
                
            - Mass Assignment
                
            - Tools
                
                - cewl
                    
                - cupp
                    
	- Application Exploitation
            
            - Wordpress
                
            - Joomla
                
            - Drupal
                
                - Drupageddon
                    
            - Tomcat
                
                - CVE‑2019‑0232
                    
            - Jenkins
                
            - Splunk
                
            - PRTG Network Monitor
                
            - osTicket
                
            - GitLab
                
            - ColdFusion
                
            - Nagios XI
                
            - DotNetNuke
                
            - Other Applications
                
	- Binary Exploitation
            
            - ELF Executable Examination
                
            - DLL File Examination
                
	- Active Directory Attacks
            
            - Network Poisoning
                
            - Password Spraying
                
            - Kerberoasting
                
                - Attacking from a Linux host
                    
                - Attacking from a Windows host
                    
                - ASREPRoasting
                    
                - Group Policy Preferences Passwords
                    
            - ACL Abuse
                
                - Set‑DomainUserPassword
                    
                - Add‑DomainGroupMember
                    
                - Set‑DomainObject
                    
            - SMB Hash Stealing
                
            - DCSync
                
            - noPac
                
            - PrintNightmare
                
            - PetitPotam
                
            - Misconfigurations
                
                - SYSVOL Pillaging
                    
                - Password in Description Field
                    
                - PASSWD_NOTREQD Field
                    
                - Group Policy Object Abuse
                    
            - Trust Relationship Abuse
                
                - Attacking Child → Parent Trust
                    
                - Attacking Cross‑Forest Trust
                    
- Post‑Exploitation
    
    - Fully Interactive TTY
        
    - Linux Post Exploitation
        
        - Info
            
            - Mount Bitlocker Volume
                
        - Pillage & Recon
            
            - Host Recon
                
        - Privilege Escalation
            
            - Privileged Groups
                
        - Sudo Abuse
            
            - LD_PRELOAD
                
            - LD_LIBRARY_PATH
                
            - SUID / GUID
                
            - Cronjob Abuse
                
            - Capabilities
                
        - Wildcard Injection
            
            - tar
                
            - rsync
                
            - Python Library Hijacking
                
        - Credential Hunting
            
            - Files
                
            - History
                
            - Memory
                
            - Key‑Rings
                
        - NFS no_root_squash
            
        - PATH Abuse
            
        - Docker Group
            
        - Passwd, Shadow & Opasswd
            
            - Writeable /etc/passwd
                
            - Readable /etc/shadow
                
            - Writeable /etc/shadow
                
        - Escaping Restricted Shells
            
        - Tmux Session Hijacking
            
        - Shared Object Hijacking
            
        - PwnKit
            
        - LogRotten
            
        - Kubernetes
            
        - Payloads
            
        - File Transfer
            
            - Base64 Encode & Decode
                
            - Wget / cURL Download & Upload
                
            - Bash Download
                
            - SSH Download
                
            - Upload Server
                
            - Code Download & Upload
                
            - SMB Download & Upload
                
            - FTP Download
                
            - File Encryption
                
    - Windows Post Exploitation
        
        - Info
            
            - Accounts
                
            - Access Control List (ACL)
                
            - Built‑in AD Groups
                
        - NTFS
            
            - NTFS vs. SMB
                
        - Services
            
        - Execution Policy
            
        - Registry
            
        - Powershell
            
        - Pillage & Recon
            
            - Host Recon
                
                - Net Commands
                    
                - Wmic Commands
                    
                - Dsquery
                    
                - Rights & Privileges
                    
                - Users & Groups
                    
        - Privilege Escalation
            
            - Legacy Operating Systems
                
                - Windows Server 2008/2008 R2
                    
                - Windows 7
                    
            - User Privileges
                
                - SeImpersonate & SeAssignPrimaryToken
                    
                - SeDebugPrivilege
                    
                - SeTakeOwnershipPrivilege
                    
            - Privileged Groups
                
                - Backup Operators
                    
                - Event Log Readers
                    
                - DnsAdmins
                    
                - Hyper‑V Administrators
                    
                - Print Operators
                    
                - Server Operators
                    
            - User/Computer Description Field
                
            - Scheduled Tasks
                
            - Credential Hunting
                
            - Credential Sniffing
                
            - Always Install Elevated
                
            - Unquoted Service Path
                
            - Vulnerable Services
                
            - Cookie Stealing
                
            - Weak Service Permissions
                
            - Permissive Registry ACLs
                
            - Modifiable Registry Autorun Binary
                
            - Kernel Exploits
                
                - Kernel Exploit Table
                    
                - VMDK, VHD and VHDX files
                    
                - Malicious SCF and .lnk File
                    
                - SAM & LSA Attack
                    
                - LSASS Attack
                    
                - NTDS.dit Attack
                    
                - Restic Backup Attack
                    
                - Citrix Breakout
                    
                - Bypassing UAC
                    
                - Payloads
                    
            - File Transfer
                
                - NetExec Download & Upload
                    
                - Base64 Encode & Decode
                    
                - PowerShell Download & Upload
                    
                - Code Download & Upload
                    
                - SMB Download & Upload
                    
                - FTP Download
                    
                - PowerShell Remoting
                    
                - RDP
                    
                - File Encryption
                    
            - Tools
                
                - Hashcat
                    
                    - Common Modes
                        
                - John The Ripper
                    
                    - Conversion
                        
                - Netcat / Ncat
                    
                    - Listener On Recipient
                        
                    - Listener On Sender
                        
                    - Ncat Only On Sender
                        
- Lateral Movement
    
    - Linux Lateral Movement
        
        - Kerberos Pass the Ticket
            
            - CCache Files
                
            - KeyTab Files
                
            - Linikatz
                
            - CCache Abuse
                
    - Windows Lateral Movement
        
        - NTLM Pass the Hash
            
        - Kerberos Pass the Ticket
            
            - Ticket Request
                
    - Active Directory Lateral Movement
        
        - RDP
            
        - Powershell Remoting
            
        - MSSQL Server
            
        - Double Hop Problem
            
    - Pivoting
        
        - Pivoting Recon
            
        - Local Port Forwarding
            
        - Dynamic Port Forwarding
            
        - Reverse Port Forwarding
            
        - Proxy Chaining
            
        - Proxychains with NXC
            
    - Tools
        
        - Plink
            
        - Sshuttle
            
        - RPIVOT
            
        - Netsh
            
        - Dnscat2
            
        - Socat
            
        - Meterpreter
            
        - SocksOverRDP
            
- NetExec
    
    - Working with Modules
        
    - Mapping and Enumeration with SMB
        
    - LDAP and RDP Enumeration
        
    - Command Execution
        
    - Dumping Secrets
        
    - Popular Modules
        
    - Vulnerability Scan Modules
        
    - Kerberos Authentication