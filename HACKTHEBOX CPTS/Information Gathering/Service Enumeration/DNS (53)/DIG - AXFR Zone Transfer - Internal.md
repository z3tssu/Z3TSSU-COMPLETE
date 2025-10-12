If the administrator used a subnet for the `allow-transfer` option for testing purposes or as a workaround solution or set it to `any`, everyone would query the entire zone file at the DNS server. In addition, other zones can be queried, which may even show internal IP addresses and hostnames.

**DIG - AXFR Zone Transfer - Internal**

```bash
z3tssu@htb[/htb]$ dig axfr internal.inlanefreight.htb @10.129.14.128

; <<>> DiG 9.16.1-Ubuntu <<>> axfr internal.inlanefreight.htb @10.129.14.128

;; global options: +cmd

internal.inlanefreight.htb. 604800 IN SOA inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800

internal.inlanefreight.htb. 604800 IN TXT "MS=ms97310371"

internal.inlanefreight.htb. 604800 IN TXT "atlassian-domain-verification=t1rKCy68JFszSdCKVpw64A1QksWdXuYFUeSXKU"

internal.inlanefreight.htb. 604800 IN TXT "v=spf1 include:mailgun.org include:_spf.google.com include:spf.protection.outlook.com include:_spf.atlassian.net ip4:10.129.124.8 ip4:10.129.127.2 ip4:10.129.42.106 ~all"

internal.inlanefreight.htb. 604800 IN NS ns.inlanefreight.htb.

dc1.internal.inlanefreight.htb. 604800 IN A 10.129.34.16

dc2.internal.inlanefreight.htb. 604800 IN A 10.129.34.11

mail1.internal.inlanefreight.htb. 604800 IN A 10.129.18.200

ns.internal.inlanefreight.htb. 604800 IN A 10.129.34.136

vpn.internal.inlanefreight.htb. 604800 IN A 10.129.1.6

ws1.internal.inlanefreight.htb. 604800 IN A 10.129.1.34

ws2.internal.inlanefreight.htb. 604800 IN A 10.129.1.35

wsus.internal.inlanefreight.htb. 604800 IN A 10.129.18.2

internal.inlanefreight.htb. 604800 IN SOA inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800

;; Query time: 0 msec

;; SERVER: 10.129.14.128#53(10.129.14.128)

;; WHEN: So Sep 19 18:53:11 CEST 2021

;; XFR size: 15 records (messages 1, bytes 664)
```