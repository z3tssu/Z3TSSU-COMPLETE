# Overview 

Establish and maintain data recovery practices sufficient to restore in-scope
enterprise assets to a pre-incident and trusted state.

# Why is this Control critical

### Importance of Availability and Data Integrity

- **Availability Over Confidentiality:**
  - In the cybersecurity triad (Confidentiality, Integrity, and Availability), the availability of data is sometimes more critical than its confidentiality. Enterprises require various types of data to make business decisions, and the unavailability or lack of trust in this data can impact the enterprise's operations. For example, weather information is crucial to a transportation enterprise.

- **Changes to Assets by Attackers:**
  - Attackers compromise assets by making changes to configurations, adding accounts, and installing software or scripts. These changes can be challenging to identify, as attackers may replace trusted applications with malicious versions or use standard-looking account names. Configuration changes can include adding or changing registry entries, opening ports, turning off security services, deleting logs, or other actions that compromise system security. Human error can also cause these changes.

- **Rise of Ransomware:**
  - There has been an exponential rise in ransomware, which has become a commercialized and organized method for attackers to make money. If an attacker encrypts an enterprise's data and demands ransom for its restoration, having a recent backup to recover to a known, trusted state can be helpful. However, ransomware has evolved to include extortion techniques where data is exfiltrated before encryption, and attackers demand payment to restore the data and prevent its sale or publication.

- **Risk Reduction Through Cyber Hygiene:**
  - Leveraging the guidance within the CIS Controls can help reduce the risk of ransomware by improving cyber hygiene. Attackers often use older or basic exploits on insecure systems.

---
# Procedures and Tools
### Data Recovery Procedures

- **Defined in Data Management Process:**
  - Data recovery procedures should be defined in the data management process described in [[Control 3 - Data Protection]] . This should include backup procedures based on data value, sensitivity, or retention requirements.

- **Backup Frequency and Type:**
  - Backup frequency and type (full vs. incremental) should be determined based on the data value, sensitivity, or retention requirements.

- **Testing Backups:**
  - Once per quarter (or whenever a new backup process or technology is introduced), a testing team should evaluate a random sampling of backups and attempt to restore them on a test bed environment. The restored backups should be verified to ensure that the operating system, application, and data from the backup are all intact and functional.

- **Restoration Procedures for Malware Infection:**
  - In the event of a malware infection, restoration procedures should use a version of the backup that is believed to predate the original infection. This ensures that the system can be restored to a known, clean state.

---
# Safeguards

### CIS Controls v8: Data Recovery

#### 11.1 Establish and Maintain a Data Recovery Process
- **Recover:** Establish and maintain a data recovery process. Address the scope of data recovery activities, recovery prioritization, and the security of backup data. Review and update documentation annually or when significant enterprise changes occur.

#### 11.2 Perform Automated Backups
- **Recover:** Perform automated backups of in-scope enterprise assets. Run backups weekly or more frequently based on the sensitivity of the data.

#### 11.3 Protect Recovery Data
- **Protect:** Protect recovery data with equivalent controls to the original data. Reference encryption or data separation based on requirements.

#### 11.4 Establish and Maintain an Isolated Instance of Recovery Data
- **Recover:** Establish and maintain an isolated instance of recovery data. Example implementations include version controlling backup destinations through offline, cloud, or off-site systems or services.

#### 11.5 Test Data Recovery
- **Recover:** Test backup recovery quarterly or more frequently for a sampling of in-scope enterprise assets.
