[TryHackMe \| Game Zone](https://tryhackme.com/room/gamezone)

Learn to hack into this machine. Understand how to use SQLMap, crack some passwords, reveal services using a reverse SSH tunnel and escalate your privileges to root!

---
Let begin with an Nmap scan to start this penetration test of
```
nmap -p- -T5 ip_address
```

While that runs, i checked the ip address in a browser to see if there is a webserver running, and there is in fact on running on port 80 and i see that there is an ssh on port 22
![[Pasted image 20251020191653.png]]

# Webserver Port 80
![[Pasted image 20251020191719.png]]

Seems to be a game themed webpage of the game Hitman, and the first question asks for the name of the character displayed 

Since i have played this game a lot, i already know the name of this character

***Task 1 Answer: Agent 47***

---
# Understanding SQL

so b