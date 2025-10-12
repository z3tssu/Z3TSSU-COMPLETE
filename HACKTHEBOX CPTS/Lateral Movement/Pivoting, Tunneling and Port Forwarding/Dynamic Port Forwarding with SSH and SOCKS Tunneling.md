---

### Scanning the Pivot Target

```Shell
nmap -sT -p22,3306 10.129.202.64
```

---

### Executing the Local Port Forward

```Shell
ssh -L 1234:localhost:3306 ubuntu@10.129.202.64
```

---

### Confirming Port Forward with Netstat

```Shell
netstat -antp | grep 1234
```

---

### Confirming Port Forward with Nmap

```Shell
nmap -v -sV -p1234 localhos
```

---

### Forwarding Multiple Ports

```Shell
ssh -L 1234:localhost:3306 -L 8080:localhost:80 ubuntu@10.129.202.64
```

---

### Enabling Dynamic Port Forwarding with SSH

```Shell
ssh -D 9050 ubuntu@10.129.202.64
```

- -D argument requests the SSH server to enable dynamic port forwarding
- Once we have this enabled, we will require a tool that can route any tool's packets over the port 9050
- to inform proxy chains that we must use port 9050, we must modify the proxy chains configuration file located at ==/etc/proxychains.conf==. We can add ==socks4 127.0.0.1 9050== to the last line if it is not already there.

---

### Checking /etc/proxychains.conf

```Shell
z3tssu@htb[/htb]$ tail -4 /etc/proxychains4.conf

# meanwile
# defaults set to "tor"
socks4 	127.0.0.1 9050
```

---

### Using Nmap with Proxychains

```Shell
proxychains nmap -v -sn 172.16.5.1-200
```

- This will route all the packets of Nmap to the local port 9050, where our SSH client is listening, which will forward all the packets over SSH to the 172.16.5.0/23 network.

---

### Enumerating the Windows Target through Proxychains

```Shell
proxychains nmap -v -Pn -sT 172.16.5.19
```

---

### Using Metasploit with Proxychains

```Shell
proxychains msfconsole
```

---

### Using rdp_scanner Module

```Shell
use auxiliary/scanner/rdp/rdp_scanner
set rhosts 172.16.5.19
run
```

---

### Using xfreerdp with Proxychains

```Shell
proxychains xfreerdp /v:172.16.5.19 /u:victor /p:pass@123
```

---