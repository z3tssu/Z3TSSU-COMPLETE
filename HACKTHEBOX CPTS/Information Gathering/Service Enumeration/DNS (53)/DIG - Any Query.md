We can use the option `ANY` to view all available records. This will cause the server to show us all available entries that it is willing to disclose. It is important to note that not all entries from the zones will be shown.

**DIG - ANY Query**

```bash
z3tssu@htb[/htb]$ dig any inlanefreight.htb @10.129.14.128

; <<>> DiG 9.16.1-Ubuntu <<>> any inlanefreight.htb @10.129.14.128

;; global options: +cmd

;; Got answer:

;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7649

;; flags: qr aa rd ra; QUERY: 1, ANSWER: 5, AUTHORITY: 0, ADDITIONAL: 2

;; OPT PSEUDOSECTION:

; EDNS: version: 0, flags:; udp: 4096

; COOKIE: 064b7e1f091b95120100000061476865a6026d01f87d10ca (good)

;; QUESTION SECTION:

;inlanefreight.htb. IN ANY

;; ANSWER SECTION:

inlanefreight.htb. 604800 IN TXT "v=spf1 include:mailgun.org include:_spf.google.com include:spf.protection.outlook.com include:_spf.atlassian.net ip4:10.129.124.8 ip4:10.129.127.2 ip4:10.129.42.106 ~all"

inlanefreight.htb. 604800 IN TXT "atlassian-domain-verification=t1rKCy68JFszSdCKVpw64A1QksWdXuYFUeSXKU"

inlanefreight.htb. 604800 IN TXT "MS=ms97310371"

inlanefreight.htb. 604800 IN SOA inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800

inlanefreight.htb. 604800 IN NS ns.inlanefreight.htb.

;; ADDITIONAL SECTION:

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

;; Query time: 0 msec

;; SERVER: 10.129.14.128#53(10.129.14.128)

;; WHEN: So Sep 19 18:42:13 CEST 2021

;; MSG SIZE rcvd: 437
```