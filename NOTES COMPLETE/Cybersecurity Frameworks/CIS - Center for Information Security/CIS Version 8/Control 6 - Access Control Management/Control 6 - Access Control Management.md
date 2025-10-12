# Overview

Use processes and tools to create, assign, manage, and revoke access credentials and privileges for user, administrator, and service accounts for enterprise assets and software.

# Why this control is critical?

### Managing Access to Enterprise Assets and Data

- **Scope of Control:**
  - CIS Control 6 focuses on managing access to enterprise assets and data, ensuring users only have access appropriate for their role, and ensuring strong authentication for critical or sensitive data or functions.

- **Minimal Authorization:**
  - Accounts should have only the minimal authorization needed for the role.

- **Consistent Access Rights:**
  - Developing consistent access rights for each role and assigning roles to users is a best practice.

- **Provisioning and De-Provisioning:**
  - Developing a program for complete provisioning and de-provisioning access is important, and centralizing this function is ideal.

- **Risk-Prone User Activities:**
  - Some user activities pose greater risk to an enterprise, such as accessing from untrusted networks or performing administrator functions.
  - These activities enforce the importance of using Multi-Factor Authentication (MFA) and Privileged Access Management (PAM) tools.

- **Unauthorized Access Due to Process Issues:**
  - Some users may have access to enterprise assets or data they do not need for their role, due to an immature process that gives all users all access, or lingering access as users change roles within the enterprise over time.

- **Local Administrator Privileges:**
  - Local administrator privileges to users’ laptops can be problematic, as any malicious code installed or downloaded by the user can have a greater impact on the enterprise asset running as an administrator.

- **Access Based on Enterprise Role and Need:**
  - User, administrator, and service account access should be based on enterprise role and need.

---

# Procedures and Tools

### Privilege Management and Multi-Factor Authentication

- **Privilege Granting and Revocation Process:**
  - There should be a process where privileges are granted and revoked for user accounts based on enterprise role and need through role-based access.

- **Role-Based Access:**
  - Role-based access defines and manages access requirements for each account based on need to know, least privilege, privacy requirements, and/or separation of duties.

- **Technology Tools for Privilege Management:**
  - There are technology tools to help manage the privilege granting and revocation process, including more granular or temporary access based on circumstance.

- **Universal MFA for Privileged Accounts:**
  - Multi-Factor Authentication (MFA) should be universal for all privileged or administrator accounts.
  - MFA tools with smartphone applications are easy to deploy, and the number-generator feature is more secure than just sending a Short Messaging Service (SMS) message with a one-time code or prompting a "push" alert for a user to accept.
  - PAM tools are available for privileged account control, providing a one-time password that must be checked out for each use.
  - For additional security in system administration, using "jump-boxes" or out-of-band terminal connections is recommended.

- **Comprehensive Account De-Provisioning:**
  - Comprehensive account de-provisioning is important, including consistent processes for removing access when employees and contractors leave the enterprise.

- **Tracking and Securing Service Accounts:**
  - Enterprises should inventory and track service accounts to prevent leaving clear text tokens or passwords in code and posting them to public cloud-based code repositories.

- **Separation of High-Privileged Accounts from Daily Use:**
  - High-privileged accounts should not be used for day-to-day use, such as web surfing and email reading.
  - Administrators should have separate accounts without elevated privileges for daily office use and should log into administrator accounts only when performing functions requiring that level of authorization.
  - Security personnel should periodically gather a list of running processes to determine whether any browsers or email readers are running with high privileges.

---

Feel free to adjust or add any additional details!
# Safeguards

## 6.1 Establish an Access Granting Process

### Establishing a Process for Granting Access to Enterprise Assets

- **Purpose:** Ensure that new hires, role changes, or rights grants are handled efficiently and securely, minimizing the risk of unauthorized access.

- **Key Steps:**
  1. **Automated Access Provisioning:** Implement automated tools or scripts to provision access based on predefined roles or rights.
  2. **Role-Based Access Control (RBAC):** Define roles with specific access permissions and assign them to users based on their job responsibilities.
  3. **Request and Approval Workflow:** Establish a workflow for users to request access, which must be approved by the appropriate authority before access is granted.
  4. **Integration with HR Systems:** Integrate access provisioning with HR systems to automatically grant access upon new hire or role change.
  5. **Access Reviews:** Conduct regular reviews of access rights to ensure they are appropriate and revoke access for users who no longer need it.
  6. **Logging and Monitoring:** Log access provisioning activities and monitor for anomalies or unauthorized access attempts.
  7. **User Training:** Provide training to users on access request procedures and the importance of secure access management.

- **Considerations:**
  - **Security:** Ensure that access provisioning processes comply with security policies and standards.
  - **Efficiency:** Automate processes to reduce manual effort and ensure timely access provisioning.
  - **Auditing:** Regularly audit access provisioning activities to ensure compliance and identify any issues.

By establishing and following a process for granting access to enterprise assets, organizations can ensure that access is granted efficiently and securely, minimizing the risk of unauthorized access.

## 6.2 Establish an Access Revoking Process

### Establishing a Process for Revoking Access to Enterprise Assets

- **Purpose:** Ensure that access to enterprise assets is promptly revoked when an employee leaves the organization or experiences a change in role or access rights.

- **Key Steps:**
  1. **Automated Access Revocation:** Implement automated tools or scripts to revoke access immediately upon termination, rights revocation, or role change.
  2. **Role-Based Access Control (RBAC):** Define roles with specific access permissions and remove them from users who no longer require them.
  3. **Disabling Accounts:** Disable user accounts instead of deleting them to preserve audit trails and prevent unauthorized access.
  4. **Integration with HR Systems:** Integrate access revocation with HR systems to automatically disable accounts upon termination or role change.
  5. **Access Reviews:** Conduct regular reviews of access rights to ensure they are up-to-date and revoke access for users who no longer need it.
  6. **Logging and Monitoring:** Log access revocation activities and monitor for anomalies or unauthorized access attempts.
  7. **User Training:** Provide training to users on the importance of promptly reporting changes in access requirements.

- **Considerations:**
  - **Security:** Ensure that access revocation processes comply with security policies and standards.
  - **Efficiency:** Automate processes to reduce manual effort and ensure timely access revocation.
  - **Audit Trails:** Maintain detailed audit trails of access revocation activities for compliance and security purposes.

## 6.3 Require MFA for Externally-Exposed Applications

## 6.4 Require MFA for Remote Network Access

## 6.5 Require MFA for Administrative Access

## 6.6 Establish and Maintain an Inventory of Authentication and Authorization Systems

## 6.7 Centralize Access Control

## 6.8 Define and Maintain Role-Based Access Control