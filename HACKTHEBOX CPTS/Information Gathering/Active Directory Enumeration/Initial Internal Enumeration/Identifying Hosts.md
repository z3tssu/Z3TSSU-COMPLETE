# Internal Network Enumeration & Scanning (AD Focus)

## Wireshark on Attack Host
Launch for traffic capture on internal iface.

Command:
```
sudo -E wireshark
```
- Root privs; capture on internal net iface (e.g., ens224 implied).

## Capture Network Traffic Using Tcpdump
Raw capture w/o GUI.

Command:
```
sudo tcpdump -i ens224
```
- Monitors/captures on ens224; for non-GUI envs.

## Passive LLMNR/NBT-NS/MDNS Analysis Using Responder
Analyze-only (no poison); listen for name res traffic.

Command:
```
sudo responder -I ens224 -A
```

## FPing Active Checks
ICMP-based host discovery.

Command:
```
fping -asgq 172.16.5.0/23
```
- Scans /23 subnet for active IPs via echo reqs.

## Nmap Aggressive Scan Against Hosts
After active hosts list: Enum services, ID critical (DCs, web svrs), vuln hosts. Focus AD protocols (DNS, SMB, LDAP, Kerberos).

Explanation:
- Broad sweep then target AD-related.

Command:
```
sudo nmap -v -A -iL hosts.txt -oN /home/htb-student/Documents/host-enum
```
- -v: Verbose
- -A: Service/OS detect, script scan
- -iL: Input hosts file
- -oN: Output to file