# Overview 

Operate processes and tooling to establish and maintain comprehensive network
monitoring and defense against security threats across the enterprise’s network
infrastructure and user base.

# Why is this Control critical 

---

## Network Defenses and Adversaries
- Network defenses are not perfect.
- Adversaries evolve and mature, sharing or selling information on exploits and bypasses to security controls.
- Understanding the enterprise risk posture is crucial for configuring, tuning, and logging security tools effectively.

## Effectiveness of Security Tools
- Security tools require continuous monitoring to be effective.
- Misconfigurations or lack of knowledge can lead to a false sense of security.
- A technology-driven approach may result in more false positives.

## Importance of Security Operations
- Enterprises need a security operations capability to prevent, detect, and respond to cyber threats.
- Visibility into all threat vectors is essential, along with human involvement in detection, analysis, and response.
- Security operations generate activity reports and metrics that enhance security policies and support regulatory compliance.

## Situational Awareness
- Comprehensive situational awareness increases the speed of detection and response.
- Enterprises are often compromised for extended periods before discovery.
- Situational awareness helps identify and catalog Tactics, Techniques, and Procedures (TTPs) of attackers, enabling proactive threat identification.
- Recovery is faster with complete information about the environment and enterprise structure.

---

# Procedures and tools 
Here are the structured notes based on the additional text:

---

## Situational Awareness Without a SOC
- Most enterprises do not need a Security Operations Center (SOC) to gain situational awareness.
- Understanding critical business functions, network and server architectures, data and data flows, vendor service and business partner connections, and end-user devices and accounts is crucial.
- This understanding informs the development of security architecture, technical controls, logging, monitoring, and response procedures.

## Incident Detection and Response
- A trained and organized team is essential for incident detection, analysis, and mitigation.
- These capabilities can be conducted internally, through consultants, or a managed service provider.
- Considerations should include network, enterprise asset, user credential, and data access activities.

## Technology in Situational Awareness
- Technology plays a crucial role in collecting and analyzing data, as well as monitoring networks and enterprise assets.
- Visibility into cloud platforms is important, even if they differ from on-premises security technology.

## Log Management and Analysis
- Forwarding important logs to Security Information and Event Management (SIEM) solutions provides value but does not provide a complete picture.
- Weekly log reviews are necessary to tune thresholds and identify abnormal events.
- Correlation tools can make audit logs more useful for subsequent manual inspection.
- Skilled information security personnel and system administrators are crucial, as automated log analysis tools often require human expertise and intuition.

## Threat Intelligence and Knowledge Base
- As the process matures, enterprises will create, maintain, and evolve a knowledge base to understand and assess business risks, developing an internal threat intelligence capability.
- Threat intelligence involves collecting Tactics, Techniques, and Procedures (TTPs) from incidents and adversaries.
- A situational awareness program defines and evaluates relevant information sources to detect, report, and handle attacks.

## Evolution to Threat Hunting
- Mature enterprises can evolve to threat hunting, where trained staff manually review system and user logs, data flows, and traffic patterns to find anomalies.

---
# Safeguards

### 13.1 Centralize Security Event Alerting Network -Detect-
- Centralize security event alerting across enterprise assets for log correlation and analysis.
- Best practice implementation requires the use of a SIEM with vendor-defined event correlation alerts.
- A log analytics platform configured with security-relevant correlation alerts also satisfies this Safeguard.

### 13.2 Deploy a Host-Based Intrusion Detection Solution Devices -Detect-
- Deploy a host-based intrusion detection solution on enterprise assets, where appropriate and/or supported.

### 13.3 Deploy a Network Intrusion Detection Solution Network -Detect-
- Deploy a network intrusion detection solution on enterprise assets, where appropriate.
- Example implementations include the use of a Network Intrusion Detection System (NIDS) or equivalent cloud service provider (CSP) service.

### 13.4 Perform Traffic Filtering Between Network Segments Network -Protect-
- Perform traffic filtering between network segments, where appropriate.

### 13.5 Manage Access Control for Remote Assets Devices -Protect-
- Manage access control for assets remotely connecting to enterprise resources.
- Determine the amount of access to enterprise resources based on up-to-date anti-malware software installed, configuration compliance with the enterprise’s secure configuration process, and ensuring the operating system and applications are up-to-date.

### 13.6 Collect Network Traffic Flow Logs Network -Detect-
- Collect network traffic flow logs and/or network traffic to review and alert upon from network devices.

### 13.7 Deploy a Host-Based Intrusion Prevention Solution Devices -Protect-
- Deploy a host-based intrusion prevention solution on enterprise assets, where appropriate and/or supported.
- Example implementations include the use of an Endpoint Detection and Response (EDR) client or host-based IPS agent.

### 13.8 Deploy a Network Intrusion Prevention Solution Network -Protect-
- Deploy a network intrusion prevention solution, where appropriate.
- Example implementations include the use of a Network Intrusion Prevention System (NIPS) or equivalent CSP service.

### 13.9 Deploy Port-Level Access Control Devices -Protect-
- Deploy port-level access control. Port-level access control utilizes 802.1x, or similar network access control protocols, such as certificates, and may incorporate user and/or device authentication.

### 13.10 Perform Application Layer Filtering Network -Protect-
- Perform application layer filtering. Example implementations include a filtering proxy, application layer firewall, or gateway.

### 13.11 Tune Security Event Alerting Thresholds Network -Detect-
- Tune security event alerting thresholds monthly, or more frequently.

---
