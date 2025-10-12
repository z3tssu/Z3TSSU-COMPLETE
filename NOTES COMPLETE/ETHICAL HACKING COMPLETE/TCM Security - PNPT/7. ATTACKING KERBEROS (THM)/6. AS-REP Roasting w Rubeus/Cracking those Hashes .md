---
title: 'Cracking those Hashes '
updated: 2023-04-01T21:53:01.0000000+04:00
created: 2023-04-01T21:52:22.0000000+04:00
---

Cracking those Hashes
Saturday, April 1, 2023
9:52 PM
1.) Transfer the hash from the target machine over to your attacker machine and put the hash into a txt file

2.) Insert 23\$ after \$krb5asrep\$ so that the first line will be \$krb5asrep\$23\$User.....

Use the same wordlist that you downloaded in task 4

3.) hashcat -m 18200 hash.txt Pass.txt

\- crack those hashes! Rubeus AS-REP Roasting uses hashcat mode 18200
