# Overview

Improve protections and detections of threats from email and web vectors, as these are opportunities for attackers to manipulate human behavior through direct engagement.

# Why is this Control Critical

### Risks Associated with Web Browsers and Email Clients

- **Common Entry Points for Attackers:**
  - Web browsers and email clients are common points of entry for attackers due to their direct interaction with users inside an enterprise.
  - Attackers can craft content to entice or spoof users into disclosing credentials, providing sensitive data, or providing an open channel for attackers to gain access, increasing the risk to the enterprise.

- **Prime Targets for Malicious Code and Social Engineering:**
  - Email and web are the main means through which users interact with external and untrusted users and environments, making them prime targets for both malicious code and social engineering attacks.

- **Impact of Web-Based and Mobile Email Access:**
  - As enterprises move to web-based email or mobile email access, users no longer use traditional full-featured email clients that provide embedded security controls like connection encryption, strong authentication, and phishing reporting buttons.

# Procedures and tools

### Web Browser Security

- **Exploitation of Vulnerabilities:**
  - Cybercriminals can exploit web browsers by crafting malicious webpages that exploit vulnerabilities in insecure or unpatched browsers.
  - They can also target common web browser third-party plugins to hook into the browser or directly into the operating system or application.

- **Plugin and Extension Management:**
  - Plugins, extensions, and add-ons need to be reviewed for vulnerabilities, kept up-to-date with the latest patches or versions, and controlled.
  - It is best to prevent users from installing potentially malicious plugins, extensions, and add-ons.

- **Browser Configuration Updates:**
  - Simple configuration updates to the browser can make it harder for malware to be installed by reducing the ability to install add-ons/plugins/extensions and preventing specific types of content from automatically executing.

- **Phishing and Malware Protection:**
  - Most popular browsers employ a database of phishing and/or malware sites to protect against common threats.
  - Enabling content filters and pop-up blockers can help prevent users from accessing malicious content or falling for social engineering tricks.

- **DNS Filtering Services:**
  - Consider subscribing to DNS filtering services to block attempts to access known malicious domains at the network level.

### Email Security

- **Threat Vectors:**
  - Email is one of the most common threat vectors against enterprises, with tactics such as phishing and Business Email Compromise (BEC).

- **Spam Filtering and Malware Scanning:**
  - Using a spam-filtering tool and malware scanning at the email gateway reduces the number of malicious emails and attachments that enter the enterprise’s network.

- **Domain-based Message Authentication:**
  - Initiating Domain-based Message Authentication, Reporting, and Conformance (DMARC) helps reduce spam and phishing activities.

- **Encryption:**
  - Installing an encryption tool to secure email and communications adds another layer of user and network-based security.

- **File Type Restriction:**
  - Only allowing certain file types that users need for their jobs can reduce the risk of malicious attachments. This requires coordination with different business units to understand their file needs.

- **Phishing Training:**
  - Training users on how to identify phishing emails and encouraging them to notify IT Security when they encounter one is crucial.
  - Platforms that perform phishing tests against users can help educate them on different examples and track their improvement over time.

# Safeguards
### CIS Control 8: Audit Log Management

### CIS Controls v8: Email and Web Browser Protections

#### 9.1 Ensure Use of Only Fully Supported Browsers and Email Clients Applications
- **Applications Protect:** Ensure only fully supported browsers and email clients are allowed to execute in the enterprise, using the latest version provided by the vendor.

#### 9.2 Use DNS Filtering Services
- **Network Protect:** Use DNS filtering services on all enterprise assets to block access to known malicious domains.

#### 9.3 Maintain and Enforce Network-Based URL Filters
- **Network Protect:** Enforce and update network-based URL filters to limit enterprise assets from connecting to potentially malicious or unapproved websites. Implementations include category-based filtering, reputation-based filtering, or using block lists. Enforce filters for all enterprise assets.

#### 9.4 Restrict Unnecessary or Unauthorized Browser and Email Client Extensions
- **Applications Protect:** Restrict, either through uninstalling or disabling, any unauthorized or unnecessary browser or email client plugins, extensions, and add-on applications.

#### 9.5 Implement DMARC
- **Network Protect:** To lower the chance of spoofed or modified emails from valid domains, implement DMARC policy and verification, starting with implementing the Sender Policy Framework (SPF) and the DomainKeys Identified Mail (DKIM) standards.

#### 9.6 Block Unnecessary File Types
- **Network Protect:** Block unnecessary file types attempting to enter the enterprise’s email gateway.

#### 9.7 Deploy and Maintain Email Server Anti-Malware Protections
- **Network Protect:** Deploy and maintain email server anti-malware protections, such as attachment scanning and/or sandboxing.

---


