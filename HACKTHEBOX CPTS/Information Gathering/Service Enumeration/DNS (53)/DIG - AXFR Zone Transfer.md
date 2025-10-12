  
```bash
z3tssu@htb[/htb]$ dig axfr inlanefreight.htb @10.129.14.128

​

; <<>> DiG 9.16.1-Ubuntu <<>> axfr inlanefreight.htb @10.129.14.128

;; global options: +cmd

inlanefreight.htb. 604800 IN SOA inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800

inlanefreight.htb. 604800 IN TXT "MS=ms97310371"

inlanefreight.htb. 604800 IN TXT "atlassian-domain-verification=t1rKCy68JFszSdCKVpw64A1QksWdXuYFUeSXKU"

inlanefreight.htb. 604800 IN TXT "v=spf1 include:mailgun.org include:_spf.google.com include:spf.protection.outlook.com include:_spf.atlassian.net ip4:10.129.124.8 ip4:10.129.127.2 ip4:10.129.42.106 ~all"

inlanefreight.htb. 604800 IN NS ns.inlanefreight.htb.

app.inlanefreight.htb. 604800 IN A 10.129.18.15

internal.inlanefreight.htb. 604800 IN A 10.129.1.6

mail1.inlanefreight.htb. 604800 IN A 10.129.18.201

ns.inlanefreight.htb. 604800 IN A 10.129.34.136

inlanefreight.htb. 604800 IN SOA inlanefreight.htb. root.inlanefreight.htb. 2 604800 86400 2419200 604800

;; Query time: 4 msec

;; SERVER: 10.129.14.128#53(10.129.14.128)

;; WHEN: So Sep 19 18:51:19 CEST 2021

;; XFR size: 9 records (messages 1, bytes 520)
```

​

#### [](https://app.gitbook.com/o/yaG9lrNlT0UmTITUeBmb/s/K3YP1U2Fck03eUZ2XijJ/cybersecurity-certifications-and-notes/certifications-and-courses/hackthebox-cpts/footprinting/host-based-service-enumeration/dns-53/footprinting-dns/dig-axfr-zone-transfer#what-is-zone-transfer-in-dns)**What is Zone Transfer in DNS?**

- **DNS (Domain Name System)** is like the phonebook of the internet, helping to map domain names (like `example.com`) to IP addresses (like `192.0.2.1`).
    

- A **zone** is a portion of the DNS database for a specific domain (e.g., all the information for `example.com`).
    

- A **zone transfer** is the process of copying the DNS records of a domain from one DNS server to another. This happens to keep multiple servers synchronized so they all have the same information.
    

#### [](https://app.gitbook.com/o/yaG9lrNlT0UmTITUeBmb/s/K3YP1U2Fck03eUZ2XijJ/cybersecurity-certifications-and-notes/certifications-and-courses/hackthebox-cpts/footprinting/host-based-service-enumeration/dns-53/footprinting-dns/dig-axfr-zone-transfer#how-does-zone-transfer-work)**How Does Zone Transfer Work?**

- **Primary vs. Secondary DNS Servers:**
    
    - The **Primary DNS Server** (also called the **Master**) holds the original copy of the zone data for a domain.
        
    
    - The **Secondary DNS Servers** (also called **Slaves**) hold copies of the zone data. These servers ensure redundancy and help share the load, improving both reliability and performance.
        
    

- **Why is it Important?**
    
    - If the primary server goes down, secondary servers can continue to provide DNS services. This reduces the risk of DNS failures, which could be disastrous for a company.
        
    

- **Synchronization Between Servers:**
    
    - Whenever there's a change in the primary server's DNS records (like adding, removing, or updating an entry), those changes need to be passed on to the secondary servers.
        
    
    - This **synchronization** is done through zone transfers, which happen at regular intervals. For example, every hour, the secondary servers check if the primary server has updated records.
        
    

- **AXFR (Asynchronous Full Transfer Zone):**
    
    - When a zone transfer happens, it's often done using a protocol called **AXFR**, which means a **full copy** of the zone is sent from the primary server to the secondary server.
        
    
    - It ensures that both the primary and secondary servers have identical data.
        
    

- **How do Servers Communicate?**
    
    - To make sure that only authorized servers perform zone transfers, a secret key (called **rndc-key**) is used for secure communication.
        
    
    - This ensures that only trusted servers can update or retrieve the zone data.
        
    

- **How Do Secondary Servers Know When to Update?**
    
    - The secondary servers regularly check the **SOA record** (Start of Authority) from the primary server.
        
    
    - The **SOA record** contains important information, including a **serial number** that indicates the version of the zone data.
        
    
    - If the serial number on the primary server is **higher** than what the secondary server has, it knows that the data has changed, and it needs to fetch the updated records.
        
    

- **Master vs. Slave:**
    
    - The **Master** server is the main source of truth for zone data.
        
    
    - The **Slave** server copies data from the Master, and both servers are synchronized to prevent any discrepancies.
        
    

#### [](https://app.gitbook.com/o/yaG9lrNlT0UmTITUeBmb/s/K3YP1U2Fck03eUZ2XijJ/cybersecurity-certifications-and-notes/certifications-and-courses/hackthebox-cpts/footprinting/host-based-service-enumeration/dns-53/footprinting-dns/dig-axfr-zone-transfer#example-of-zone-transfer-process)**Example of Zone Transfer Process:**

- The primary server holds the DNS records for `example.com`.
    

- A secondary server asks the primary server for updates at regular intervals (e.g., every hour).
    

- The primary server compares the zone records and, if it detects any changes (based on the serial number), it sends the updated data to the secondary server.
    

- The secondary server receives the update, checks for consistency, and stores the new records.
    

This way, DNS data remains consistent across multiple servers, ensuring that your website is always accessible and reliable, even if one server goes down.

#### [](https://app.gitbook.com/o/yaG9lrNlT0UmTITUeBmb/s/K3YP1U2Fck03eUZ2XijJ/cybersecurity-certifications-and-notes/certifications-and-courses/hackthebox-cpts/footprinting/host-based-service-enumeration/dns-53/footprinting-dns/dig-axfr-zone-transfer#in-summary)**In Summary:**

- **Zone transfer** ensures that all DNS servers for a domain have the same data.
    

- This is done by transferring the zone files from a **Master** (Primary) server to **Slave** (Secondary) servers.
    

- Zone transfers are crucial for keeping DNS data synchronized and preventing outages.