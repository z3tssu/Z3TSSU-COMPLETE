
---

## **Overview**

`FinalRecon` is an all-in-one **web reconnaissance tool** that automates information gathering for a target domain. It is especially useful for **OSINT**, **initial recon**, and **pre-engagement scans**.

---

### **Features**

|**Category**|**Details**|
|---|---|
|**Header Info**|Detects server type, technologies, and possible misconfigurations.|
|**Whois Lookup**|Extracts domain registration info (registrant, registrar, dates, and contacts).|
|**SSL Info**|Gathers SSL/TLS certificate details, issuer info, and expiry status.|
|**Crawler**|Collects links, images, JavaScript files, robots.txt, sitemap.xml, and finds historical URLs via the Wayback Machine.|
|**DNS Enumeration**|Queries over **40 DNS record types**, including DMARC and SPF for email security.|
|**Subdomain Enumeration**|Uses APIs like crt.sh, ThreatMiner, VirusTotal, Shodan, BeVigil, etc.|
|**Directory Enumeration**|Supports custom wordlists and extensions for hidden files/directories.|
|**Wayback Machine**|Retrieves archived URLs from the last **five years**.|
|**Port Scanning**|Fast scanning for common open ports.|

---

## **Installation**

```bash
git clone https://github.com/thewhiteh4t/FinalRecon.git
cd FinalRecon
pip3 install -r requirements.txt
chmod +x ./finalrecon.py
./finalrecon.py --help
```

---

## **Common Options**

|**Option**|**Description**|
|---|---|
|`--headers`|Header information|
|`--sslinfo`|SSL certificate info|
|`--whois`|Whois lookup|
|`--crawl`|Crawl target site|
|`--dns`|DNS enumeration|
|`--sub`|Subdomain enumeration|
|`--dir`|Directory discovery|
|`--wayback`|Retrieve URLs from Wayback Machine|
|`--ps`|Fast port scan|
|`--full`|Run full reconnaissance scan|

---

## **Example Commands**

### **Headers + Whois Lookup**

```bash
./finalrecon.py --headers --whois --url http://inlanefreight.com
```

### **Full Recon**

```bash
./finalrecon.py --full --url http://inlanefreight.com
```

### **Directory Enumeration with Custom Wordlist**

```bash
./finalrecon.py --dir --url http://inlanefreight.com -w /usr/share/wordlists/dirb/common.txt
```

---

Would you like me to create a **custom workflow** using FinalRecon for automating a **full recon pipeline**?