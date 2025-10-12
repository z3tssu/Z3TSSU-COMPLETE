The footprinting at DNS servers is done as a result of the requests we send. So, first of all, the DNS server can be queried as to which other name servers are known. We do this using the NS record and the specification of the DNS server we want to query using the `@` character. This is because if there are other DNS servers, we can also use them and query the records. However, other DNS servers may be configured differently and, in addition, may be permanent for other zones.

```bash
z3tssu@htb[/htb]$ dig ns inlanefreight.htb @10.129.14.128

; <<>> DiG 9.16.1-Ubuntu <<>> ns inlanefreight.htb @10.129.14.128

;; global options: +cmd

;; Got answer:

;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 45010

;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 2

;; OPT PSEUDOSECTION:

; EDNS: version: 0, flags:; udp: 4096

; COOKIE: ce4d8681b32abaea0100000061475f73842c401c391690c7 (good)

;; QUESTION SECTION:

;inlanefreight.htb. IN NS

;; ANSWER SECTION:

inlanefreight.htb. 604800 IN NS ns.inlanefreight.htb.

;; ADDITIONAL SECTION:

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

;; Query time: 0 msec

;; SERVER: 10.129.14.128#53(10.129.14.128)

;; WHEN: So Sep 19 18:04:03 CEST 2021

;; MSG SIZE rcvd: 107
```