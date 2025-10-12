---
Status: Done
---
# Active Directory Overview

---

### Active Directory (AD) Course Introduction (Transcript Notes)

1. **Importance of Active Directory (AD)**:
    - AD knowledge is essential in ethical hacking, especially for internal penetration testing.
    - **Prevalence**: AD is widely used, with around **95% of Fortune 1000 companies** relying on it for identity and access management.
    - Many courses overlook AD, but it is crucial for interview preparation and real-world pentesting.
2. **What is Active Directory?**
    - AD serves as a **directory service**—essentially a **digital phone book** storing information on various networked objects, such as:
        - **Users, Computers, Printers, Groups, and Policies**.
    - AD allows for **centralized identity management** on Windows networks.
    - When employees log into different computers or systems on a network, AD verifies their identity, enabling a **single username/password** for multiple access points.
3. **Authentication Mechanism**:
    - AD uses **Kerberos authentication**, which relies on **tickets** to grant access to resources.
    - **Kerberos** will be discussed further in the course, including methods of attacking it.
4. **Why Learn AD for Pentesting?**
    - **AD is Ubiquitous**: Nearly all corporate networks employ AD, making it critical for internal assessments.
    - **Internal Pentesting Relevance**: While many courses cover external assessments, internal assessments offer extensive opportunities.
        - AD vulnerabilities often allow exploitation **without traditional exploits**—attackers can exploit **features and default configurations**.
    - **Abuse of AD Features**:
        - AD features, such as **trust relationships** and **inadequate policies**, can be leveraged for privilege escalation.
    - **Policy Gaps**: Many AD networks lack sufficient internal policies, making them vulnerable to various attacks, even without zero-day exploits.
5. **Course Structure**:
    - The course will start with **understanding AD fundamentals**, followed by **building an AD lab environment**.
    - Finally, **practical attacks on AD** will be demonstrated to illustrate vulnerabilities and how they can be exploited.
6. **Key Takeaway**:
    - Understanding and exploiting AD is essential for any ethical hacker, especially for roles focused on internal network security.

---

# Physical Active Directory Components

---

### Key Components

### 1. **Domain Controller (DC)**

- **Role**: Primary component; manages network and hosts Active Directory Domain Services (AD DS).
- **Functions**:
    - **Directory Store**: Acts as a "phone book" for users, computers, printers, and other resources in the network.
    - **Authentication & Authorization**: Central to AD authentication, handling identity verification and permissions.
    - **Replication**: In a multi-domain/forest structure, DCs replicate updates across the network to ensure consistency.
    - **Administration**: Allows creation and management of user accounts, computers, policies, etc.
- **Importance in Security**:
    - **Primary Target**: Compromising a DC can potentially compromise the entire network, making it a critical target in internal assessments.
    - **Beyond DC**: Important to consider other sensitive data (e.g., PCI, PII) beyond just the DC in penetration tests.

### 2. **Active Directory Data Store**

- **Purpose**: Stores all AD data, including a critical file: `NTDS.dit`.
- **NTDS.dit File**:
    - **Contents**: Stores all users, groups, objects, and password hashes.
    - **Attack Implications**:
        - Allows attackers to retrieve password hashes.
        - Enables advanced attack techniques like _Pass-the-Hash_ and _Golden Ticket_ attacks.

### Key Takeaways for Attackers

- **Domain Controller**: Core target for network compromise; controls most network data and functions.
- **Data Store**: `NTDS.dit` file contains essential information for exploitation, especially password hashes.

---

# 3. Logical Active Directory Components

### Overview

- **Logical Components**: Critical for organizing and managing resources within AD.
- **Course Focus**: Familiarize with key terms and concepts, particularly domains, organizational units (OUs), and objects.

### Key Components

### 1. **Active Directory Schema**

- **Definition**: Acts as a "rule book" or blueprint for AD.
- **Function**: Defines every object type that can be created and enforces rules on object creation and configuration.

### 2. **Domains**

- **Definition**: A grouping unit to organize objects within a single organization.
- **Function**: Serves as administrative boundaries, supporting policies, authentication, and authorization.
- **Typical Structure**: Small businesses may have a single domain to manage all resources (users, computers, etc.).

### 3. **Trees**

- **Definition**: A hierarchy of domains, with one parent domain and potentially multiple child domains.
- **Example**:
    - Parent domain: `contoso.com`
    - Child domains: `na.contoso.com` (North America) and `emea.contoso.com` (Europe).
- **Trusts**: Established between parent and child domains (transitive).

### 4. **Forest**

- **Definition**: A collection of multiple domain trees that may belong to different organizations but are linked through trust relationships.
- **Usage**: Larger AD structures; often involve complex trust and sharing mechanisms between trees.

### 5. **Organizational Units (OUs)**

- **Definition**: Containers within domains to organize objects.
- **Purpose**: Enable structured management of users, groups, and computers.
- **Example**: Separate OUs for different departments (e.g., Sales, IT).

### 6. **Trusts**

- **Purpose**: Control access to resources between domains or forests.
- **Types**:
    - **Directional Trust**: One-way trust where Domain A trusts Domain B.
    - **Transitive Trust**: Extends trust to other domains that the trusted domain itself trusts, applicable in trees and forests.

### 7. **Objects**

- **Definition**: Individual items managed within AD, stored in OUs.
- **Examples**: Users, groups, computers, printers, shared folders.

### Summary

- **Hierarchical Structure**:
    - **Domains** → group and manage objects within an organization.
    - **Trees** → collection of related domains (parent/child relationship).
    - **Forests** → multiple trees with linked trust relationships.
- **OUs**: Organizational containers within domains to help organize resources.
- **Trusts**: Mechanisms for resource access across domains and forests.