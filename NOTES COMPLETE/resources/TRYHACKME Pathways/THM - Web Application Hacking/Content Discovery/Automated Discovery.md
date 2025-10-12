---
title: Automated Discovery
updated: 2022-11-23T11:28:36.0000000+04:00
created: 2022-11-23T11:26:19.0000000+04:00
---

AM
**Using ffuf:**

ffuf
user@machine\$ ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -u <http://10.10.237.147/FUZZ>

**Using dirb:**

dirb
user@machine\$ dirb <http://10.10.237.147/> /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt

**Using Gobuster:**

gobuster
user@machine\$ gobuster dir --url <http://10.10.237.147/> -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt
