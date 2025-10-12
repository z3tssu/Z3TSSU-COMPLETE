
## **Purpose**

- A **DNS Zone Transfer** (`AXFR`) is used to **replicate DNS records** between primary and secondary DNS servers.
    
- Misconfigured DNS servers may allow **unauthenticated zone transfers**, exposing:
    
    - Subdomains
        
    - Internal IP addresses
        
    - Host configurations
        

---

## **Command Syntax**

```bash
dig axfr <domain_name> @<dns_server_ip>
```

---

## **Example**

```bash
dig axfr inlanefreight.htb @10.129.180.56
```

---

## **Sample Output**

```
inlanefreight.htb.         604800  IN  SOA     inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800
inlanefreight.htb.         604800  IN  NS      ns.inlanefreight.htb.
admin.inlanefreight.htb.   604800  IN  A       10.10.34.2
ftp.admin.inlanefreight.htb. 604800 IN  A       10.10.34.2
careers.inlanefreight.htb. 604800  IN  A       10.10.34.50
dc1.inlanefreight.htb.     604800  IN  A       10.10.34.16
dc2.inlanefreight.htb.     604800  IN  A       10.10.34.11
internal.inlanefreight.htb. 604800 IN  A       127.0.0.1
admin.internal.inlanefreight.htb. 604800 IN A  10.10.1.11
wsus.internal.inlanefreight.htb.  604800 IN A  10.10.1.240
ir.inlanefreight.htb.      604800  IN  A       10.10.45.5
dev.ir.inlanefreight.htb.  604800  IN  A       10.10.45.6
resources.inlanefreight.htb. 604800 IN A       10.10.34.100
securemessaging.inlanefreight.htb. 604800 IN A 10.10.34.52
us.inlanefreight.htb.      604800  IN  A       10.10.200.5
cluster14.us.inlanefreight.htb. 604800 IN A    10.10.200.14
messagecenter.us.inlanefreight.htb. 604800 IN A 10.10.200.10
www1.inlanefreight.htb.    604800  IN  A       10.10.34.111
```

---

## **Key Findings**

- Subdomains discovered:
    
    - `admin.inlanefreight.htb`
        
    - `internal.inlanefreight.htb`
        
    - `wsus.internal.inlanefreight.htb`
        
- Internal hosts and IPs:
    
    - `10.10.34.2`, `10.10.34.50`, `10.10.1.240`, etc.
        
- Useful for:
    
    - Mapping internal network structure
        
    - Identifying potential targets for further enumeration or exploitation
        

---

Would you like me to create a **script** to extract and organize subdomains and IPs automatically from the zone transfer output?