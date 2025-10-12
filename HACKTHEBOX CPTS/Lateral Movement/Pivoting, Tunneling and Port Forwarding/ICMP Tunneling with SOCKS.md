### Overview

ICMP tunneling encapsulates traffic within ICMP echo request and response packets. It is only effective when ping responses are permitted through a firewall. If allowed, internal hosts can use ping traffic to tunnel data to external servers, which can validate and respond accordingly. This technique is useful for stealthy data exfiltration or establishing pivot tunnels.

In this scenario, we’ll use **ptunnel-ng** to create an ICMP tunnel between a **Pivot Host** (Ubuntu server) and the **Attack Host**.

---

### Scenario

- **Pivot Host (Ubuntu)**: `10.129.202.64`, `172.16.5.129`
- **Attack Host**: `10.10.14.18`

The Ubuntu server sits in the internal network and is accessible by ICMP. We will create an SSH connection through ICMP between the attack host and pivot host.

---

## Step-by-Step Instructions

### Step 1: Clone ptunnel-ng (Attack Host)

```Shell
git clone https://github.com/utoni/ptunnel-ng.git
```

### Step 2: Build ptunnel-ng (Attack Host)

```Shell
cd ptunnel-ng
sudo ./autogen.sh
```

### Alternative Build (Static Binary)

```Shell
sudo apt install automake autoconf -y
sed -i '$s/.*/LDFLAGS=-static "${NEW_WD}\\/configure" --enable-static $@ \\&\\& make clean \\&\\& make -j${BUILDJOBS:-4} all/' autogen.sh
./autogen.sh
```

### Step 3: Transfer ptunnel-ng to Pivot Host (Attack Host)

```Shell
scp -r ptunnel-ng ubuntu@10.129.202.64:~/
```

---

## Establishing the Tunnel

### Step 4: Start ptunnel-ng Server (Pivot Host)

```Shell
cd ~/ptunnel-ng/src
sudo ./ptunnel-ng -r10.129.202.64 -R22
```

- Forwards ICMP packets to TCP port `22` (SSH).

### Step 5: Start ptunnel-ng Client (Attack Host)

```Shell
sudo ./ptunnel-ng -p10.129.202.64 -l2222 -r10.129.202.64 -R22
```

- Opens local port `2222` for tunneling SSH through ICMP to pivot host.

### Step 6: Connect via SSH over ICMP (Attack Host)

```Shell
ssh -p2222 -lubuntu 127.0.0.1
```

- Connects to the pivot host over the ICMP tunnel.

---

## Optional: Proxying Over the Tunnel

### Step 7: Start Dynamic Port Forwarding Over SSH (Attack Host)

```Shell
ssh -D 9050 -p2222 -lubuntu 127.0.0.1
```

- Opens SOCKS proxy on port `9050`.

### Step 8: Update proxychains.conf (Attack Host)

```Plain
[ProxyList]
socks5 127.0.0.1 9050
```

### Step 9: Scan Internal Host via Proxy (Attack Host)

```Shell
proxychains nmap -sV -sT 172.16.5.19 -p3389
```

---

## Confirming Traffic Behavior

Use Wireshark to verify the tunneling behavior:

- Run `ssh ubuntu@10.129.202.64` — you’ll see typical TCP/SSHv2 traffic.
- Run `ssh -p2222 -lubuntu 127.0.0.1` — traffic will be ICMP-based.

Monitoring ptunnel-ng output provides real-time session statistics:

```Plain
[inf]: Starting new session to 10.129.202.64:22 with ID 20199
[inf]: Session statistics:
[inf]: I/O:   0.00/  0.00 mb ICMP I/O/R: 248/22/0 Loss: 0.0%
```

---