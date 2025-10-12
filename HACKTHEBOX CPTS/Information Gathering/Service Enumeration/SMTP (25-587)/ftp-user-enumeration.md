# FTP User Enumeration

Students first need to download the "Footprinting-wordlist.zip"wordlist ZIP file from the "Resources" tab and then unzip it:

```shell
wget https://academy.hackthebox.com/storage/resources/Footprinting-wordlist.zip
unzip Footprinting-wordlist.zip
```


```bash
┌─[us-academy-1]─[10.10.14.69]─[htb-ac413848@pwnbox-base]─[~]
└──╼ [★]$ wget https://academy.hackthebox.com/storage/resources/Footprinting-wordlist.zip

--2022-08-03 06:53:53--  https://academy.hackthebox.com/storage/resources/Footprinting-wordlist.zip
Resolving academy.hackthebox.com (academy.hackthebox.com)... 104.18.20.126, 104.18.21.126, 2606:4700::6812:147e, ...
Connecting to academy.hackthebox.com (academy.hackthebox.com)|104.18.20.126|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 602 [application/zip]
Saving to: ‘Footprinting-wordlist.zip’

Footprinting-wordlist.zi 100%[==================================>]     602  --.-KB/s    in 0s      

2022-08-03 06:53:53 (10.3 MB/s) - ‘Footprinting-wordlist.zip’ saved [602/602]
┌─[us-academy-1]─[10.10.14.69]─[htb-ac413848@pwnbox-base]─[~]
└──╼ [★]$ unzip Footprinting-wordlist.zip

Archive:  Footprinting-wordlist.zip
  inflating: footprinting-wordlist.txt 
```

Subsequently, students need to use `smtp-user-enum`, specifying the downloaded wordlist for the `-U` (short version of `file-of-usernames`) option, and 20 for the `-w` option, which sets the maximum number of seconds for waiting for replies:

```shell
smtp-user-enum -M VRFY -U ./footprinting-wordlist.txt -t STMIP -m 60 -w 20
```

```bash
┌─[us-academy-1]─[10.10.14.69]─[htb-ac413848@pwnbox-base]─[~]
└──╼ [★]$ smtp-user-enum -M VRFY -U ./footprinting-wordlist.txt -t 10.129.42.195 -m 60 -w 20

Starting smtp-user-enum v1.2 ( http://pentestmonkey.net/tools/smtp-user-enum )

 ----------------------------------------------------------
|                   Scan Information                       |
 ----------------------------------------------------------

Mode ..................... VRFY
Worker Processes ......... 60
Usernames file ........... ./footprinting-wordlist.txt
Target count ............. 1
Username count ........... 101
Target TCP port .......... 25
Query timeout ............ 20 secs
Target domain ............ 

#### Scan started at Wed Aug  3 06:52:48 2022 ####
10.129.42.195: robin exists
#### Scan completed at Wed Aug  3 06:53:04 2022 ####
1 results.

101 queries in 16 seconds (6.3 queries / sec)
```
