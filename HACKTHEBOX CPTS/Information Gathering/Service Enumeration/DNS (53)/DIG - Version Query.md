Sometimes it is also possible to query a DNS server's version using a class CHAOS query and type TXT. However, this entry must exist on the DNS server. For this, we could use the following command:

**DIG - Version Query**

```bash
z3tssu@htb[/htb]$ dig CH TXT version.bind 10.129.120.85

; <<>> DiG 9.10.6 <<>> CH TXT version.bind

;; global options: +cmd

;; Got answer:

;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47786

;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; ANSWER SECTION:

version.bind. 0 CH TXT "9.10.6-P1"

;; ADDITIONAL SECTION:

version.bind. 0 CH TXT "9.10.6-P1-Debian"

;; Query time: 2 msec

;; SERVER: 10.129.120.85#53(10.129.120.85)

;; WHEN: Wed Jan 05 20:23:14 UTC 2023

;; MSG SIZE rcvd: 101
```