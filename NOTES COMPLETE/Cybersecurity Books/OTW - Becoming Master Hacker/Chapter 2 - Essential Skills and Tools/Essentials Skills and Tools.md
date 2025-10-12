# Fundamental Skills 

## 1. Basic Computer Skills 

It probably goes without saying that to become a hacker you need some basic computer skills. These
skills go beyond the ability to create a Word document, watch YouTube videos, or cruise the Internet.
You need to be able to use the command line in Windows, edit the registry, and set up your networking
parameters.
Many of these skills can be acquired in a basic computer course like the CompTIA A+.

## 2. Networking Skills 

You need to understand the basics of networking, such as;
- DHCP
- NAT
- Subnetting
- IPv4
- IPv6
- Public v Private IP
- DNS
- Routers and switches
- VLANs
- OSI model
- MAC addressing
- ARP
- SMB
- SNMP

## 3. Linux Skill 

It is critical to develop Linux skills to become a hacker. Nearly all the tools we use as a hacker are developed for Linux and Linux gives us capabilities that we don't have using Windows or the MacOS.

If you need to improve your Linux skills, or you're just getting started with Linux, check out my new Linux series for beginners (https://www.hackers-arise.com/linux-fundamentals) or my “Linux Basics for
Hackers” (https://amzn.to/2JAsYUI) from No Starch Press.

## 4. Network Traffic Analysis Tools
- **Wireshark or Tcpdump**
  - Wireshark is a widely used sniffer/protocol analyzer.
  - Tcpdump is a command line sniffer/protocol analyzer.
  - Both are useful for analyzing network traffic and attacks.

## 5. Virtualization
- You should become proficient in using virtualization software like VirtualBox or VMWare Workstation.
- A virtual environment provides a safe place to practice hacking before real-world attempts.
- Eventually, you'll want a virtual environment to analyze live malware or exploit virtualization systems.

## 6. Security Concepts & Technologies
- A good hacker understands security concepts and technologies.
- To overcome security measures, one must be familiar with concepts like PKI, SSL, IDS, firewalls, etc.
- Beginners can acquire these skills through basic security courses like CompTIA’s Security+ or through other resources.

## 7. Wi-Fi Technologies
- To hack Wi-Fi (802.11), you must understand its workings.
- This includes knowledge of encryption algorithms (WEP, WPA, WPA2), the four-way handshake, WPS, and legal constraints.
- Resources like tutorials and guides on wireless hacking can provide further information.
- Chapter 15 of a referenced book is dedicated to Wi-Fi hacks, with upcoming books also covering Wi-Fi technologies.
# Intermediate Skills 

## Overview
- **Importance**: Advancing beyond basic tools allows for more intuitive and effective hacks.
- **Recommendation**: Develop scripting skills, understand databases and web applications, and learn about forensics, TCP/IP, cryptography, and reverse engineering.

### 8. Scripting
- **Necessity**: Essential for developing unique tools and staying ahead of security defenses.
- **Languages**: BASH shell, Perl, Python, or Ruby.
- **Resources**: Tutorials available at www.hackers-arise.com/scripting.

### 9. Database Skills
- **Relevance**: Crucial for proficient database hacking.
- **Skills Needed**: Understanding of SQL language and mastery of major Database Management Systems (DBMS).
- **Tutorials**: SQL Injection (SQLi) tutorials at https://www.hackers-arise.com/database-hacking.

### 10. Web Applications
- **Opportunity**: Fertile ground for hackers.
- **Importance**: Understanding how web applications and databases behind them work is key.
- **Recommendation**: Consider building your own website for phishing and other purposes.
- **Resources**: Series on Web App Hacking at www.hackers-arise.com/web-app-hacking.

### 11. Forensics
- **Importance**: Crucial for evading detection.
- **Knowledge**: Understanding of digital forensics helps in avoiding detection.
- **Resources**: Series on Digital Forensics and Network Forensics at www.hackers-arise.com/network-forensics-1.

### 12. Advanced TCP/IP
- **Requirement**: Understanding TCP/IP basics is essential.
- **Advanced Knowledge**: Intimate details of the TCP/IP protocol stack and fields are necessary.
- **Manipulation**: Understanding how TCP/IP fields can be manipulated for attacks like man-in-the-middle (MitM).

### 13. Cryptography
- **Understanding**: Knowledge of strengths and weaknesses of cryptographic algorithms is beneficial.
- **Usage**: Cryptography can be used by hackers to hide activities and evade detection.
- **Resource**: Basics of cryptography in Appendix A “Cryptography Basics for Hackers.”

### 14. Reverse Engineering
- **Purpose**: Opening and rebuilding malware with additional features.
- **Importance**: Enables reuse of components from existing malware.

# Essential Tools

## Overview
- **Challenge**: The abundance of hacking tools can overwhelm beginners, leading to frustration or inaction.
- **Solution**: Focus on mastering essential tools first to build hacker/infosec skills, while not ignoring others.

## Essential Tools of the Master Hacker
- **Purpose**: These tools are crucial for aspiring hackers, though not exhaustive.
- **Guidance**: Choose the appropriate tool depending on the task at hand.

### 1. Nmap
- **Function**: Port scanning and more.
- **History**: One of the first port scanners, active for over 20 years.
- **Enhancements**: Continuous improvements, including nmap scripts for various functions.

### 2. Wireshark
- **Function**: Network packet analysis.
- **Importance**: Essential for IT professionals, allowing in-depth network analysis.
- **Capabilities**: Interactively browse data, develop display filters, view TCP session streams.

### 3. Metasploit
- **Role**: Leading exploitation framework.
- **Features**: Comprehensive package for pentesting, from scanning to post-exploitation.
- **Versions**: Free version available, with commercial versions offering additional features.

### 4. BurpSuite
- **Focus**: Web application attacks.
- **Variants**: Free limited version, pro version with advanced features.
- **Source**: Available from www.portswigger.com.

### 5. Aircrack-ng
- **Use**: Wireless technology analysis and cracking.
- **Complement**: Many Wi-Fi tools use Aircrack-ng functionality.
- **Functions**: Monitoring, dumping, cracking, creating an Evil Twin, and more.

### 6. Sysinternals
- **Origin**: Developed by Mark Russinovich, now part of Microsoft.
- **Purpose**: Analyze internal processes of Windows operating systems.
- **Tools**: Notable ones include Process Explorer and Process Monitor.

### 7. Snort
- **Role**: Widely used network intrusion detection system (NIDS).
- **History**: Started as an open-source project, now integrated into Cisco products.
- **Usage**: Also employed in other IDS products.

### 8. sqlmap
- **Specialty**: Automating SQL injection (SQLi) attacks.
- **Features**: Database fingerprinting, data dumping, OS access on web servers.

### 9. Ettercap
- **Application**: Conducting Man-in-The-Middle (MiTM) attacks on LANs.
- **Interface**: User-friendly GUI for easier exploitation.

### 10. OWASP-ZAP
- **Focus**: Web application vulnerability scanning.
- **Advantages**: Free, open-source, platform-independent, with an easy-to-use GUI.
- **Purpose**: Scanning for known vulnerabilities in web applications.

### 11. John the Ripper
- **Type**: Linux-based password cracking tool.
- **Features**: Detects hash type, performs dictionary and brute-force attacks.
- **Interface**: Command-line tool for simplicity and efficiency.

### 12. hashcat
- **Functionality**: Linux-based password cracker.
- **Performance**: Known for being one of the world's fastest open-source password crackers.
- **GPU Utilization**: Capable of using GPU for faster hash cracking.

### 13. BeEF
- **Definition**: Browser Exploitation Framework Project.
- **Usage**: Exploits target's browser for various malicious activities.
- **Resource**: Chapter 17 in this book or https://www.hackers-arise.com

### 14. THC-Hydra
- **Use**: Remote password cracking.
- **Protocols**: Capable of dictionary attacks against multiple protocols.
- **Resource**: https://www.hackers-arise.com/post/2018/06/21/online-password-cracking-with-thchydra-and-burpsuite

### 15. Nessus
- **Purpose**: Popular vulnerability scanner.
- **History**: Initially open-source, now owned by Tenable.
- **Versions**: Commercial and free versions available.

### 16. Shodan
- **Description**: Internet search engine for web banners.
- **Functionality**: Scans IPs for web banners, useful for finding specific characteristics.
- **Resource**: Chapter 5 in this book or https://www.hackers-arise.com/shodan

### 17. Ollydbg
- **Type**: 32-bit (x86) debugger for Windows.
- **Function**: Analyze and decipher software without source code.
- **Uses**: Reverse engineering software, ensuring program functionality.

---

This list covers essential tools for mastering hacking and infosec skills. While not exhaustive, focusing on these tools first can provide a strong foundation for further learning and specialization.
