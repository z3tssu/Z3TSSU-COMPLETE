Many different tools can be used for this, and most of them work in the same way. One of these tools is, for example [DNSenum](https://github.com/fwaeytens/dnsenum).

```bash
z3tssu@htb[/htb]$ dnsenum --dnsserver 10.129.14.128 --enum -p 0 -s 0 -o subdomains.txt -f /opt/useful/seclists/Discovery/DNS/subdomains-top1million-110000.txt inlanefreight.htb

dnsenum VERSION:1.2.6

----- inlanefreight.htb -----

Host's addresses:

__________________

Name Servers:

______________

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

Mail (MX) Servers:

___________________

Trying Zone Transfers and getting Bind Versions:

_________________________________________________

unresolvable name: ns.inlanefreight.htb at /usr/bin/dnsenum line 900 thread 1.

Trying Zone Transfer for inlanefreight.htb on ns.inlanefreight.htb ...

AXFR record query failed: no nameservers

Brute forcing with /home/cry0l1t3/Pentesting/SecLists/Discovery/DNS/subdomains-top1million-110000.txt:

_______________________________________________________________________________________________________

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

mail1.inlanefreight.htb. 604800 IN A 10.129.18.201

app.inlanefreight.htb. 604800 IN A 10.129.18.15

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

...SNIP...

done.
```