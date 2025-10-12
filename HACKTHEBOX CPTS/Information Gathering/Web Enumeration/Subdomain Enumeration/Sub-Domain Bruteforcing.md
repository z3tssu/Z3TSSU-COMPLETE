
## **Common Tools**

|Tool|Description|
|---|---|
|[**dnsenum**](https://github.com/fwaeytens/dnsenum)|Comprehensive DNS enumeration tool supporting dictionary and brute-force attacks for subdomain discovery.|
|[**fierce**](https://github.com/mschwager/fierce)|User-friendly tool for recursive subdomain discovery with wildcard detection and simple usage.|
|[**dnsrecon**](https://github.com/darkoperator/dnsrecon)|Versatile tool that supports multiple DNS reconnaissance techniques and customizable outputs.|
|[**amass**](https://github.com/owasp-amass/amass)|Actively maintained tool for advanced subdomain discovery, integrating multiple data sources.|
|[**assetfinder**](https://github.com/tomnomnom/assetfinder)|Lightweight and fast subdomain finder for quick reconnaissance.|
|[**puredns**](https://github.com/d3mondev/puredns)|High-performance tool for DNS brute-forcing and filtering resolved domains effectively.|

---

## **Example Command**

### **Using `dnsenum`**

```bash
dnsenum --enum inlanefreight.com \
-f /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -r
```

- `--enum` → Enables enumeration mode
    
- `-f` → Specifies the wordlist to use
    
- `-r` → Performs recursive subdomain enumeration
    

---
