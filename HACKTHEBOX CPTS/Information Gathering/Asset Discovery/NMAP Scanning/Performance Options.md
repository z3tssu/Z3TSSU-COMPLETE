
## **1. Why Performance Tuning Matters**

- Speeds up scans on **large networks** or **low-bandwidth links**.
    
- Lets you control **speed, retries, timeouts, and packet rate**.
    
- Trade-off: **Faster scans = more chance to miss hosts or ports**.
    

---

## **2. Timeout Tweaks**

**Default:** RTT timeout ~100ms (safe, but slower).

**Example – Default /24 Scan:**

```bash
sudo nmap 10.129.2.0/24 -F
```

**Result:** ~39.4s, 10 hosts found.

**Optimized:**

```bash
sudo nmap 10.129.2.0/24 -F --initial-rtt-timeout 50ms --max-rtt-timeout 100ms
```

**Result:** ~12.3s, only 8 hosts found (some missed).

**Flags:**

- `--initial-rtt-timeout` → Lower starting RTT.
    
- `--max-rtt-timeout` → Lower max wait time.
    

---

## **3. Retry Controls**

**Default:** 10 retries per packet.

**Example – Default Retries:**

```bash
sudo nmap 10.129.2.0/24 -F | grep "/tcp" | wc -l
```

Result → **23 open ports**.

**No Retries (Faster but Less Accurate):**

```bash
sudo nmap 10.129.2.0/24 -F --max-retries 0 | grep "/tcp" | wc -l
```

Result → **21 open ports**.

**Flag:**

- `--max-retries 0` → Skip retries; faster but less reliable.
    

---

## **4. Packet Rate Control**

**Force a minimum packet rate with `--min-rate`.**

**Default Scan:**

```bash
sudo nmap 10.129.2.0/24 -F -oN tnet.default
```

~29.8s.

**Optimized Rate (300 pkts/sec):**

```bash
sudo nmap 10.129.2.0/24 -F -oN tnet.minrate300 --min-rate 300
```

~8.7s. Same open ports found (**23**).

**Flags:**

- `--min-rate <rate>` → Set minimum packet rate.
    
- `-oN <file>` → Save results to a file.
    

---

## **5. Timing Templates**

Pre-configured speed profiles:

|**Template**|**Speed**|**Detection Risk**|
|---|---|---|
|`-T0`|Paranoid|Very low|
|`-T1`|Sneaky|Low|
|`-T2`|Polite|Moderate|
|`-T3`|Normal|Default|
|`-T4`|Aggressive|High|
|`-T5`|Insane|Very high|

**Example – Default vs Insane Timing:**

**Default:**

```bash
sudo nmap 10.129.2.0/24 -F -oN tnet.default
```

~32.4s, **23 ports** found.

**Insane (-T5):**

```bash
sudo nmap 10.129.2.0/24 -F -oN tnet.T5 -T 5
```

~18.0s, **23 ports** found.

---

## **6. Key Takeaways**

- **Timeouts** → Lower values = faster but riskier.
    
- **Retries** → Fewer retries = speed, but possible misses.
    
- **Packet Rate** → Push rate higher for trusted networks.
    
- **Timing Templates** → Quick tuning with `-T0` to `-T5`.
    
- Balance **speed vs stealth** based on your target and environment.
    

---

Would you like me to turn these notes into a **printable quick reference sheet**?