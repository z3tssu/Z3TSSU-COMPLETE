
## **Basic Command**

```bash
gobuster vhost -u http://<target_IP_address> \
-w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt \
--append-domain -t 1000
```

---

## **Key Options**

|**Flag**|**Description**|
|---|---|
|`-u`|Target URL or IP address.|
|`-w`|Wordlist for VHost enumeration.|
|`--append-domain`|Appends the base domain to each word in the list.|
|`-t`|Sets the number of threads (e.g., `-t 1000` for speed).|
|`-k`|Ignores SSL/TLS certificate errors (useful with HTTPS).|
|`-o`|Saves the output to a file for later review.|

---

## **Example**

```bash
gobuster vhost -u http://10.10.10.10 \
-w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt \
--append-domain -t 500 -o gobuster_vhost_results.txt
```

---