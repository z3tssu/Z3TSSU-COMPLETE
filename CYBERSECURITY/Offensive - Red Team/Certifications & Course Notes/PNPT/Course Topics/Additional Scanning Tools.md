---
Status: Done
---
# masscan Scanning

- A really fast port scanner

- Normal Scan
    
    ```JavaScript
    masscan -p1-65535 ip_address 
    ```
    

# Metasploit Scanning

- Open metasploit
    
    ```JavaScript
    msfconsole
    ```
    
- search portscan
- options
- set RHOSTS ip_address
- set ports 1-65535
- run

# Nessus Scanning

- Nessus is a vulnerability scanner

- Installing Nessus
    
    1. Go to Google
    2. Search for Nessus download
    3. Download the Debian version
    
    - Install using 
        
        ```JavaScript
        dpkg -i package_name
        ```
        
    - Run Nessus using
        
        ```Bash
        /bin/systemctl start nessusd.service
        ```
        
    - In browser URL type
        
        ```Bash
        https://kali:8834
        ```