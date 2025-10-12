# Overview

Use processes and tools to assign and manage authorization to credentials for user accounts, including administrator accounts, as well as service accounts, to enterprise assets and software.

# Why this Control is Critical

### Unauthorized Access to Enterprise Assets and Data

- **Ease of Unauthorized Access:** It is easier for both external and internal threat actors to gain unauthorized access to enterprise assets or data through using valid user credentials than through hacking the environment.

- **Covert Access Methods:** There are several covert methods to obtain access to user accounts, including:
  - Weak passwords
  - Accounts still valid after a user leaves the enterprise
  - Dormant or lingering test accounts
  - Shared accounts that have not been changed in months or years
  - Service accounts embedded in applications for scripts
  - Users having the same password as one they use for an online account that has been compromised (in a public password dump)
  - Social engineering to obtain a user's password
  - Using malware to capture passwords or tokens in memory or over the network

- **Targeting Administrative and Highly Privileged Accounts:** 
  - Administrative accounts are a particular target because they allow attackers to add other accounts or make changes to assets that could make them more vulnerable to other attacks.
  - Service accounts are also sensitive, often shared among teams, internal and external to the enterprise, and sometimes not known about until revealed in standard account management audits.

- **Account Logging and Monitoring:** 
  - Account logging and monitoring are critical components of security operations.
  - While covered in CIS Control 8 (Audit Log Management), they are essential in the development of a comprehensive Identity and Access Management (IAM) program.


# Procedures and Tools

### Procedures and Tools for Managing Credentials and Accounts

- **Inventory and Tracking:**
  - Credentials are assets that must be inventoried and tracked like enterprise assets and software, as they are the primary entry point into the enterprise.
  - Appropriate password policies and guidance should be developed to avoid password reuse.

- **Password Policy Guidance:** #policies #policy 
  - For guidance on the creation and use of passwords, reference the [CIS Password Policy Guide](https://www.cisecurity.org/white-papers/cis-password-policy-guide/).

- **Account Tracking and Audits:**
  - Accounts must be tracked, and dormant accounts should be disabled and eventually removed from the system.
  - Periodic audits should be conducted to ensure all active accounts are traced back to authorized users of the enterprise asset.
  - Look for new accounts added since the previous review, especially administrator and service accounts.
  - Identify and track administrative or high-privileged accounts and service accounts.

- **Separate Accounts for Administrator Access:**
  - Users with administrator or other privileged access should have separate accounts for those higher authority tasks.
  - These accounts should only be used when performing those tasks or accessing especially sensitive data, to reduce risk in case their normal user account is compromised.
  - Base user accounts, used day-to-day for non-administrative tasks, should not have any elevated privileges.

- **Single Sign-On (SSO) and Password Management:**
  - SSO is convenient and secure when an enterprise has many applications, including cloud applications, which helps reduce the number of passwords a user must manage.
  - Users are recommended to use password manager applications to securely store their passwords and should be instructed not to keep them in spreadsheets or text files on their computers.

- **Multi-Factor Authentication (MFA):**
  - MFA is recommended for remote access.

- **Automatic Logouts and Screen Locking:**
  - Users must be automatically logged out of the system after a period of inactivity.
  - Users should be trained to lock their screen when they leave their device to minimize the possibility of someone else in physical proximity accessing their system, applications, or data.

# Safeguards
## 5.1 Establish and Maintain Inventory of Accounts 

- **Inventory Scope:**
  - Establish and maintain an inventory of all accounts managed in the enterprise, including both user and administrator accounts.

- **Inventory Contents:**
  - The inventory should contain, at a minimum, the person’s name, username, start/stop dates, and department.

- **Validation of Active Accounts:**
  - Validate that all active accounts are authorized on a recurring schedule, at a minimum quarterly, or more frequently.

## 5.2 Use Unique Passwords 

### Best Practices for Enterprise Password Management

- **Use Unique Passwords:** Ensure that each enterprise asset has its own unique password to reduce the risk of unauthorized access.

- **Minimum Password Length:** 
  - Accounts using Multi-Factor Authentication (MFA) should have a minimum password length of 8 characters.
  - Accounts not using MFA should have a minimum password length of 14 characters.

- **Implementing MFA:** Consider implementing Multi-Factor Authentication (MFA) for all accounts to add an extra layer of security.

- **Regularly Update Passwords:** Encourage users to regularly update their passwords to mitigate the risk of password compromise.

- **Password Complexity:** Use a combination of letters, numbers, and special characters to create complex passwords that are harder to guess.

- **Password Managers:** Utilize password management tools to securely store and manage passwords.

- **Educate Users:** Provide training and guidelines to educate users about the importance of password security and best practices.

- **Regular Audits:** Conduct regular audits of passwords to ensure compliance with the password policy and identify any security vulnerabilities.

- **Enforce Password Policies:** Enforce strict password policies to ensure that users adhere to best practices for password management.

- **Implement Account Lockout:** Implement account lockout policies to prevent brute-force attacks on user accounts.

By following these best practices, enterprises can improve their password security and reduce the risk of unauthorized access to their assets.

## 5.3 Disable Dormant Accounts 

### Best Practice: Deleting or Disabling Dormant Accounts

- **Purpose:** Deleting or disabling dormant accounts helps reduce the risk of unauthorized access and ensures that only active accounts are accessible.

- **Implementation Steps:**
  1. **Identify Dormant Accounts:** Use automated tools or scripts to identify accounts that have been inactive for 45 days or more.
  
  2. **Notification:** Notify users with dormant accounts about the upcoming deletion or disabling process.
  
  3. **Verification:** Verify with the user or department manager if the account is still needed before proceeding with deletion or disabling.
  
  4. **Deletion or Disabling:**
     - **Delete:** If the account is no longer needed, delete it from the system.
     - **Disable:** If there is uncertainty about the need for the account, disable it temporarily.

  5. **Retention Period:** Store deleted or disabled accounts in a secure location for a defined period in case they need to be restored.
  
  6. **Regular Audits:** Conduct regular audits to identify and address dormant accounts in a timely manner.
  
  7. **Policy Enforcement:** Enforce a policy that mandates the deletion or disabling of dormant accounts after 45 days of inactivity. #policies #policy 

- **Considerations:**
  - **Impact Analysis:** Consider the potential impact of deleting or disabling an account on the user and the organization's operations.
  - **Compliance:** Ensure that the deletion or disabling process complies with relevant regulations and industry standards.
  - **Monitoring:** Continuously monitor for dormant accounts to maintain a secure environment.

By following these steps, organizations can effectively manage dormant accounts and reduce the risk of unauthorized access.

## 5.4 Restrict Administrator Privileges to Dedicated Administrator Accounts 

### Best Practice: Restricting Administrator Privileges

- **Purpose:** Restricting administrator privileges helps prevent unauthorized access and reduces the risk of malware infections and other security breaches.

- **Implementation Steps:**
  1. **Create Dedicated Administrator Accounts:** Create separate user accounts specifically for administrative tasks. These accounts should only be used for administrative purposes.
  
  2. **Assign Privileges:** Assign administrative privileges only to these dedicated administrator accounts. Regular user accounts should not have administrative privileges.
  
  3. **Use Non-Privileged Accounts for General Activities:** For general computing activities such as internet browsing, email, and productivity suite use, users should use their primary, non-privileged accounts.
  
  4. **Implement Least Privilege Principle:** Follow the principle of least privilege, granting users only the permissions they need to perform their job duties.
  
  5. **Educate Users:** Educate users about the importance of using dedicated administrator accounts for administrative tasks and the risks of using privileged accounts for general activities.
  
  6. **Monitor Privileged Access:** Monitor and log privileged access to detect any unauthorized use or anomalies.
  
  7. **Regular Audits:** Conduct regular audits to ensure compliance with the policy of using dedicated administrator accounts. #policies #policy 
  
- **Considerations:**
  - **Implementing Privilege Management Tools:** Consider using privilege management tools to automate the assignment and management of privileges.
  - **User Convenience vs. Security:** Balance the need for security with user convenience to ensure that users can perform their job duties effectively.
  
By following these steps, organizations can reduce the risk of unauthorized access and improve overall security posture.

## 5.5 Establish and Maintain Inventory of Service Accounts 

### Best Practice: Managing Service Accounts

- **Purpose:** Managing service accounts helps ensure that only authorized accounts are active, reducing the risk of unauthorized access and improving overall security posture.

- **Implementation Steps:**
  1. **Establish Inventory:** Create an inventory of service accounts that includes the department owner, review date, and purpose of each account.
  
  2. **Document Service Accounts:** Document all service accounts, including their purpose and any dependencies they have.
  
  3. **Review and Validation:** Regularly review the inventory to validate that all active service accounts are authorized. Perform reviews on a recurring schedule, at a minimum quarterly, or more frequently if necessary.
  
  4. **Account Deactivation:** Deactivate or remove any service accounts that are no longer needed or are unauthorized.
  
  5. **Authorization Process:** Implement a process for authorizing new service accounts, including obtaining approval from the department owner.
  
  6. **Access Controls:** Implement access controls to restrict access to service accounts based on the principle of least privilege.
  
  7. **Documentation and Training:** Document the process for managing service accounts and provide training to relevant staff on how to use and manage them securely.
  
- **Considerations:**
  - **Automation:** Consider using automation tools to help manage and track service accounts more efficiently.
  - **Integration with Identity Management Systems:** Integrate the management of service accounts with your organization's identity management system for better control and visibility.
  
By following these steps, organizations can effectively manage service accounts and reduce the risk of unauthorized access.

## 5.6 Centralize Account Management  

### Best Practice: Centralized Account Management

- **Purpose:** Centralizing account management helps streamline user access and enhances security by enforcing consistent policies across the organization.

- **Implementation Steps:**
  1. **Choose a Directory Service:** Select a directory service or identity management system that meets the organization's needs and integrates well with existing systems.
  
  2. **Integrate Systems:** Integrate all relevant systems with the chosen directory service to centralize user account management.
  
  3. **Consolidate User Accounts:** Consolidate user accounts from disparate systems into the directory service to reduce management overhead.
  
  4. **Implement Single Sign-On (SSO):** Implement SSO to allow users to access multiple systems with a single set of credentials, enhancing user experience and security.
  
  5. **Enforce Policies:** Enforce access policies, such as password complexity requirements and account lockout policies, through the directory service.
  
  6. **Monitor and Audit:** Monitor and audit account activity through the directory service to detect and respond to unauthorized access attempts.
  
  7. **Regular Reviews:** Conduct regular reviews of user accounts and access permissions to ensure compliance with organizational policies and regulations.
  
- **Considerations:**
  - **Scalability:** Ensure that the chosen directory service can scale to accommodate the organization's growth.
  - **Integration with Existing Systems:** Ensure that the directory service can integrate with existing systems to minimize disruption to operations.
  
By centralizing account management, organizations can improve security, simplify user access, and reduce management overhead.
