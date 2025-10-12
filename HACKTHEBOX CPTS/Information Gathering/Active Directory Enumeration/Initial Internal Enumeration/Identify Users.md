# Kerbrute - Internal AD Username Enumeration

## Clone the Kerbrute GitHub Repository
Download source for compiling AD username enum tool.

Command:
```
sudo git clone https://github.com/ropnop/kerbrute.git
```

## Download the Userlist
Repo: https://github.com/insidetrust/statistically-likely-usernames
- Clone or download lists (e.g., jsmith.txt for common usernames).

## List Compilation Options for Kerbrute
Display available targets (Win/Linux/Mac).

Command (in kerbrute dir):
```
make help
```

## Compile Kerbrute for All Platforms
Build binaries for Linux/Win/macOS (x86/x64).

Command (in kerbrute dir):
```
sudo make all
```

## List Compiled Kerbrute Binaries
View output dir.

Command (in kerbrute dir):
```
ls dist/
```

## Test Kerbrute Binary
Run to verify + show cmds.

Command (in kerbrute/dist dir):
```
./kerbrute_linux_amd64
```

## Adding the Tool to our Path
Check PATH:
```
z3tssu@htb[/htb]$ echo $PATH
/home/htb-student/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/snap/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/htb-student/.dotnet/tools
```

## Moving the Binary
Move to PATH dir for global access.

Command (in kerbrute/dist dir):
```
z3tssu@htb[/htb]$ sudo mv kerbrute_linux_amd64 /usr/local/bin/kerbrute
```

## Enumerate AD Usernames with Kerbrute
Use Kerberos pre-auth fails to validate usernames from wordlist vs DC.

Command:
```
kerbrute userenum -d INLANEFREIGHT.LOCAL --dc 172.16.5.5 jsmith.txt -o valid_ad_users
```
- -d: Domain
- --dc: DC IP
- jsmith.txt: Userlist
- -o: Output file for valid users