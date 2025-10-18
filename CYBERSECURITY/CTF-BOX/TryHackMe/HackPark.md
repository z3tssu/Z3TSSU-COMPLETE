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
## 