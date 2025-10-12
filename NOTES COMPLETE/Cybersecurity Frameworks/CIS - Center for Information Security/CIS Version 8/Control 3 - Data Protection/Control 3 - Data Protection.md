# Overview

Develop processes and technical controls to identify, classify, securely handle, retain, and dispose of data.

# Why is this Control Critical?

## Modern Data Landscape
- Data is no longer confined to enterprise borders.
- It resides in the cloud, on portable end-user devices, and is shared with partners or online services globally.
- Enterprises manage sensitive data related to finances, intellectual property, and customer data.
- International regulations govern the protection of personal data.

## Importance of Data Privacy
- Data privacy emphasizes appropriate data use and management, beyond just encryption.
- Data must be managed throughout its life cycle.
- Privacy rules can be complex, especially for multinational enterprises.

## Data Exfiltration and Monitoring
- Attackers, once inside, seek and extract data.
- Enterprises may be unaware of data outflows due to lack of monitoring.

## Attack Vectors
- Attacks can occur on the network or involve physical theft of devices.
- Service providers and partners holding sensitive data can also be targeted.
- Non-computing devices, like SCADA systems, can be vulnerable.

## Business Impact
- Loss of control over protected data is a significant and often reportable impact.
- Data compromise often results from poorly understood data management rules and user error.

## Mitigation Strategies
- Data encryption, both in transit and at rest, helps mitigate data compromise.
- Encryption is a regulatory requirement for most controlled data.

# Procedures and Tools

## Developing a Data Management Process
- **Framework:** Develop a data management framework.
- **Guidelines:** Establish data classification guidelines.
- **Requirements:** Define requirements for protection, handling, retention, and disposal of data.
- **Data Breach Process:** Develop a data breach process that integrates with the incident response, compliance, and communication plans.

## Data Sensitivity Levels
- **Cataloging Data:** Catalog key data types and assess their overall criticality to the enterprise.
- **Classification Scheme:** Use the analysis to create an overall data classification scheme.
- **Labels:** Use labels like "Sensitive," "Confidential," and "Public" for classification.

## Data Inventory and Mapping
- **Inventory Development:** Develop a data inventory or mapping.
- **Identification:** Identify software accessing data at different sensitivity levels.
- **Network Segmentation:** Ideally, separate the network so assets of the same sensitivity level are on the same network, with firewalls controlling access.
- **Access Control:** Apply user access rules to allow access only to those with a business need.

# Safeguards

## 3.1 Establish and Maintain a Data Management Process

Implementing the CIS Safeguard for establishing and maintaining a data management process involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Establish Data Management Process:**
   - Identify and document the data management process, including data sensitivity, data owner, data handling procedures, data retention limits, and disposal requirements.
   - Define roles and responsibilities for managing data, including data owners, data custodians, and data users.

2. **Address Data Sensitivity:**
   - Classify data based on sensitivity levels (e.g., confidential, internal use, public) using a standard classification scheme.
   - Implement security controls based on the sensitivity level of the data, such as encryption, access controls, and data masking.

3. **Identify Data Owner:**
   - Assign a data owner for each data asset or dataset.
   - Ensure that data owners are responsible for defining data handling procedures, data retention limits, and disposal requirements for their respective data assets.

4. **Define Data Handling Procedures:**
   - Develop and document procedures for handling different types of data based on their sensitivity levels.
   - Include guidelines for data access, storage, sharing, and transmission.

5. **Set Data Retention Limits:**
   - Establish data retention limits based on regulatory requirements, business needs, and data sensitivity.
   - Define procedures for archiving or deleting data when retention limits are reached.

6. **Establish Disposal Requirements:**
   - Define procedures for securely disposing of data when it reaches the end of its lifecycle.
   - Use methods such as data wiping, shredding, or degaussing to ensure data is irrecoverable.

7. **Review and Update Documentation:**
   - Conduct an annual review of the data management process documentation to ensure it remains current and reflects any changes in data handling practices or regulatory requirements.
   - Update the documentation whenever significant changes occur in the enterprise that could impact the data management process.

8. **Implement Monitoring and Auditing:**
   - Monitor data management activities to ensure compliance with the established process.
   - Conduct regular audits to assess the effectiveness of the data management process and identify areas for improvement.

9. **Employee Training and Awareness:**
   - Provide training to employees on the importance of data management and their roles in protecting data.
   - Raise awareness about data sensitivity, handling procedures, and disposal requirements.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to data breaches or unauthorized access incidents.
    - Implement a reporting mechanism for reporting data breaches to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve the data management process based on feedback, audit findings, and changes in regulations or business requirements.

## 3.2 Establish and Maintain a Data Inventory

Implementing the CIS Safeguard for establishing and maintaining a data inventory involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Establish Data Inventory Process:**
   - Define a process for creating and maintaining a data inventory based on the enterprise's data management process.
   - Identify the scope of the inventory, including the types of data to be inventoried (e.g., sensitive data, all data types).

2. **Inventory Sensitive Data:**
   - Identify and document sensitive data elements within the inventory.
   - Classify sensitive data based on the level of sensitivity (e.g., personal, financial, health).

3. **Define Data Inventory Requirements:**
   - Establish requirements for the data inventory, such as data elements to be captured (e.g., data type, data owner, data location), data sources, and frequency of updates.

4. **Capture Data Inventory Information:**
   - Gather information about the data within the inventory, including data type, data owner, data location, and data sensitivity level.
   - Use automated tools or manual processes to collect inventory information.

5. **Maintain Data Inventory:**
   - Regularly update the data inventory to reflect changes in data assets, such as new data additions, data modifications, or data deletions.
   - Ensure that sensitive data is prioritized for updates and review.

6. **Review and Update Inventory Annually:**
   - Conduct an annual review of the data inventory to ensure its accuracy and completeness.
   - Update the inventory with any changes identified during the review process.

7. **Implement Data Inventory Controls:**
   - Implement access controls to ensure that only authorized personnel can access the data inventory.
   - Encrypt sensitive data within the inventory to protect it from unauthorized access.

8. **Integrate Data Inventory with Data Management Process:**
   - Ensure that the data inventory is integrated with the enterprise's data management process to facilitate data governance and compliance activities.
   - Use the data inventory to inform data management decisions and prioritize data protection efforts.

9. **Employee Training and Awareness:**
   - Provide training to employees on the importance of maintaining a data inventory and their roles in updating it.
   - Raise awareness about the sensitivity of data and the need to protect it.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to data breaches or unauthorized access incidents related to data within the inventory.
    - Implement a reporting mechanism for reporting data breaches or incidents to the appropriate stakeholders.

11. **Continuous Improvement:**
    - Continuously assess and improve the data inventory process based on feedback, audit findings, and changes in regulations or business requirements.


## 3.3 Configure Data Access Control Lists

Implementing the CIS Safeguard for configuring data access control lists involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Data Access Needs:**
   - Determine the specific data access needs of users based on their roles and responsibilities.
   - Classify data based on sensitivity levels to determine the appropriate level of access control.

2. **Understand Data Access Control Lists (ACLs):**
   - Learn how to configure ACLs for different types of data storage systems, including local and remote file systems, databases, and applications.
   - Understand the different types of permissions that can be assigned in ACLs, such as read, write, execute, and delete.

3. **Configure ACLs Based on Need to Know:**
   - Assign ACLs based on the principle of least privilege, ensuring that users have only the permissions necessary to perform their job functions.
   - Use groups to simplify ACL management and assign permissions to groups rather than individual users whenever possible.

4. **Apply ACLs to Local and Remote File Systems:**
   - Configure ACLs on local file systems (e.g., Windows NTFS, Linux ext4) to control access to files and directories.
   - Apply ACLs to remote file systems (e.g., NFS, SMB) to restrict access to shared files and directories.

5. **Apply ACLs to Databases:**
   - Configure ACLs on databases to control access to tables, views, and other database objects.
   - Use database roles to group users with similar access needs and assign permissions to roles rather than individual users.

6. **Apply ACLs to Applications:**
   - Configure ACLs within applications to control access to sensitive data and features.
   - Use role-based access control (RBAC) or attribute-based access control (ABAC) to manage access to application resources.

7. **Regularly Review and Update ACLs:**
   - Conduct regular reviews of ACLs to ensure they remain aligned with users' access needs and data sensitivity levels.
   - Update ACLs as needed when users' roles change or when data sensitivity levels change.

8. **Implement Monitoring and Auditing:**
   - Monitor ACLs for unauthorized changes or access attempts.
   - Conduct regular audits of ACL configurations to identify and remediate security gaps.

9. **Employee Training and Awareness:**
   - Provide training to employees on how ACLs work and the importance of securing data through proper access controls.
   - Raise awareness about the need to follow the principle of least privilege when configuring ACLs.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to unauthorized access incidents related to ACLs.
    - Implement a reporting mechanism for reporting security incidents related to data access.

11. **Continuous Improvement:**
    - Continuously assess and improve ACL configurations based on feedback, audit findings, and changes in regulations or business requirements.

## 3.4 Enforce Data Retention

Implementing the CIS Safeguard for enforcing data retention involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Establish Data Retention Policy:** #policy #policies 
   - Define a data retention policy based on regulatory requirements, business needs, and data sensitivity levels.
   - Determine both the minimum and maximum retention timelines for different types of data.

2. **Identify Data Types and Retention Periods:**
   - Classify data based on its sensitivity level and the applicable regulatory requirements.
   - Determine the retention periods for each data type, considering factors such as legal requirements, business value, and operational needs.

3. **Implement Data Retention Controls:**
   - Use data lifecycle management tools to enforce data retention policies automatically.
   - Implement access controls to prevent unauthorized modification or deletion of data subject to retention policies.

4. **Educate Employees:**
   - Provide training to employees on the importance of data retention and the specific retention policies that apply to their work.
   - Raise awareness about the potential consequences of non-compliance with data retention policies.

5. **Monitor Data Retention Compliance:**
   - Regularly monitor data retention practices to ensure compliance with the established policies.
   - Conduct periodic audits to verify that data is being retained according to the defined timelines.

6. **Enforce Data Retention Policies:**
   - Enforce data retention policies consistently across the organization.
   - Implement controls to prevent data from being retained beyond the maximum retention period.

7. **Review and Update Data Retention Policies:**
   - Conduct regular reviews of data retention policies to ensure they remain aligned with regulatory requirements and business needs.
   - Update policies as needed based on changes in regulations or business practices.

8. **Securely Dispose of Data:**
   - Implement procedures for securely disposing of data that has reached the end of its retention period.
   - Use methods such as data wiping, shredding, or degaussing to ensure data is irrecoverable.

9. **Incident Response and Reporting:**
    - Establish procedures for responding to data retention incidents, such as data breaches or unauthorized access to retained data.
    - Implement a reporting mechanism for reporting data retention incidents to the appropriate stakeholders and regulatory bodies.

10. **Continuous Improvement:**
    - Continuously assess and improve data retention practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.5 Securely Dispose of Data

Implementing the CIS Safeguard for securely disposing of data involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Establish Data Disposal Policy:** #policies #policy 
   - Define a data disposal policy based on regulatory requirements, data sensitivity levels, and the enterprise's data management process.
   - Determine the disposal methods and processes to be used based on the sensitivity of the data.

2. **Identify Data for Disposal:**
   - Identify data that has reached the end of its retention period or is no longer needed for business purposes.
   - Classify data based on sensitivity to determine the appropriate disposal methods.

3. **Select Disposal Methods:**
   - Choose disposal methods based on the sensitivity of the data, such as data wiping, physical destruction (e.g., shredding), or degaussing for magnetic media.
   - Ensure that the disposal methods are appropriate for the type of media (e.g., hard drives, tapes, paper documents).

4. **Implement Data Disposal Controls:**
   - Implement access controls to ensure that only authorized personnel can initiate data disposal processes.
   - Use secure data disposal software or services to ensure data is irrecoverable.

5. **Educate Employees:**
   - Provide training to employees on the importance of securely disposing of data and the specific disposal methods that apply to their work.
   - Raise awareness about the potential consequences of non-compliance with data disposal policies.

6. **Monitor Data Disposal Compliance:**
   - Regularly monitor data disposal practices to ensure compliance with the established policies.
   - Conduct periodic audits to verify that data is being disposed of securely.

7. **Enforce Data Disposal Policies:**
   - Enforce data disposal policies consistently across the organization.
   - Implement controls to prevent unauthorized data disposal or accidental deletion of data.

8. **Review and Update Data Disposal Policies:**
   - Conduct regular reviews of data disposal policies to ensure they remain aligned with regulatory requirements and business needs.
   - Update policies as needed based on changes in regulations or business practices.

9. **Incident Response and Reporting:**
    - Establish procedures for responding to data disposal incidents, such as accidental data deletion or unauthorized data disposal.
    - Implement a reporting mechanism for reporting data disposal incidents to the appropriate stakeholders and regulatory bodies.

10. **Continuous Improvement:**
    - Continuously assess and improve data disposal practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.6 Encrypt Data on End-User Devices

Implementing the CIS Safeguard for encrypting data on end-user devices involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify End-User Devices:**
   - Identify the end-user devices (e.g., laptops, desktops, mobile devices) that contain sensitive data and require encryption.

2. **Select Encryption Software:**
   - Choose encryption software that is compatible with the operating systems used on end-user devices.
   - Examples of encryption software include Windows BitLocker for Windows devices, Apple FileVault for macOS devices, and Linux dm-crypt for Linux devices.

3. **Configure Encryption Software:**
   - Configure the encryption software to encrypt the entire hard drive or specific partitions containing sensitive data.
   - Set up encryption keys and ensure they are securely stored and managed.

4. **Educate End Users:**
   - Provide training to end users on the importance of encryption and how to use encryption software on their devices.
   - Ensure that end users understand the implications of not encrypting sensitive data on their devices.

5. **Enable Encryption:**
   - Enable encryption on all end-user devices containing sensitive data.
   - Monitor devices to ensure that encryption remains enabled and is not disabled by end users.

6. **Implement Encryption Policies:**
   - Establish policies that require encryption for all devices containing sensitive data.
   - Define procedures for managing encryption keys and recovering data in case of key loss or device failure.

7. **Monitor Encryption Compliance:**
   - Regularly monitor end-user devices to ensure compliance with encryption policies.
   - Conduct periodic audits to verify that encryption is enabled and functioning correctly on all devices.

8. **Enforce Encryption Policies:**
   - Enforce encryption policies consistently across all end-user devices.
   - Implement controls to prevent devices from accessing sensitive data if encryption is not enabled.

9. **Review and Update Encryption Policies:**
    - Conduct regular reviews of encryption policies to ensure they remain aligned with regulatory requirements and business needs.
    - Update policies as needed based on changes in regulations or business practices.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to incidents involving unencrypted sensitive data on end-user devices.
    - Implement a reporting mechanism for reporting encryption incidents to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve encryption practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.7 Establish and Maintain a Data Classification Scheme

Implementing the CIS Safeguard for establishing and maintaining an overall data classification scheme involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Define Data Classification Labels:**
   - Define data classification labels that are relevant to your organization, such as "Sensitive," "Confidential," "Internal Use Only," and "Public."
   - Ensure that the labels are clearly defined and understood by all employees.

2. **Identify Data Categories:**
   - Identify the different categories of data that exist within your organization, such as customer data, financial data, intellectual property, and operational data.
   - Determine which data categories correspond to each classification label.

3. **Establish Data Classification Criteria:**
   - Develop criteria for classifying data into different categories based on sensitivity, regulatory requirements, and business impact.
   - Consider factors such as the potential harm that could result from unauthorized disclosure, the value of the data to the organization, and any legal or regulatory requirements that apply.

4. **Assign Classification Labels:**
   - Assign classification labels to each data category based on the established criteria.
   - Ensure that data is classified consistently across the organization and that all employees understand how to apply the classification labels.

5. **Implement Data Classification Controls:**
   - Implement access controls based on data classification to ensure that only authorized personnel can access sensitive or confidential data.
   - Use encryption, data masking, or other security measures to protect classified data from unauthorized access.

6. **Educate Employees:**
   - Provide training to employees on the data classification scheme and how to apply it to their work.
   - Raise awareness about the importance of data classification in protecting sensitive information and complying with regulations.

7. **Review and Update Classification Scheme:**
   - Conduct an annual review of the data classification scheme to ensure it remains relevant and effective.
   - Update the classification scheme as needed when significant changes occur in the organization or when new types of data are introduced.

8. **Integrate Classification Scheme with Data Handling Processes:**
   - Integrate the data classification scheme with data handling processes, such as data storage, sharing, and disposal.
   - Ensure that data handling procedures are consistent with the classification labels assigned to the data.

9. **Incident Response and Reporting:**
    - Establish procedures for responding to data breaches or incidents involving classified data.
    - Implement a reporting mechanism for reporting data breaches or incidents to the appropriate stakeholders and regulatory bodies.

10. **Continuous Improvement:**
    - Continuously assess and improve the data classification scheme based on feedback, audit findings, and changes in regulations or business requirements.


## 3.8 Document Data Flows

Implementing the CIS Safeguard for documenting data flows involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Data Flows:**
   - Identify the data flows within your organization, including how data is collected, processed, stored, and transmitted.
   - Identify data flows involving service providers, including how data is shared with and received from external parties.

2. **Document Data Flows:**
   - Create detailed documentation of each data flow, including the types of data involved, the systems and applications used, and the parties responsible for each step of the data flow.
   - Use diagrams, flowcharts, or other visual aids to help illustrate the data flows.

3. **Review Data Flow Documentation:**
   - Conduct a thorough review of the data flow documentation to ensure accuracy and completeness.
   - Verify that the documentation reflects the current state of data flows within the organization.

4. **Update Data Flow Documentation:**
   - Update the data flow documentation annually or whenever significant changes occur in the organization that could impact data flows.
   - Ensure that any updates are clearly documented and communicated to relevant stakeholders.

5. **Integrate Data Flow Documentation with Data Management Process:**
   - Integrate the data flow documentation with the enterprise's data management process to ensure that data flows are aligned with data handling policies and procedures.
   - Use the data flow documentation to identify areas where data flows can be optimized or improved.

6. **Secure Data Flows:**
   - Implement security measures to protect data flows, including encryption, access controls, and monitoring.
   - Ensure that data flows involving service providers are also secure, and that service providers comply with data security requirements.

7. **Educate Employees:**
   - Provide training to employees on the importance of documenting data flows and how to accurately document data flows within their areas of responsibility.
   - Raise awareness about the potential security and compliance risks associated with undocumented or poorly documented data flows.

8. **Incident Response and Reporting:**
    - Establish procedures for responding to data breaches or incidents involving data flows.
    - Implement a reporting mechanism for reporting data flow incidents to the appropriate stakeholders and regulatory bodies.

9. **Continuous Improvement:**
    - Continuously assess and improve data flow documentation based on feedback, audit findings, and changes in regulations or business requirements.

## 3.9 Encrypt Data on Removable Media

Implementing the CIS Safeguard for encrypting data on removable media involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Removable Media:**
   - Identify the types of removable media used in your organization, such as USB drives, external hard drives, and optical discs.

2. **Select Encryption Software:**
   - Choose encryption software that is compatible with the types of removable media used in your organization.
   - Ensure that the encryption software supports strong encryption algorithms.

3. **Configure Encryption Software:**
   - Configure the encryption software to encrypt data on removable media automatically.
   - Set up encryption keys and ensure they are securely stored and managed.

4. **Encrypt Removable Media:**
   - Encrypt all removable media containing sensitive data before use.
   - Ensure that all encrypted removable media is properly labeled to indicate that it contains encrypted data.

5. **Educate Users:**
   - Provide training to users on the importance of encrypting data on removable media and how to use encryption software.
   - Raise awareness about the potential consequences of not encrypting sensitive data on removable media.

6. **Implement Encryption Policies:**
   - Establish policies that require encryption for all sensitive data stored on removable media.
   - Define procedures for managing encryption keys and recovering data in case of key loss or media failure.

7. **Monitor Encryption Compliance:**
   - Regularly monitor the use of removable media to ensure compliance with encryption policies.
   - Conduct periodic audits to verify that encryption is being used correctly on all removable media.

8. **Enforce Encryption Policies:**
   - Enforce encryption policies consistently across the organization.
   - Implement controls to prevent the use of unencrypted removable media for storing sensitive data.

9. **Review and Update Encryption Policies:**
    - Conduct regular reviews of encryption policies to ensure they remain aligned with regulatory requirements and business needs.
    - Update policies as needed based on changes in regulations or business practices.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to incidents involving unencrypted sensitive data on removable media.
    - Implement a reporting mechanism for reporting encryption incidents to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve encryption practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.10 Encrypt Sensitive Data in Transit

Implementing the CIS Safeguard for encrypting sensitive data in transit involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Sensitive Data:**
   - Identify the types of sensitive data that are transmitted over your network, such as personal information, financial data, or proprietary information.

2. **Select Encryption Protocols:**
   - Choose encryption protocols that are suitable for encrypting sensitive data in transit, such as Transport Layer Security (TLS) for web traffic or Open Secure Shell (OpenSSH) for secure shell connections.
   - Ensure that the selected protocols support strong encryption algorithms.

3. **Configure Encryption Protocols:**
   - Configure the encryption protocols to encrypt sensitive data automatically.
   - Set up encryption keys and ensure they are securely stored and managed.

4. **Implement Encryption for Network Protocols:**
   - Enable encryption for network protocols that transmit sensitive data, such as HTTPS for web traffic, SMTPS for email, and SFTP for file transfers.
   - Ensure that encryption is enabled for all sensitive data transmissions.

5. **Educate Users:**
   - Provide training to users on the importance of encrypting sensitive data in transit and how to use encryption protocols.
   - Raise awareness about the potential consequences of transmitting sensitive data without encryption.

6. **Implement Encryption Policies:**
   - Establish policies that require encryption for all sensitive data transmitted over your network.
   - Define procedures for managing encryption keys and certificates.

7. **Monitor Encryption Compliance:**
   - Regularly monitor network traffic to ensure compliance with encryption policies.
   - Conduct periodic audits to verify that encryption is being used correctly for sensitive data transmissions.

8. **Enforce Encryption Policies:**
   - Enforce encryption policies consistently across the organization.
   - Implement controls to prevent the transmission of sensitive data without encryption.

9. **Review and Update Encryption Policies:**
    - Conduct regular reviews of encryption policies to ensure they remain aligned with regulatory requirements and business needs.
    - Update policies as needed based on changes in regulations or business practices.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to incidents involving the transmission of sensitive data without encryption.
    - Implement a reporting mechanism for reporting encryption incidents to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve encryption practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.11 Encrypt Sensitive Data at Rest

Implementing the CIS Safeguard for encrypting sensitive data at rest involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Sensitive Data:**
   - Identify the types of sensitive data that are stored on your servers, applications, and databases, such as personal information, financial data, or proprietary information.

2. **Select Encryption Methods:**
   - Choose encryption methods that are suitable for encrypting sensitive data at rest, such as storage-layer encryption (server-side encryption) for encrypting data on storage devices or application-layer encryption (client-side encryption) for encrypting data before it is stored.
   - Ensure that the selected encryption methods support strong encryption algorithms.

3. **Configure Storage-Layer Encryption:**
   - Configure storage-layer encryption to automatically encrypt sensitive data at rest on storage devices.
   - Set up encryption keys and ensure they are securely stored and managed.

4. **Implement Application-Layer Encryption:**
   - Implement application-layer encryption to encrypt sensitive data before it is stored.
   - Ensure that encryption keys are managed securely and that access to the data storage device does not permit access to the plain-text data.

5. **Encrypt Data on Servers, Applications, and Databases:**
   - Encrypt sensitive data at rest on servers, applications, and databases containing sensitive data.
   - Ensure that encryption is enabled for all sensitive data stored on these systems.

6. **Educate Users:**
   - Provide training to users on the importance of encrypting sensitive data at rest and how to use encryption methods.
   - Raise awareness about the potential consequences of storing sensitive data without encryption.

7. **Implement Encryption Policies:**
   - Establish policies that require encryption for all sensitive data at rest on servers, applications, and databases.
   - Define procedures for managing encryption keys and certificates.

8. **Monitor Encryption Compliance:**
   - Regularly monitor data storage systems to ensure compliance with encryption policies.
   - Conduct periodic audits to verify that encryption is being used correctly for sensitive data storage.

9. **Enforce Encryption Policies:**
   - Enforce encryption policies consistently across the organization.
   - Implement controls to prevent the storage of sensitive data without encryption.

10. **Review and Update Encryption Policies:**
    - Conduct regular reviews of encryption policies to ensure they remain aligned with regulatory requirements and business needs.
    - Update policies as needed based on changes in regulations or business practices.

11. **Incident Response and Reporting:**
    - Establish procedures for responding to incidents involving the storage of sensitive data without encryption.
    - Implement a reporting mechanism for reporting encryption incidents to the appropriate stakeholders and regulatory bodies.

12. **Continuous Improvement:**
    - Continuously assess and improve encryption practices based on feedback, audit findings, and changes in regulations or business requirements.

## 3.12 Segment Data Processing and Storage Based on Sensitivity

Implementing the CIS Safeguard for segmenting data processing and storage based on sensitivity involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Identify Data Sensitivity Levels:**
   - Classify data based on sensitivity levels, such as "Sensitive," "Confidential," and "Public," according to your organization's data classification scheme.

2. **Define Data Processing and Storage Segmentation:**
   - Establish policies and guidelines for segmenting data processing and storage based on sensitivity levels.
   - Define which assets are intended for processing and storing sensitive data and which are intended for lower sensitivity data.

3. **Implement Network Segmentation:**
   - Segment your network into zones based on data sensitivity levels.
   - Use firewalls, VLANs, and other network segmentation techniques to enforce separation between zones.

4. **Implement Access Controls:**
   - Implement access controls to ensure that only authorized users and systems can access sensitive data processing and storage assets.
   - Use role-based access control (RBAC) to enforce access rights based on sensitivity levels.

5. **Encrypt Data in Transit and at Rest:**
   - Encrypt sensitive data both in transit and at rest to protect it from unauthorized access.
   - Use strong encryption algorithms and manage encryption keys securely.

6. **Monitor and Audit Data Access:**
   - Monitor data access and usage to detect and respond to unauthorized access attempts.
   - Conduct regular audits of data access logs to ensure compliance with segmentation policies.

7. **Educate Employees:**
   - Provide training to employees on the importance of data segmentation and how to handle sensitive data securely.
   - Raise awareness about the potential consequences of not adhering to segmentation policies.

8. **Enforce Segmentation Policies:**
   - Enforce segmentation policies consistently across the organization.
   - Implement controls to prevent the processing of sensitive data on assets intended for lower sensitivity data.

9. **Review and Update Segmentation Policies:**
    - Conduct regular reviews of segmentation policies to ensure they remain aligned with regulatory requirements and business needs.
    - Update policies as needed based on changes in regulations or business practices.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to incidents involving the unauthorized processing or storage of sensitive data.
    - Implement a reporting mechanism for reporting segmentation incidents to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve segmentation practices based on feedback, audit findings, and changes in regulations or business requirements.

By following these steps, you can effectively implement the CIS Safeguard for segmenting data processing and storage based on sensitivity in your organization.

## 3.13 Deploy a Data Loss Prevention Solution

Implementing a Data Loss Prevention (DLP) solution involves several key steps. Here's a detailed guide to help you implement it effectively:

1. **Define Requirements:**
   - Identify the specific requirements for your DLP solution, including the types of sensitive data you want to protect, the locations where the data is stored or processed, and the compliance requirements you need to meet.

2. **Select DLP Solution:**
   - Choose a DLP solution that meets your requirements and is compatible with your existing infrastructure.
   - Consider factors such as scalability, ease of deployment, and integration with other security tools.

3. **Deploy DLP Solution:**
   - Install and configure the DLP solution according to the vendor's guidelines.
   - Ensure that the solution is deployed on all relevant endpoints, servers, and network devices.

4. **Create Data Inventory:**
   - Use the DLP solution to create a data inventory that identifies all sensitive data stored, processed, or transmitted through enterprise assets.
   - Update the data inventory regularly to reflect changes in your data environment.

5. **Define DLP Policies:**
   - Define DLP policies that specify how sensitive data should be handled and protected.
   - Configure the DLP solution to enforce these policies and prevent data loss or leakage.

6. **Monitor and Analyze Data Traffic:**
   - Use the DLP solution to monitor and analyze data traffic to identify any unauthorized or suspicious activities.
   - Set up alerts and notifications to alert security teams to potential data breaches.

7. **Educate Employees:**
   - Provide training to employees on how to recognize and prevent data loss or leakage.
   - Raise awareness about the importance of data protection and the role of the DLP solution in safeguarding sensitive data.

8. **Integrate with Security Infrastructure:**
   - Integrate the DLP solution with your existing security infrastructure, such as firewalls, SIEM systems, and endpoint protection tools.
   - Ensure that the DLP solution can share information and respond to security incidents in real time.

9. **Regularly Update and Maintain:**
    - Keep the DLP solution up to date with the latest patches and updates to protect against new threats.
    - Regularly review and update DLP policies and configurations to ensure they remain effective.

10. **Incident Response and Reporting:**
    - Establish procedures for responding to data loss incidents detected by the DLP solution.
    - Implement a reporting mechanism for reporting incidents to the appropriate stakeholders and regulatory bodies.

11. **Continuous Improvement:**
    - Continuously assess and improve the DLP solution based on feedback, audit findings, and changes in regulations or business requirements.

By following these steps, you can effectively deploy a Data Loss Prevention (DLP) solution to protect sensitive data in your organization.

## 3.14 Log Sensitive Data Access

Logging sensitive data access, modification, and disposal is crucial for ensuring data security and compliance. Here's a guide to help you implement this safeguard effectively:

1. **Identify Sensitive Data:**
   - Identify the types of sensitive data that need to be logged, including personal information, financial data, and proprietary information.

2. **Enable Logging:**
   - Enable logging on systems, applications, and databases that process or store sensitive data.
   - Ensure that logging captures access, modification, and disposal events related to sensitive data.

3. **Define Logging Policies:**
   - Establish logging policies that specify what data to log, how long to retain logs, and who has access to log data.
   - Ensure that logging policies comply with regulatory requirements and industry best practices.

4. **Log Access Events:**
   - Log access events for sensitive data, including both successful and unsuccessful access attempts.
   - Capture information such as the user or system accessing the data, the time of access, and the type of access (read, write, etc.).

5. **Log Modification Events:**
   - Log modification events for sensitive data, including any changes made to the data.
   - Capture information such as the user or system making the modification, the time of modification, and the nature of the modification.

6. **Log Disposal Events:**
   - Log disposal events for sensitive data, including when data is deleted or otherwise disposed of.
   - Capture information such as the user or system disposing of the data, the time of disposal, and the method of disposal.

7. **Monitor and Review Logs:**
   - Monitor log data regularly to detect unauthorized access, modifications, or disposal of sensitive data.
   - Review logs for anomalies or suspicious activities that may indicate a data security incident.

8. **Protect Log Data:**
   - Ensure that log data is protected from unauthorized access, modification, or deletion.
   - Use encryption, access controls, and logging integrity checks to protect log data.

9. **Incident Response and Reporting:**
   - Establish procedures for responding to data security incidents detected through log monitoring.
   - Implement a reporting mechanism for reporting incidents to the appropriate stakeholders and regulatory bodies.

10. **Continuous Improvement:**
    - Continuously assess and improve logging practices based on feedback, audit findings, and changes in regulations or business requirements.

By following these steps, you can effectively log sensitive data access, modification, and disposal to enhance data security and compliance in your organization.
