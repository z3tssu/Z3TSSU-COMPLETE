
## **Saving Scan Results**

### **Types of Output Formats**

|Format|Flag|File Extension|Description|
|---|---|---|---|
|Normal Output|`-oN`|`.nmap`|Standard human-readable output|
|Grepable Output|`-oG`|`.gnmap`|Grepable format for automated parsing|
|XML Output|`-oX`|`.xml`|Structured XML for advanced processing|
|All Formats|`-oA`|`.nmap`, `.gnmap`, `.xml`|Saves results in all three formats|

---

### **Example: Save Results in All Formats**

```bash
sudo nmap 10.129.2.28 -p- -oA target
```

**Sample Output**:

```
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-16 12:14 CEST
Nmap scan report for 10.129.2.28
Host is up (0.0091s latency).
Not shown: 65525 closed ports
PORT      STATE SERVICE
22/tcp    open  ssh
25/tcp    open  smtp
80/tcp    open  http
MAC Address: DE:AD:00:00:BE:EF (Intel Corporate)

Nmap done: 1 IP address (1 host up) scanned in 10.22 seconds
```

---

## **Creating HTML Reports from XML Output**

Using the XML output, we can generate **HTML reports** that are clear and user-friendly — ideal for documentation or sharing results with non-technical stakeholders.

### **Convert XML to HTML**

```bash
xsltproc target.xml -o target.html
```

Open the `target.html` file in a browser to see a structured and detailed presentation of the results.

---

Would you like me to **add a quick explanation of when to use each output format** for different scenarios, such as scripting or reporting?