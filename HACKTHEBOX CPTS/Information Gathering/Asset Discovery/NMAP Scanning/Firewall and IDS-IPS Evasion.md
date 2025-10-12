
---

## **2. Firewalls – Quick Recap**

**What they do:**  
Monitor and filter network traffic based on rules.

**Behavior:**

- **Drop:** No response at all.
    
- **Reject:** Send a response (e.g., TCP RST or ICMP error).
    

**Common ICMP Errors:**

- Net/Host Unreachable or Prohibited
    
- Port/Protocol Unreachable
    

---

## **3. Key Nmap Options**

|**Option**|**Description**|
|---|---|
|`-p <ports>`|Specify ports|
|`-sS`|SYN scan|
|`-sA`|ACK scan|
|`-Pn`|Skip ICMP pings|
|`-n`|Skip DNS resolution|
|`--disable-arp-ping`|Disable ARP ping|
|`--packet-trace`|Show all packets|
|`-D <decoys>`|Use decoys|
|`-S <IP>`|Spoof source IP|
|`-e <iface>`|Use specific interface|
|`--source-port <port>`|Spoof source port|

---

## **4. Detecting Firewall Rules**

### **Filtered vs Rejected**

- **Filtered:** Silent drop (no response)
    
- **Rejected:** Clear response (RST or ICMP)
    

---

## **5. Nmap Scans**

### **a) SYN Scan (-sS)**

Sends SYN packets to start a connection.  
**Example:**

```bash
sudo nmap 10.129.2.28 -p 21,22,25 -sS -Pn -n --disable-arp-ping --packet-trace
```

**Observations:**

- Port 22 → **Open** (SYN-ACK)
    
- Ports 21,25 → **Filtered**
    

---

### **b) ACK Scan (-sA)**

Checks firewall rules by sending ACK packets.  
**Example:**

```bash
sudo nmap 10.129.2.28 -p 21,22,25 -sA -Pn -n --disable-arp-ping --packet-trace
```

**Observations:**

- Port 22 → **Unfiltered** (RST returned)
    
- Ports 21,25 → **Filtered**
    

---

## **6. Using Decoys**

**Why:** Hide your real IP in the noise.

**Example:**

```bash
sudo nmap 10.129.2.28 -p 80 -sS -Pn -n --disable-arp-ping --packet-trace -D RND:5
```

**Effect:** Target sees multiple random IPs.

**Pro tip:** Use your own VPS IPs if you want more control.

---

## **7. Source IP & Interface Spoofing**

**Test with OS Detection:**

```bash
sudo nmap 10.129.2.28 -n -Pn -p 445 -O
```

Result → `445/tcp filtered`

**Spoofed Scan:**

```bash
sudo nmap 10.129.2.28 -n -Pn -p 445 -O -S 10.129.2.200 -e tun0
```

**Observation:** Firewall rules may treat spoofed IP differently (e.g., port shows **open**).

---

## **8. Source Port Tricks**

Some firewalls trust **traffic from DNS (port 53)**.

**Normal SYN Scan:**

```bash
sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace
```

**Result:** Port 50000 filtered.

**Scan from DNS Port:**

```bash
sudo nmap 10.129.2.28 -p50000 -sS -Pn -n --disable-arp-ping --packet-trace --source-port 53
```

**Result:** Port now shows **open**.

---

## **9. Manual Connection with Netcat**

If a port opens when spoofing source port 53:

```bash
ncat -nv --source-port 53 10.129.2.28 50000
```

---

## **10. Key Takeaways**

- **Fragment packets** to bypass deep inspection.
    
- **Use decoys** to mask your IP.
    
- **Spoof source IP or port** to trick filters.
    
- **Always analyze packet traces** to confirm firewall behavior.