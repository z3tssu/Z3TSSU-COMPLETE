# Overview

### **Background**

Following the completion of initial domain enumeration, we now have:

- Basic user and group information
- A list of active hosts, including key infrastructure like the Domain Controller
- Understanding of the domain’s naming convention

This foundational data sets the stage for more targeted attacks aimed at gaining access to domain accounts.

---

### **Objective**

In this phase, our goal is to acquire **valid domain user credentials**—preferably in **cleartext**—to transition from unauthenticated enumeration to **authenticated enumeration** within the domain.

---

### **Techniques Covered**

We will explore two techniques in parallel:

1. **Network Poisoning**
2. **Password Spraying**

These are commonly used methods during internal assessments to escalate access.

---

### **Focus Technique: LLMNR/NBT-NS Poisoning**

This section introduces a **Man-in-the-Middle (MitM)** attack that targets:

- **LLMNR (Link-Local Multicast Name Resolution)**
- **NBT-NS (NetBIOS Name Service)**

By responding to these name resolution broadcasts, an attacker can:

- Capture **password hashes** (NTLM)
- Occasionally obtain **cleartext credentials**
- Leverage captured hashes in offline cracking attempts

  

---

  

[[HACKTHEBOX CPTS/Information Gathering/Active Directory Enumeration/Sniffing out a Foothold/LLMNR-NBT-NS Poisoning - from Linux/LLMNR-NBT-NS Poisoning - from Linux]]

[[HACKTHEBOX CPTS/Information Gathering/Active Directory Enumeration/Sniffing out a Foothold/LLMNR-NBT-NS Poisoning - from Windows/LLMNR-NBT-NS Poisoning - from Windows]]