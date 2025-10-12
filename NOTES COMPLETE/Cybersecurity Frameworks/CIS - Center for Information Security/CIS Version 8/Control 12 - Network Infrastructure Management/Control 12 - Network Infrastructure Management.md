# Overview 
Establish, implement, and actively manage (track, report, correct) network devices, in order to prevent attackers from exploiting vulnerable network services and access points.

# Why is this Control critical 

### Secure Network Infrastructure

- **Essential Defense:**
  - Secure network infrastructure is essential defense against attacks. This includes an appropriate security architecture, addressing vulnerabilities often introduced with default settings, monitoring for changes, and reassessment of current configurations.

- **Network Devices:**
  - Network infrastructure includes devices such as physical and virtualized gateways, firewalls, wireless access points, routers, and switches.

- **Default Configurations:**
  - Default configurations for network devices are geared for ease-of-deployment and ease-of-use, not security. Potential default vulnerabilities include open services and ports, default accounts and passwords (including service accounts), support for older vulnerable protocols, and pre-installation of unneeded software.

- **Exploiting Default Settings:**
  - Attackers search for vulnerable default settings, gaps, or inconsistencies in firewall rule sets, routers, and switches to penetrate defenses. They exploit flaws in these devices to gain access to networks, redirect traffic, and intercept data in transmission.

- **Regular Re-evaluation:**
  - Network security requires regular re-evaluation of architecture diagrams, configurations, access controls, and allowed traffic flows. Attackers take advantage of network device configurations becoming less secure over time as users demand exceptions for specific business needs.

- **Managing Exceptions:**
  - Sometimes exceptions are deployed but not removed when they are no longer applicable to the business's needs. The security risk of an exception is often not properly analyzed or measured against the associated business need and can change over time.

---
# Procedures and Tools

### Procedures and Tools for Network Infrastructure Management

- **Documentation and Architecture Diagrams:**
  - Ensure network infrastructure is fully documented, and architecture diagrams are kept up-to-date.

- **Vendor Support and Upgrades:**
  - Ensure key infrastructure components have vendor support for patches and feature upgrades. Upgrade End-of-Life (EOL) components before the support expiration date or apply mitigating controls to isolate them.

- **Monitoring and Vulnerability Management:**
  - Monitor infrastructure versions and configurations for vulnerabilities that require upgrading to the latest secure and stable version without impacting the infrastructure.

- **Security Controls:**
  - Have an up-to-date network architecture diagram, including security architecture diagrams, as a foundation for infrastructure management.
  - Implement complete account management for access control, logging, and monitoring.
  - Perform infrastructure administration over secure protocols, with strong authentication (MFA for PAM), and from dedicated administrative devices or out-of-band networks.

- **Commercial Tools for Rule Set Evaluation:**
  - Use commercial tools to evaluate the rule sets of network filtering devices to determine consistency or conflicts. These tools automate the check of network filters for errors in rule sets or Access Controls Lists (ACLs) that may allow unintended services through the network device. Run these tools each time significant changes are made to firewall rule sets, router ACLs, or other filtering technologies.

---

# Safeguards

### 12.1 Ensure Network Infrastructure is Up-to-Date

- **Objective:** Keep network infrastructure up-to-date to maintain security and stability.
- **Implementation:** 
  - Run the latest stable release of software.
  - Use currently supported network-as-a-service (NaaS) offerings.
  - Review software versions monthly, or more frequently, to verify software support.

### 12.2 Establish and Maintain a Secure Network Architecture

- **Objective:** Ensure network architecture is secure, addressing segmentation, least privilege, and availability.
- **Implementation:** 
  - Implement segmentation to separate critical assets from less sensitive ones.
  - Apply the principle of least privilege to restrict access to only what is necessary.
  - Ensure network availability through redundancy and failover mechanisms.

### 12.3 Securely Manage Network Infrastructure

- **Objective:** Securely manage network infrastructure to prevent unauthorized access and ensure integrity.
- **Implementation:** 
  - Use version-controlled-infrastructure-as-code (IaC) to manage network infrastructure.
  - Use secure network protocols, such as SSH and HTTPS, for management access.

### 12.4 Establish and Maintain Architecture Diagram(s)

- **Objective:** Maintain up-to-date architecture diagrams and network system documentation.
- **Implementation:** 
  - Review and update documentation annually or when significant enterprise changes occur.

### 12.5 Centralize Network Authentication, Authorization, and Auditing (AAA)

- **Objective:** Centralize network AAA to simplify management and improve security.
- **Implementation:** 
  - Use centralized AAA servers for authentication, authorization, and auditing.

### 12.6 Use of Secure Network Management and Communication Protocols

- **Objective:** Use secure protocols for network management and communication to protect against eavesdropping and tampering.
- **Implementation:** 
  - Use protocols such as 802.1X for network access control and WPA2 Enterprise for secure Wi-Fi access.

### 12.7 Ensure Remote Devices Utilize a VPN and are Connecting to an Enterprise’s AAA Infrastructure

- **Objective:** Require remote devices to use a VPN and authenticate to enterprise AAA services before accessing resources.
- **Implementation:** 
  - Configure remote devices to connect to a VPN before accessing enterprise resources.
  - Authenticate users against the enterprise's AAA infrastructure before granting access.

### 12.8 Establish and Maintain Dedicated Computing Resources for All Administrative Work

- **Objective:** Ensure administrative tasks are performed on dedicated computing resources to reduce the risk of compromise.
- **Implementation:** 
  - Use physically or logically separated computing resources for administrative tasks.
  - Segment administrative resources from the primary network and restrict internet access.

These controls are designed to protect network infrastructure, manage access securely, and maintain documentation and standards for network architecture. Implementing these controls can significantly enhance the security posture of an organization's network.
