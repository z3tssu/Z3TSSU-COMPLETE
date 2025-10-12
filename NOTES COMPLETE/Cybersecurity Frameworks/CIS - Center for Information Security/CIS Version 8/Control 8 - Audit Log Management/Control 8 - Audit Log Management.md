# Overview

Collect, alert, review, and retain audit logs of events that could help detect, understand, or recover from an attack.

# Why is this Control Critical

### Importance of Log Collection and Analysis

- **Purpose:** Log collection and analysis are critical for detecting malicious activity quickly and providing evidence of successful attacks. 

- **Types of Logs:**
  1. **System Logs:** Provide system-level events such as process start/end times and crashes. 
  2. **Audit Logs:** Include user-level events like logins, file access, etc., and require more planning and effort to set up.

- **Benefits:**
  - **Detection of Malicious Activity:** Log analysis helps in detecting and responding to malicious activity quickly.
  - **Evidence of Attacks:** Audit records serve as evidence of successful attacks, helping in investigation and response.
  - **Incident Response:** Log analysis aids in understanding the extent of an attack, including how it occurred and what information was accessed.

- **Challenges:**
  - **Configuration Complexity:** Configuring and managing logs, especially audit logs, can be complex and require effort.
  - **Limited Analysis:** Many enterprises collect logs for compliance but do not analyze them thoroughly, allowing attackers to hide their activities.

- **Best Practices:**
  - **Regular Analysis:** Regularly analyze logs to detect and respond to malicious activity promptly.
  - **Retention:** Retain logs for a sufficient period in case of follow-up investigations or long-term undetected attacks.
  - **Integration:** Integrate log analysis into incident response processes to improve effectiveness.

By prioritizing log collection and analysis, enterprises can enhance their ability to detect and respond to attacks, reducing the impact of security incidents.

# Procedures and tools

### Best Practices for Logging Configuration

- **Activate Logging:** Enable logging on all enterprise assets and software, sending logs to centralized logging servers for analysis.

- **Firewalls, Proxies, and Remote Access Systems:**
  - Configure firewalls, proxies, and remote access systems (e.g., VPNs) for verbose logging to capture detailed information.
  - Ensure logs include relevant details such as source and destination IP addresses, timestamps, and actions taken.

- **Access Control Logs:**
  - Configure all enterprise assets to create access control logs when a user attempts to access resources without the appropriate privileges.
  - Ensure logs include details such as user ID, resource accessed, and access attempt outcome.

- **Retention of Logging Data:**
  - Retain logging data for a sufficient period to support incident investigation and compliance requirements.

- **Periodic Evaluation:**
  - Periodically scan logs to ensure that all managed assets actively connected to the network are generating logs.
  - Compare logs with the enterprise asset inventory assembled as part of CIS Control 1 to ensure comprehensive coverage.

- **Centralized Logging Servers:**
  - Use centralized logging servers to aggregate and store logs for easier analysis and correlation.

- **Security Monitoring:**
  - Use logs for security monitoring to detect and respond to potential security incidents promptly.

By implementing these logging best practices, organizations can enhance their ability to detect and respond to security incidents effectively.

# Safeguards
### CIS Control 8: Audit Log Management

#### 8.1 Establish and Maintain an Audit Log Management Process
- **Description:** Define logging requirements, including collection, review, and retention of audit logs for enterprise assets.
- **Action:** Review and update documentation annually or when significant changes occur.

#### 8.2 Collect Audit Logs
- **Description:** Collect audit logs and ensure logging is enabled across enterprise assets.
- **Action:** Implement logging per the audit log management process.

#### 8.3 Ensure Adequate Audit Log Storage
- **Description:** Ensure logging destinations have sufficient storage to comply with the audit log management process.
- **Action:** Monitor storage usage and expand storage capacity as needed.

#### 8.4 Standardize Time Synchronization
- **Description:** Configure at least two synchronized time sources across enterprise assets.
- **Action:** Implement time synchronization mechanisms to ensure accurate time across all assets.

#### 8.5 Collect Detailed Audit Logs
- **Description:** Configure detailed audit logging for assets containing sensitive data, including event source, date, username, timestamp, source addresses, destination addresses, and other relevant elements.
- **Action:** Configure audit logging settings to capture detailed information.

#### 8.6 Collect DNS Query Audit Logs
- **Description:** Collect DNS query audit logs on enterprise assets where appropriate and supported.
- **Action:** Enable DNS query logging on DNS servers and other relevant assets.

#### 8.7 Collect URL Request Audit Logs
- **Description:** Collect URL request audit logs on enterprise assets where appropriate and supported.
- **Action:** Enable URL request logging on web servers and other relevant assets.

#### 8.8 Collect Command-Line Audit Logs
- **Description:** Collect command-line audit logs, including logs from PowerShell, BASH, and remote administrative terminals.
- **Action:** Enable command-line auditing on relevant assets.

#### 8.9 Centralize Audit Logs
- **Description:** Centralize audit log collection and retention across enterprise assets.
- **Action:** Implement centralized logging solutions to aggregate and store audit logs.

#### 8.10 Retain Audit Logs
- **Description:** Retain audit logs across enterprise assets for a minimum of 90 days.
- **Action:** Ensure audit logs are retained for the required retention period.

#### 8.11 Conduct Audit Log Reviews
- **Description:** Conduct regular reviews of audit logs to detect anomalies or abnormal events indicating a potential threat.
- **Action:** Perform audit log reviews on a weekly or more frequent basis.

#### 8.12 Collect Service Provider Logs
- **Description:** Collect service provider logs, including authentication and authorization events, data creation and disposal events, and user management events.
- **Action:** Work with service providers to enable logging and collect relevant logs.

By implementing these controls, organizations can effectively manage and analyze audit logs to detect and respond to potential threats.
