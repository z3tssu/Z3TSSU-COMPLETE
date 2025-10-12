
---

## **SSL Certificate Enumeration**

### **View SSL Certificates**

- Use [crt.sh](https://crt.sh/) to find SSL certificates for a domain.
    

---

### **Output in JSON from Terminal**

```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq .
```

---

### **Filter Unique Subdomains**

```bash
curl -s https://crt.sh/\?q\=inlanefreight.com\&output\=json | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u
```

**Example Output**

```
account.ttn.inlanefreight.com
blog.inlanefreight.com
bots.inlanefreight.com
console.ttn.inlanefreight.com
ct.inlanefreight.com
data.ttn.inlanefreight.com
*.inlanefreight.com
inlanefreight.com
integrations.ttn.inlanefreight.com
iot.inlanefreight.com
mails.inlanefreight.com
marina.inlanefreight.com
matomo.inlanefreight.com
www.inlanefreight.com
```

---

### **Filter Company-Hosted Subdomains**

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
```

---

## **Shodan Lookup for Found Subdomains**

Generate IP list:

```bash
for i in $(cat subdomainlist); do 
    host $i | grep "has address" | grep inlanefreight.com | cut -d" " -f4 >> ip-addresses.txt
done
```

Run Shodan queries:

```bash
for i in $(cat ip-addresses.txt); do 
    shodan host $i
done
```

**Example Output**

```
10.129.24.93
City: Berlin
Country: Germany
Organization: InlaneFreight
Open Ports:
    80/tcp nginx
    443/tcp nginx
```

---

## **DNS Records**

### **Query Records**

```bash
dig any inlanefreight.com
```

**Example Output**

```
A   -> inlanefreight.com 10.129.27.33
MX  -> aspmx.l.google.com.
NS  -> ns.inwx.net, ns2.inwx.net, ns3.inwx.eu
TXT -> google-site-verification, SPF, DKIM, DMARC entries
```

---

## **Explanation of Record Types**

|**Record**|**Description**|
|---|---|
|**A**|IP addresses pointing to specific (sub)domains.|
|**MX**|Mail server records for handling company emails.|
|**NS**|Nameservers resolving the domain. Often reveal hosting providers.|
|**TXT**|Metadata for verification and email security protocols like SPF, DMARC, and DKIM.|