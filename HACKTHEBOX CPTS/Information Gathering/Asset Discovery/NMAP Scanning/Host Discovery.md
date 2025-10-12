Here’s a clean and organized **Markdown structure** for Obsidian notes based on your content:
## 1. Scan a Network Range

```bash
sudo nmap 10.129.2.0/24 -sn -oA tnet | grep for | cut -d" " -f5
```

---

## 2. Scan an IP List

```bash
sudo nmap -sn -oA tnet -iL hosts.lst | grep for | cut -d" " -f5
```

---

## 3. Scan Multiple IP Addresses

```bash
sudo nmap -sn -oA tnet 10.129.2.18 10.129.2.19 10.129.2.20 | grep for | cut -d" " -f5
```

---

## 4. Scan a Single IP Address

Before scanning a single host for open ports and its services, first check if it is active:

```bash
sudo nmap 10.129.2.18 -sn -oA host
```

---

## 5. Confirm Host is Active

If we **disable port scanning** (`-sn`), Nmap automatically performs a ping scan using **ICMP Echo Requests (`-PE`)**.  
We can confirm the packets sent with the `--packet-trace` option.

```bash
sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace
```

**Sample Output:**

```
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:08 CEST
SENT (0.0074s) ARP who-has 10.129.2.18 tell 10.10.14.2
RCVD (0.0309s) ARP reply 10.129.2.18 is-at DE:AD:00:00:BE:EF
Nmap scan report for 10.129.2.18
Host is up (0.023s latency).
MAC Address: DE:AD:00:00:BE:EF
Nmap done: 1 IP address (1 host up) scanned in 0.05 seconds
```

---

## 6. Determine Why Host is Marked as Active

Use the `--reason` option to understand why the host is marked as alive.

```bash
sudo nmap 10.129.2.18 -sn -oA host -PE --reason
```

**Sample Output:**

```
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:10 CEST
SENT (0.0074s) ARP who-has 10.129.2.18 tell 10.10.14.2
RCVD (0.0309s) ARP reply 10.129.2.18 is-at DE:AD:00:00:BE:EF
Nmap scan report for 10.129.2.18
Host is up, received arp-response (0.028s latency).
MAC Address: DE:AD:00:00:BE:EF
Nmap done: 1 IP address (1 host up) scanned in 0.03 seconds
```

---

## 7. Disable ARP Scan

To force ICMP Echo Requests only and **disable ARP pings**, use:

```bash
sudo nmap 10.129.2.18 -sn -oA host -PE --packet-trace --disable-arp-ping
```

**Sample Output:**

```
Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-15 00:12 CEST
SENT (0.0107s) ICMP [10.10.14.2 > 10.129.2.18 Echo request (type=8/code=0) id=13607 seq=0] IP [ttl=255 id=23541 iplen=28 ]
RCVD (0.0152s) ICMP [10.129.2.18 > 10.10.14.2 Echo reply (type=0/code=0) id=13607 seq=0] IP [ttl=128 id=40622 iplen=28 ]
Nmap scan report for 10.129.2.18
Host is up (0.086s latency).
MAC Address: DE:AD:00:00:BE:EF
Nmap done: 1 IP address (1 host up) scanned
```

```

Would you like me to turn this into a downloadable `.md` file for direct import into Obsidian?
```