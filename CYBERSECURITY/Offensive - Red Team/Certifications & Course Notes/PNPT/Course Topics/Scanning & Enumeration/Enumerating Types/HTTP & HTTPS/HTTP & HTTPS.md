---
Type:
  - http
---
> [!important] HTTP and HTTPS is typically on ==port 80 and 443==

# First Step

- If port 80 and 443 is found and is open
- That means that the IP Address possibly has a web-server running
- So it is important that you visit the IP address to enumerate further on the website and possibly compromise it

# Default Webpage on Kioptrix (TCM Lab)

![[/image 66.png|image 66.png]]

# What does Default Webpage mean?

- It means poor hygiene
- They IT personnel did not disable this webpage
- It is an automatic vulnerability finding
    - tells us about the architecture
    - tells us about the poor hygiene
    - we need to include this in our notes for our report

# Steps after finding a webpage?

1. You can perform directory brute forcing
2. You can try and perform some web-application attacks

## Web Vulnerability Scanning on Found Webpages (Nikto)

## Nikto - Web Application Vulnerability Scanning

- A web vulnerability scanning tool
- ==Syntax==
    
    - ==nikto -h webpage==
    
    ![[/image 1 14.png|image 1 14.png]]
    
- Nikto will show us several vulnerabilities it identifies
- It will perform a slight directory brute force

## Directory Brute force

### Dirb

### Dirbuster

- Open Terminal and run
    1. Dirbuster
- It will open a window
    
    ![[/image 2 12.png|image 2 12.png]]
    
    1. You need to enter the webpage
        1. ==http://ip_address:portnumber==
    2. You need to select a wordlist file
    3. select the number of threads
    4. and press start

### Gobuster

![[/image 3 10.png|image 3 10.png]]

```JavaScript
gobuster dir -u website -w wordlist_location
```