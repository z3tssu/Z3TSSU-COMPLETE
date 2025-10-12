  

> Its typically advised to scan without the -A first, then when you have identified the open ports, you can scan those ports with -p with the -A

> You typically let the NMAP Scan run, and you for and perform other OSINT or reconnaissance.

# Nmap Syntax

### Nmap -T4 -A -p- IP-Address

```JavaScript
nmap -T4 -A -p- IP-Address
```

- T4 | Speed of scan
- -p- | Scan the most common ports
- -A | Aggressive scan

![[/image 68.png|image 68.png]]

### Nmap UDP Scan

```JavaScript
nmap -sU -T4 -p IP-Address
```

- -sU
    - UDP Scan

### Common Nmap Tags

|   |   |
|---|---|
|-sV|Service Version|
|-sC|Script Scanning|
|-O|Operating System Detection|
|||

# Nmap Scan Results (Nikto Lab)

![[/image 1 16.png|image 1 16.png]]

# What to do after the scan results?

1. After the scan results, look at the OPEN ports and look at what is running on those ports
2. Then you need to perform research on the port number and the service version that is running
3. You can use rapid7 exploit or other found exploit for that service