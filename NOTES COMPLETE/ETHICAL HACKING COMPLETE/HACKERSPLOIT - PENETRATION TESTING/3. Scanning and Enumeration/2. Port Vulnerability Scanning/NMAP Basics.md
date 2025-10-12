# Nmap Command

**Purpose:** Use the Nmap (Network Mapper) command to scan networks, discover hosts, and identify open ports and services. Nmap is a powerful and versatile network scanning tool.

## Basic Usage
- Syntax: `nmap [Scan Type(s)] [Options] {target specification}`
- Example: `nmap -sP 192.168.1.0/24`

## Scan Types
- `-sP`: Ping scan (checks if hosts are online)
- `-sS`: TCP SYN scan (stealthy, not as reliable)
- `-sT`: TCP connect scan (default, more reliable but less stealthy)
- `-sU`: UDP scan
- `-sV`: Version detection (enumerate services and versions)
- `-A`: Aggressive scan (enables OS detection, version detection, script scanning, and traceroute)
- `-O`: OS detection (tries to determine the operating system)
- `-p <port ranges>`: Scan specific ports or port ranges

## Options
- `-v`: Increase verbosity (can be used multiple times for more detail)
- `-T<0-5>`: Set timing template (0=paranoid, 5=insane)
- `-oN <file>`: Save scan results in normal format
- `-oX <file>`: Save scan results in XML format
- `-Pn`: Treat all hosts as online (skip host discovery)

## Examples
- Ping scan a network to check for live hosts:
```sh
  nmap -sP 192.168.1.0/24
```

- Aggressive scan an IP address for open ports and services

```sh
nmap -T4 -A -vv IP_Address
```

- Scan a range of ports on a host:

```sh
nmap -p 1-100 192.168.1.1
```

- Enumerating Hosts on a network

```sh
nmap -sL Ip_Address
```

