
## **Types of Cloud Providers**

1. **Amazon Web Services (AWS)**
    
2. **Google Cloud Platform (GCP)**
    
3. **Microsoft Azure**
    

---

## **Common Cloud Vulnerabilities**

1. **Misconfigured Resources**
    
    - Often caused by administrative errors.
        
2. **Unauthenticated Access**
    
    - Common in misconfigured storage services:
        
        - AWS **S3 Buckets**
            
        - Azure **Blobs**
            
        - GCP **Cloud Storage**
            

---

## **Searching for Company-Hosted Servers or Documents**

### **Check Subdomains for Cloud Links**

```bash
for i in $(cat subdomainlist); do 
    host $i | grep "has address" | grep inlanefreight.com | cut -d" " -f1,4
done
```

**Example Output**

```
blog.inlanefreight.com 10.129.24.93
inlanefreight.com 10.129.27.33
matomo.inlanefreight.com 10.129.127.22
www.inlanefreight.com 10.129.127.33
s3-website-us-west-2.amazonaws.com 10.129.95.250
```

---

### **Google Dorks**

**For AWS**

```bash
intext: inurl:amazonaws.com
```

**For Azure**

```bash
intext: inurl:blob.core.windows.net
```

---

## **Analyzing Target Website Source Code**

- Review the website's source for:
    
    - **Exposed file paths**
        
    - **Configuration data**
        
    - **API keys or tokens**
        
- These can hint at cloud storage locations or insecure integrations.
    

---

## **Third-Party Recon Tools**

### **Domain Glass**

- Tool: [https://domain.glass/](https://domain.glass/)
    
- Uses:
    
    - Map a company's infrastructure.
        
    - Identify technologies and services.
        
    - Check **security assessment status** (e.g., if behind Cloudflare).
        

---

### **GrayHatWarfare**

- Tool: [https://buckets.grayhatwarfare.com/](https://buckets.grayhatwarfare.com/)
    
- Uses:
    
    - Discover **AWS**, **Azure**, and **GCP** storage buckets.
        
    - Filter by **file type** to find sensitive data.
        

**Example Risk**

- Leaked **SSH Private Keys** stored in public buckets, allowing unauthorized access to internal systems.
    

---