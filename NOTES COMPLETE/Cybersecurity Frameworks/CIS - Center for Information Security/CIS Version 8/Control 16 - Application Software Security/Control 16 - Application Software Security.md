
# Overview 

Manage the security life cycle of in-house developed, hosted, or acquired software to prevent, detect, and remediate security weaknesses before they can impact the enterprise.
# Why is this Control critical

### Interface and Data Management
- **Human-Friendly Interface**: Applications provide a user-friendly interface for accessing and managing data aligned with business functions.
- **Complexity Reduction**: They minimize the need for users to interact directly with complex system functions, reducing the potential for errors.

### Security Risks
- **Data Compromise**: Attackers can exploit applications to compromise sensitive data, making the protection of user credentials crucial (as defined in CIS Control 6).
- **Attack Vector**: Application flaws are a common attack vector, especially as modern applications run on diverse platforms with complex architectures.

### Modern Application Challenges
- **Complex Environment**: Applications run on multiple platforms (web, mobile, cloud) with complex architectures, making security more challenging.
- **Shorter Development Cycles**: Development cycles have become shorter, transitioning to DevOps with frequent code updates.
- **Regulatory Compliance**: Compliance with modern data protection regulations adds complexity to application security.

### Vulnerabilities and Exploitation
- **Causes of Vulnerabilities**: Vulnerabilities can arise from insecure design, infrastructure, coding mistakes, weak authentication, and failure to test for unusual conditions.
- **Common Vulnerabilities**: Specific vulnerabilities like buffer overflows, SQL injection, cross-site scripting, cross-site request forgery, and click-jacking can be exploited by attackers.
- **Risk of Data Harvesting and Malware**: Applications and websites can be used to harvest credentials, data, or install malware on users' devices.

---
# Procedures and Tools 

### Importance of Application Security
- **Role of Applications**: Applications provide a user-friendly interface for data management but can also be exploited by attackers to compromise sensitive data.
- **Security Risks**: Vulnerabilities in applications, if exploited, can lead to data breaches or system compromise.

### Modern Application Development Challenges
- **Complex Environment**: Applications run on diverse platforms with complex architectures, making security more challenging.
- **Shorter Development Cycles**: Development cycles have become shorter, requiring integrated security measures throughout the process.
- **Regulatory Compliance**: Compliance with data protection regulations adds complexity to application security.

### Development Group Classification
- **Development Group 1**: Relies mainly on off-the-shelf or open-source software, with basic security practices.
- **Development Group 2**: Uses custom web and/or native code applications integrated with third-party components, with a focus on software development best practices.
- **Development Group 3**: Makes a major investment in custom software, with a comprehensive approach to software security.

### Application Security Best Practices
- **Vulnerability Management**: Implement a process integrated into the development life cycle to address vulnerabilities.
- **Secure Coding Practices**: Train developers in secure coding practices and evaluate third-party software for security flaws.
- **Infrastructure Security**: Secure networks, systems, and accounts supporting applications to minimize the attack surface.
- **Threat Modeling**: Identify and address application security design flaws before code creation.
- **Bug Bounty Programs**: Consider implementing bug bounty programs to identify vulnerabilities.
- **NIST SSDF**: Refer to NIST's Secure Software Development Framework for planning and evaluating software security activities.

### Resources for Application Security
- [**SAFECode Application Security Addendum**](https://safecode.org/cis-controls/): Provides in-depth treatment of application software security.
- [**NIST SSDF**](https://csrc.nist.gov/News/2020/mitigating-risk-of-software-vulns-ssdf): Secure Software Development Framework for planning and evaluating software security activities.
- [**The Software Alliance Framework**](https://www.bsa.org/reports/updated-bsa-framework-for-secure-software): Framework for secure software development.
- [**OWASP**](https://owasp.org/): Provides resources and guidelines for web application security.

---
# Safeguards

### 16.1 Establish and Maintain a Secure Application Development Process

- **Objective:** Develop and maintain a secure application development process to ensure the creation of secure software.
- **Implementation:** 
  - Define secure application design standards.
  - Implement secure coding practices.
  - Provide developer training on security best practices.
  - Manage vulnerabilities throughout the development lifecycle.
  - Test applications for security vulnerabilities.

### 16.2 Establish and Maintain a Process to Accept and Address Software Vulnerabilities

- **Objective:** Establish a process to receive and address reports of software vulnerabilities.
- **Implementation:** 
  - Define a vulnerability handling policy.
  - Identify responsible parties for handling vulnerability reports.
  - Implement a process for intake, assignment, remediation, and testing of vulnerabilities.
  - Use a vulnerability tracking system with severity ratings and metrics for measuring response times.

### 16.3 Perform Root Cause Analysis on Security Vulnerabilities

- **Objective:** Identify and address the underlying issues that create security vulnerabilities.
- **Implementation:** 
  - Conduct root cause analysis on vulnerabilities to understand why they occurred.
  - Use the analysis to improve development practices and prevent similar vulnerabilities in the future.

### 16.4 Establish and Manage an Inventory of Third-Party Software Components

- **Objective:** Maintain an inventory of third-party software components used in development.
- **Implementation:** 
  - Create and update a "bill of materials" for third-party components.
  - Include risks associated with each component.
  - Evaluate the inventory regularly to identify changes or updates to components.

### 16.5 Use Up-to-Date and Trusted Third-Party Software Components

- **Objective:** Use secure and reliable third-party software components in application development.
- **Implementation:** 
  - Choose established and proven frameworks and libraries.
  - Acquire components from trusted sources or evaluate them for vulnerabilities.
  - Ensure components are up-to-date and supported.

### 16.6 Establish and Maintain a Severity Rating System and Process for Application Vulnerabilities

- **Objective:** Establish a system for rating the severity of application vulnerabilities and prioritize their resolution.
- **Implementation:** 
  - Develop a severity rating system that categorizes vulnerabilities based on their impact and exploitability.
  - Establish a process for assigning severity ratings to vulnerabilities.
  - Set a minimum security acceptability level for releasing code or applications.
  - Review and update the severity rating system and process annually.

### 16.7 Use Standard Hardening Configuration Templates for Application Infrastructure

- **Objective:** Apply industry-recommended hardening configuration templates to secure application infrastructure components.
- **Implementation:** 
  - Use standard hardening configuration templates for servers, databases, and web servers.
  - Apply these templates to cloud containers, Platform as a Service (PaaS) components, and Software as a Service (SaaS) components.
  - Do not allow in-house developed software to weaken configuration hardening.

### 16.8 Separate Production and Non-Production Systems

- **Objective:** Maintain separate environments for production and non-production systems.
- **Implementation:** 
  - Keep production systems isolated from non-production systems to reduce the risk of accidental changes or unauthorized access.

### 16.9 Train Developers in Application Security Concepts and Secure Coding

- **Objective:** Ensure software development personnel are trained in secure coding practices.
- **Implementation:** 
  - Provide training in writing secure code for specific development environments and responsibilities.
  - Include general security principles and application security standard practices.
  - Conduct training at least annually to promote security within the development team.

### 16.10 Apply Secure Design Principles in Application Architectures

- **Objective:** Incorporate secure design principles into application architectures to reduce vulnerabilities.
- **Implementation:** 
  - Apply least privilege and mediation principles to validate user operations.
  - Never trust user input and perform explicit error checking for all input.
  - Minimize the application infrastructure attack surface by turning off unprotected ports and services, removing unnecessary programs and files, and renaming or removing default accounts.

### 16.11 Leverage Vetted Modules or Services for Application Security Components

- **Objective:** Use trusted modules or services for critical security functions to reduce the risk of errors.
- **Implementation:**
  - Utilize vetted modules or services for identity management, encryption, auditing, and logging.
  - Leverage platform features for security functions to minimize design or implementation errors.
  - Use standardized and reviewed encryption algorithms for data security.
  - Utilize operating system mechanisms for secure audit logs.

### 16.12 Implement Code-Level Security Checks

- **Objective:** Use static and dynamic analysis tools to ensure secure coding practices.
- **Implementation:**
  - Apply static analysis tools to review code for security vulnerabilities.
  - Use dynamic analysis tools to test code during runtime for vulnerabilities.
  - Integrate these checks into the application life cycle to catch security issues early.

### 16.13 Conduct Application Penetration Testing

- **Objective:** Perform penetration testing to identify and mitigate vulnerabilities.
- **Implementation:**
  - Conduct both authenticated and unauthenticated penetration testing.
  - Use skilled testers to manipulate the application as both authenticated and unauthenticated users.
  - Focus on finding business logic vulnerabilities that automated tools might miss.

### 16.14 Conduct Threat Modeling

- **Objective:** Identify and address security design flaws before code development.
- **Implementation:**
  - Train individuals to evaluate application designs for security risks.
  - Conduct threat modeling to map out application, architecture, and infrastructure weaknesses.
  - Use the results to understand and mitigate potential security threats.

