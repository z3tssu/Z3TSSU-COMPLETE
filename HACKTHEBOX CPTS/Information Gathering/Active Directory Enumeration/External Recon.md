# EXTERNAL RECON AND ENUMERATION PRINCIPLES

> Before kicking off any pentest, it can be beneficial to perform external reconnaissance of your target. This can serve many different functions, such as:

1. Validating information provided to you in the scoping document from the client
2. Ensuring you are taking actions against the appropriate scope when working remotely
3. Looking for any information that is publicly accessible that can affect the outcome of your test, such as leaked credentials

---

# What Are We Looking For?

During the early phase of an engagement, the goal is to systematically gather information that maps the organization's public-facing footprint, resources, and possible exposures. Below is an organized reference table and summary of what to look for during this phase:

## Data Points & Their Descriptions

|**Data Point**|**What to Search For**|
|---|---|
|**IP Space**|- Valid Autonomous System Numbers (ASNs) registered to the target- Netblocks in use (public IP ranges)- Associated cloud infrastructure and hosting providers- DNS record entries (A, AAAA, MX, TXT, etc.)|
|**Domain Information**|- Domains and subdomains owned or operated by the organization- Domain registration/WHOIS data (administrators, registrars)- Publicly accessible services tied to domains (mail servers, websites, VPN, DNS, portals)- Detection of technical defenses (SIEM, AV, IDS/IPS)|
|**Schema Format**|- Naming conventions for user email addresses and AD usernames (e.g., [john.smith@company.com](mailto:john.smith@company.com), jsmith)- Publicly readable password policies- Patterns useful for compiling valid username lists for external attack simulation (password spraying, brute force, etc.)|
|**Data Disclosures**|- Publicly accessible files (.pdf, .docx, .xlsx, .ppt, etc.)- Sensitive metadata in documents (internal URLs, usernames, software/hardware info)- Credentials or configurations exposed in public repositories (e.g., GitHub)- Evidence of internal infrastructure in file metadata|
|**Breach Data**|- Public datasets or leak sites posting usernames, passwords, or other sensitive information related to the target- Previously disclosed breaches referencing the organization- Data that could assist in gaining unauthorized access or further attacks|

# Where Are We Looking?

When gathering data points for an assessment, utilizing a variety of online resources ensures comprehensive and accurate findings. Below is an organized overview of key resource types, accompanied by notable examples and usage scenarios:

### **Information Gathering Resources**

|**Resource Type**|**Examples (with hyperlinks)**|**Typical Uses**|
|---|---|---|
|**ASN / IP Registrars**|[IANA](https://www.iana.org/), [ARIN](https://www.arin.net/), [RIPE NCC](https://www.ripe.net/), [BGP Toolkit](https://bgp.he.net/)|Identify IP/ASN ownership, map network infrastructure. IANA, arin for searching the Americas, RIPE for searching in Europe, BGP Toolkit|
|**Domain Registrars & DNS**|[DomainTools](https://www.domaintools.com/), [PTRArchive](http://ptrarchive.com/), [ICANN WHOIS Lookup](https://lookup.icann.org/lookup),|Get domain history, DNS records, WHOIS registration info|
|**Social Media**|[LinkedIn](https://www.linkedin.com/), [Twitter (X)](https://twitter.com/), [Facebook](https://www.facebook.com/), Region-specific sites, News search|Discover employees, roles, org updates, social intelligence|
|**Public Websites**|Company websites, [Contact Us](https://www.notion.so/EXTERNAL-RECON-AND-ENUMERATION-PRINCIPLES-235c8126a79b80bc8f86d8451b8c3c5e?pvs=21), [About Us](https://www.notion.so/EXTERNAL-RECON-AND-ENUMERATION-PRINCIPLES-235c8126a79b80bc8f86d8451b8c3c5e?pvs=21), Embedded documents on site|Understand corporate structure, contact details, leaked docs|
|**Cloud & Dev Storage**|[GitHub](https://github.com/), [GrayHatWarfare](https://grayhatwarfare.com/), [Google Dorks](https://www.exploit-db.com/google-hacking-database)|Locate public repositories, open storage, leaked dev secrets|
|**Breach Data Sources**|[HaveIBeenPwned](https://haveibeenpwned.com/), [DeHashed](https://www.dehashed.com/)|Find breached emails/passwords for an org, test reused creds|

---

## Find Address Spaces

Tool: [https://bgp.he.net/](https://bgp.he.net/)

- Researching what address blocks are assigned to an organization and what ASN they reside within

---

## DNS

DNS is a great way to validate our scope and find out about reachable hosts the customer did not disclose in their scoping document

### Tools

1. [https://whois.domaintools.com/](https://whois.domaintools.com/)
2. [https://viewdns.info/](https://viewdns.info/)

---

## Public Data

Publicly accessible information—especially from social media, job portals, and websites—offers deep insight into an organization’s structure, technology stack, security posture, and operational details. This intelligence forms the foundation for mapping potential attack surfaces and planning subsequent phases of a security assessment.

### Key Sources of Valuable Data

### 1. Social Media & Professional Networks

- **Platforms:** LinkedIn, Indeed, Glassdoor, company Twitter/Facebook.
- **What to Look For:**
    - Employee lists and organizational structure.
    - Technology mentions (e.g., SharePoint, Azure).
    - Skills and experience requirements in job ads.
    - Department growth or recent initiatives (hiring for “security” may indicate new or evolving programs).
- **Example:** A SharePoint Administrator job listing reveals use of SharePoint 2013/2016, suggesting coexistence of legacy and upgraded systems—potentially with lingering vulnerabilities.

### 2. Job Postings

- **Insights Gained:**
    - Internal software and hardware in use (e.g., SharePoint, specific ERP systems).
    - Security policies and programs (references to backup, DR, or compliance frameworks).
    - Network architecture clues (mention of cloud platforms like Azure or AWS).
    - Potentially outdated or niche systems in production.

### 3. Organization's Websites

- **Data of Interest:**
    - Contact emails and phone numbers.
    - Directories or organizational charts.
    - Published documents (PDFs, DOCX, PPT) that may include internal URLs, infrastructure diagrams, or even credentials in metadata.
- **Pro Tip:** Download and inspect embedded documents for hidden metadata with tools like ExifTool or built-in OS options.

### 4. Public Code & Cloud Resources

- **Open Platforms:** GitHub, AWS S3 buckets, GitLab, Bitbucket, public code repositories.
- **What to Search For:**
    - Hardcoded credentials or API tokens in public code.
    - Configuration files exposing endpoints or credential schemes.
    - Accidentally uploaded sensitive files—use tools like Trufflehog or Grep.
    - Openly indexed storage buckets or misconfigured access permissions.

### 5. Data Leak Aggregators

- Sites like [Greyhat Warfare](https://buckets.grayhatwarfare.com/) and [https://github.com/trufflesecurity/truffleHog](https://github.com/trufflesecurity/truffleHog) index exposed cloud storage or public data dumps, making unwittingly published information easy to discover, ranging from accidentally shared documents to source code and sensitive archives.

---

# Example Enumeration Process

- Will mostly focus on passive enumeration
- Enumerate: [inlanefreight.com](http://inlanefreight.com)

## Check for ASN/IP & Domain Data

### BGP Toolkit

[https://bgp.he.net/](https://bgp.he.net/)

From this first look, we have already gleaned some interesting info. BGP.he is reporting:

- IP Address: 134.209.24.248
- Mail Server: [mail1.inlanefreight.com](http://mail1.inlanefreight.com)
- Nameservers: [NS1.inlanefreight.com](http://NS1.inlanefreight.com) & [NS2.inlanefreight.com](http://NS2.inlanefreight.com)

### Viewdns Results

[https://viewdns.info/](https://viewdns.info/)

![image.png](attachment:e1f1b0e1-3101-4aea-8adf-d14142b50013:image.png)

In the request above, we utilized [viewdns.info](http://viewdns.info/) to validate the IP address of our target. Both results match, which is a good sign.

### Validate the two nameservers in our results.

```bash
z3tssu@htb[/htb]$ nslookup ns1.inlanefreight.com

Server:		192.168.186.1
Address:	192.168.186.1#53

Non-authoritative answer:
Name:	ns1.inlanefreight.com
Address: 178.128.39.165

nslookup ns2.inlanefreight.com
Server:		192.168.86.1
Address:	192.168.86.1#53

Non-authoritative answer:
Name:	ns2.inlanefreight.com
Address: 206.189.119.186 
```

We now have two new IP addresses to add to our list for validation and testing. Before taking any further action with them, ensure they are in-scope for your test. For our purposes, the actual IP addresses would not be in scope for scanning, but we could passively browse any websites to hunt for interesting data. For now, that is it with enumerating domain information from DNS. Let's take a look at the publicly available information.

### Social Media Presence

We would check sites like LinkedIn, Twitter, Instagram, and Facebook for helpful info if it were real. Instead, we will move on to examining the website [inlanefreight.com](http://inlanefreight.com/).

### Hunting for Files

```bash
filetype:pdf inurl:inlanefreight.com
```

![image.png](attachment:af37f318-025c-47c9-84a7-47b045e88517:image.png)

- Save the document and screenshot
- We will inspect the document after

### Hunting E-mail Addresses

```bash
<intext:"@inlanefreight.com>" inurl:inlanefreight.com
```

![image.png](attachment:fe418b57-16b4-4d62-8b6d-060e8cdd0efa:image.png)

### Email Dork Results

![image.png](attachment:a8e64851-99e3-4f70-88aa-e16a4d48ef03:image.png)

1. Browsed the contact page
2. Identified the naming convention
3. This could be handy in later password spraying attacks or if social engineering/phishing were part of our engagement scope.

### Username Harvesting

[https://github.com/initstring/linkedin2username](https://github.com/initstring/linkedin2username)

- Scrapes employee names from a company's LinkedIn page and creates a list of possible usernames based on formatting conventions.
    
- Usage
    
    ### Setup
    
    1. **Install the tool:**
    
    ```bash
    bash
    Copy code
    git clone <https://github.com/initstring/linkedin2username.git>
    cd linkedin2username
    pip3 install -r requirements.txt
    ```
    
    2. **Obtain LinkedIn session cookie** (for authenticated scraping):
        - Log in to LinkedIn.
            
        - Use browser dev tools → Application → Cookies → extract the value of `li_at`.
            
        - Export it as an environment variable:
            
            ```bash
            bash
            Copy code
            export LINKEDIN_USERNAME='you@example.com'
            export LINKEDIN_PASSWORD='yourpassword'
            ```
            
    
    ---
    
    ### ▶️ Usage
    
    **Scrape names:**
    
    ```bash
    bash
    Copy code
    python3 linkedin2username.py -c "Company Name"
    ```
    
    **Generate username formats (mashups):**
    
    ```bash
    bash
    Copy code
    python3 linkedin2username.py -c "Company Name" -g
    ```
    
    **Common username formats generated:**
    
    - `flast` → jdoe
    - `first.last` → john.doe
    - `f.last` → j.doe
    - `firstlast` → johndoe
    - `lastf` → doej
    - `last.first` → doe.john
    
    You can specify formats:
    
    ```bash
    bash
    Copy code
    python3 linkedin2username.py -c "Company Name" -g -f flast,first.last
    ```
    
    **Output**: A `.txt` file with all possible username permutations, ready for use in further enumeration or password spraying **(only if authorized)**.
    

### Credential Hunting

**Dehashed Site**

[http://dehashed.com/](http://dehashed.com/)

- excellent tool for hunting for cleartext credentials and password hashes in breach data

![image.png](attachment:4e20593f-059d-49ad-a8ce-4d5d3cabf6ff:image.png)

**Dehashed CLI Version**