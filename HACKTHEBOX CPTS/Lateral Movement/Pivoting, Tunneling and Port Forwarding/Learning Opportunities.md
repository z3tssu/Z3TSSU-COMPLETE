# Learning Opportunities & Practice

**Back to:** [[Pivoting, Tunneling and Port Forwarding|Pivoting Index]]

---

## Overview

This page contains curated resources for practicing pivoting, tunneling, and port forwarding techniques. Progress from beginner machines to advanced Pro Labs to master these critical skills.

---

## HackTheBox Practice Machines

### Recommended Pivoting Boxes

These machines require pivoting/tunneling to complete. Follow IPPSec walkthroughs for guidance.

#### Enterprise
- **Difficulty:** Medium
- **Skills:** Multi-pivot scenarios, network segmentation bypass
- **Link:** https://app.hackthebox.com/machines/Enterprise
- **Techniques:** [[SSH Socks Tunnel PF|SSH Dynamic Forward]], [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter Pivoting]]

#### Inception
- **Difficulty:** Medium
- **Skills:** Deep network traversal, multiple hops
- **Link:** https://app.hackthebox.com/machines/Inception
- **Techniques:** [[SSH Pivoting with Sshuttle|Sshuttle]], [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Forward]]

#### Reddish
- **Difficulty:** Insane
- **Skills:** Container pivoting, complex network topology
- **Link:** https://app.hackthebox.com/machines/Reddish
- **Techniques:** [[SOCKS5 Tunneling with Chisel|Chisel]], [[Socat Redirection with Bind Shell|Socat]], Docker networking

---

## IPPSec Video Search

**Quick Search Tool:** https://ippsec.rocks

Search IPPSec's video walkthroughs by technique or tool name:
- Search "pivoting" for all pivoting-related content
- Search "chisel" for Chisel-specific demonstrations
- Search "ssh tunnel" for SSH tunneling examples
- Search "meterpreter pivot" for MSF pivoting

**Pro Tip:** Watch at 1.25x-1.5x speed to learn faster!

---

## HackTheBox Pro Labs

### RastaLabs
- **Focus:** Red Team operations, C2 infrastructure
- **Difficulty:** Advanced
- **Link:** https://app.hackthebox.com/prolabs/overview/rastalabs
- **Skills Practiced:**
  - Multi-hop pivoting
  - Covert channels ([[DNS Tunnelling with Dnscat2|DNS]], [[ICMP Tunneling with SOCKS|ICMP]])
  - [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter]] advanced pivoting
  - C2 infrastructure over tunnels

### Dante
- **Focus:** Network penetration testing fundamentals
- **Difficulty:** Intermediate
- **Link:** https://app.hackthebox.com/prolabs/overview/dante
- **Skills Practiced:**
  - Basic pivoting concepts
  - [[SSH Socks Tunnel PF|SSH tunneling]]
  - [[Chisel SOCKS5 Tunneling|Chisel usage]]
  - Network enumeration through pivots

### Offshore
- **Focus:** Enterprise network compromise
- **Difficulty:** Advanced
- **Link:** https://app.hackthebox.com/prolabs/overview/offshore
- **Skills Practiced:**
  - Windows pivoting ([[Port Forwarding with Windows- Netsh|Netsh]], [[SSH for Windows- plink.exe|Plink]])
  - Active Directory lateral movement
  - Multi-network traversal

---

## Mini Pro Labs

### Ascension
- **Focus:** Beginner-friendly pivoting
- **Difficulty:** Beginner/Intermediate
- **Link:** https://app.hackthebox.com/prolabs/overview/ascension
- **Skills Practiced:**
  - Introduction to pivoting concepts
  - [[SSH Socks Tunnel PF|Basic SSH tunneling]]
  - Simple port forwarding
  - Proxychains configuration

**Recommended Starting Point** for pivoting beginners!

---

## Educational Resources

### Blogs & Articles

#### RastaMouse
- **URL:** https://rastamouse.me/
- **Focus:** Red-Teaming, C2 infrastructure, pivoting, payloads
- **Relevant Topics:**
  - Advanced pivoting techniques
  - C2 channel establishment
  - [[DNS Tunnelling with Dnscat2|Covert channels]]
  - Payload delivery through pivots

#### SpecterOps - SSH Tunneling Guide
- **URL:** https://posts.specterops.io/offensive-security-guide-to-ssh-tunnels-and-proxies-b525cbd4d4c6
- **Focus:** Comprehensive SSH tunneling and proxying
- **Topics Covered:**
  - [[SSH Socks Tunnel PF|SSH Dynamic Forward]]
  - [[Remote-Reverse Port Forwarding with SSH|SSH Reverse Forward]]
  - [[SSH Pivoting with Sshuttle|Sshuttle]]
  - Local port forwarding
  - ProxyChains configuration

#### HackTheBox Blog
- **URL:** https://www.hackthebox.com/blog
- **Focus:** Current threats, TTPs, how-to guides
- **Relevant Content:**
  - Pivoting techniques
  - Tool tutorials
  - CTF writeups with pivoting

#### SANS - Pivoting Cheat Sheet
- **URL:** https://www.sans.org/webcasts/dodge-duck-dip-dive-dodge-making-the-pivot-cheat-sheet-119115/
- **Format:** Webcast
- **Topics:**
  - Multiple pivoting tools
  - Quick reference guide
  - Real-world scenarios

---

## Video Workshops

### Plaintext's Pivoting Workshop
- **URL:** https://youtu.be/B3GxYyGFYmQ
- **Creator:** HTB Academy Training Developer
- **Event:** Cyber Apocalypse CTF 2022 Preparation
- **Duration:** ~2 hours
- **Topics Covered:**
  - Pivoting fundamentals
  - Tool demonstrations
  - Live exploitation scenarios
  - CTF-specific techniques

**Highly Recommended:** Engaging, entertaining, and extremely practical!

---

## Practice Progression Path

### Level 1: Foundations (Beginner)
1. Read [[Pivoting, Tunneling and Port Forwarding|Main Pivoting Index]]
2. Complete [[#Ascension|Ascension Mini Pro Lab]]
3. Practice [[SSH Socks Tunnel PF|SSH Dynamic Forward]]
4. Learn [[Socat Redirection with Bind Shell|basic Socat]]

**Goal:** Understand pivoting concepts, use proxychains

---

### Level 2: Intermediate Techniques
1. Complete [[#Dante|Dante Pro Lab]]
2. Master [[SOCKS5 Tunneling with Chisel|Chisel]]
3. Practice [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding|Meterpreter pivoting]]
4. Attempt [[#Enterprise|Enterprise]] and [[#Inception|Inception]] boxes

**Goal:** Comfortable with multiple pivoting tools and scenarios

---

### Level 3: Advanced Operations
1. Complete [[#RastaLabs|RastaLabs Pro Lab]]
2. Complete [[#Offshore|Offshore Pro Lab]]
3. Master covert channels ([[DNS Tunnelling with Dnscat2|DNS]], [[ICMP Tunneling with SOCKS|ICMP]])
4. Attempt [[#Reddish|Reddish box]]

**Goal:** Handle complex multi-hop scenarios, use covert channels

---

## Skill Assessment Checklist

Use this to track your pivoting proficiency:

### Basic Skills
- [ ] Configure proxychains correctly
- [ ] Create SSH dynamic forward tunnel
- [ ] Use Nmap through proxychains
- [ ] Access RDP through pivot
- [ ] Perform basic Socat relay

### Intermediate Skills
- [ ] Setup Chisel forward and reverse tunnels
- [ ] Configure Meterpreter autoroute and SOCKS
- [ ] Use Sshuttle for transparent routing
- [ ] Forward multiple ports simultaneously
- [ ] Pivot through Windows with Netsh

### Advanced Skills
- [ ] Chain multiple pivots (3+ hops)
- [ ] Establish covert DNS tunnel
- [ ] Setup ICMP tunnel successfully
- [ ] Use SocksOverRDP in Windows-only environment
- [ ] Bypass strict firewall with appropriate tunnel

### Expert Skills
- [ ] Design custom pivot infrastructure
- [ ] Troubleshoot complex routing issues
- [ ] Choose optimal technique for any scenario
- [ ] Maintain stable long-duration tunnels
- [ ] Perform pivoting under time pressure (CTF)

---

## Additional Practice Resources

### TryHackMe Rooms
- **Wreath Network:** Multi-machine network with pivoting
- **Throwback:** Active Directory with pivoting requirements
- **Ra:** Complex network topology

### OffSec Practice
- **OSCP Labs:** Multiple machines requiring pivoting
- **Proving Grounds:** Various pivoting scenarios

### GIAC/SANS Courses
- **SEC560:** Network Penetration Testing (includes pivoting)
- **SEC660:** Advanced Penetration Testing (advanced pivoting)

---

## Community Resources

### Discord Servers
- HackTheBox Official Discord: Pivoting help channels
- Red Team Village: Offensive security discussions
- The Cyber Mentor Discord: Beginner-friendly help

### Forums
- HackTheBox Forums: Machine discussions and hints
- Reddit /r/oscp: OSCP-specific pivoting discussions
- Reddit /r/AskNetsec: Technical pivoting questions

---

## Quick Reference by Scenario

| Scenario | Recommended Tool | Guide Link |
|----------|------------------|------------|
| SSH access to pivot | [[SSH Socks Tunnel PF\|SSH Dynamic Forward]] or [[SSH Pivoting with Sshuttle\|Sshuttle]] | Both guides |
| Windows pivot only | [[Port Forwarding with Windows- Netsh\|Netsh]] or [[SSH for Windows- plink.exe\|Plink]] | Both guides |
| HTTP/HTTPS only egress | [[SOCKS5 Tunneling with Chisel\|Chisel]] or [[Web Server Pivoting with Rpivot\|Rpivot]] | Both guides |
| Only DNS allowed | [[DNS Tunnelling with Dnscat2\|Dnscat2]] | Full guide |
| Only ICMP allowed | [[ICMP Tunneling with SOCKS\|ICMP Tunneling]] | Full guide |
| Meterpreter session | [[Meterpreter Tunneling & Port Forwarding/Meterpreter Tunneling & Port Forwarding\|Meterpreter Pivoting]] | Full guide |
| Simple port forward | [[Socat Redirection with Bind Shell\|Socat]] | Full guide |
| RDP-based pivoting | [[RDP and SOCKS Tunneling with SocksOverRDP/RDP and SOCKS Tunneling with SocksOverRDP\|SocksOverRDP]] | Full guide |

---

**Related Topics:**
- [[Pivoting, Tunneling and Port Forwarding|Back to Main Index]]
- [[Defending and Detection/Defending and Detection|Detection & Defense]]

**Tags:** #practice #learning #htb #pro-labs #training #skill-development