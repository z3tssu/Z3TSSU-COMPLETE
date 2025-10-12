
## **Objective**

After confirming that the target is alive, the next step is to gather detailed information about the system, including:

- Open ports and their services
    
- Service versions
    
- Information provided by services
    
- Operating system details

## **Scanning Techniques**

### **1. Scanning Top 10 TCP Ports**

```bash
sudo nmap 10.129.2.28 --top-ports=10
```

---

### **2. Trace Nmap Port Scan**

```bash
sudo nmap 10.129.2.28 -p 21 --packet-trace -Pn -n --disable-arp-ping
```

**Flags Explanation**:

- `--packet-trace` = Shows all packets sent and received
    
- `-n` = Disables DNS resolution
    
- `--disable-arp-ping` = Disables ARP ping
    

---

### **3. TCP Connect Scan on Port 443 (-sT)**

Performs a TCP connect scan on port **443**, with packet tracing and extra detail.

```bash
sudo nmap 10.129.2.28 -p 443 --packet-trace --disable-arp-ping -Pn -n --reason -sT
```

---

### **4. UDP Port Scan (-sU)**

Performs a UDP port scan.  
The `-F` option limits the scan to the **top 100 most common ports**.

```bash
sudo nmap 10.129.2.28 -F -sU
```

**Note**: `-F` = Check the top 100 ports only.

---

### **5. Service Version Scan (-sV) on Port 445**

Conducts a version scan on TCP port **445** with packet tracing and extra details.

```bash
sudo nmap 10.129.2.28 -sV -Pn -n --disable-arp-ping --packet-trace -p 445 --reason
```

---

Would you like me to add a **section explaining port states** like `open`, `closed`, `filtered`, and `unfiltered` for clarity?