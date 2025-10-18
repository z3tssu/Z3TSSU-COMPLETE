[TryHackMe \| HackPark](https://tryhackme.com/room/hackpark)

---
# Enumeration
## Nmap
```
nmap -p- 10.10.158.222
```

## Port 80 - Webserver
![[Pasted image 20251018151941.png]]

# Whats the name of the clown displayed on the homepage?
The hint indicates that we have to conduct a reverse image search of the image, a quick google search will provide sites like: tinyeye, etc. Paste the image and sources of other matches will be there
![[Pasted image 20251018152626.png]]
The Clown itself is from the movie IT, with the name: Pennywise

# Using Hydra to brute-force a login
![[Pasted image 20251018152750.png]]
The login page can be found at the URL: [Title Unavailable \| Site Unreachable](http://10.10.205.233/Account/login.aspx?ReturnURL=/admin/)

We have seen that the user "Administrator" created the clown post, so we can assume that that is a user which we can use to log into the website
Lets give it a try with Hydra
## What request type is the Windows website login form using?
1. We can inspect the login page using the firefox inspect feature of if we used burpsuite to capture the packet
![[Pasted image 20251018153257.png]]

## Cracking POST Request Login Page with Hydra (http-post-form)
```
hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V

```

