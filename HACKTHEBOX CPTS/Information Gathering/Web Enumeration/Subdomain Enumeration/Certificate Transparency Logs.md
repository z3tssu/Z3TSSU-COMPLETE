
## **Overview**

- **Certificate Transparency (CT) Logs** are **public append-only ledgers** recording the issuance of SSL/TLS certificates.
    
- Every time a **Certificate Authority (CA)** issues a certificate, it is submitted to multiple CT logs.
    
- Maintained by independent organizations and are **publicly accessible** for anyone to inspect.
    
- Useful for:
    
    - **Enumerating subdomains**
        
    - Identifying **new or hidden environments** like `dev`, `staging`, or `internal`.
        

---

## **crt.sh Lookup**

### **Basic Usage**

```bash
curl -s "https://crt.sh/?q=<target_domain>&output=json" | jq
```

---

### **Example: Filtering for `dev` Subdomains**

```bash
curl -s "https://crt.sh/?q=facebook.com&output=json" \
| jq -r '.[]
 | select(.name_value | contains("dev")) 
 | .name_value' \
| sort -u
```

---

### **Sample Output**

```
*.dev.facebook.com
*.newdev.facebook.com
*.secure.dev.facebook.com
dev.facebook.com
devvm1958.ftw3.facebook.com
facebook-amex-dev.facebook.com
facebook-amex-sign-enc-dev.facebook.com
newdev.facebook.com
secure.dev.facebook.com
```

---

Would you like me to show how to **automate this lookup** for multiple domains in a script?