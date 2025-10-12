# BloodHound Analysis: Using Collected Data

## Preparing for Data Analysis

1. **Open BloodHound**:
    - Start BloodHound on your Kali Linux machine.
    - Ensure data has been successfully transferred and accessible in your BloodHound environment.
2. **Upload Collected Data**:
    - [https://www.youtube.com/watch?v=RhdhLwZHZmU](https://www.youtube.com/watch?v=RhdhLwZHZmU)
        - The following video explains well how to import the data on the new Bloodhound community edition.

---

## Analyzing Data in BloodHound

1. **Initial Insights**:
    - Access the data summary using the hamburger menu.
    - Example statistics:
        - Users: 9
        - Computers: 3
        - Groups: 52
        - Sessions: 3
        - Access Control Lists (ACLs): 512
        - Relationships: 592
    - These values may vary depending on the domain environment.
2. **Querying the Database**:
    - Use **pre-built queries** to identify key targets and paths:
        - **Find all domain admins**:
            - Lists all Domain Admin accounts (e.g., `Administrators`, `tstar`, `SQLService`).
        - **Find shortest path to Domain Admin**:
            - Analyzes relationships and shows the quickest path to Domain Admin access.
            - Example:
                - Administrator session on a machine.
                - Target boxes where domain admins are logged in for token impersonation.

---

## Key Pre-Built Queries

1. **Domain Trust**:
    - Check for inter-domain trust relationships.
    - Useful in multi-domain environments (may return nothing in simple domains).
2. **Unconstrained Delegation**:
    - Identify targets vulnerable to delegation-based attacks.
3. **Kerberoasting**:
    - Find Kerberos service accounts (e.g., `SQLService` part of Domain Admins).
    - Prepare for targeted attacks like Kerberoasting (covered in later sections).
4. **High Value Targets (HVTs)**:
    - Identify high-value accounts and access points.
    - Example:
        - Administrator account connects to:
            - Frank Castle -> Punisher (session) -> Domain Admins -> Enterprise Admins.

---

## Importance of BloodHound in Enumeration

- **Quick Visualization**: Understand relationships and privileges graphically.
- **Critical Assessments**:
    - Target accounts and systems for efficient escalation.
    - Find "low-hanging fruit" vulnerabilities or paths.
- **Support Timed Assessments**: Prioritize next actions effectively.

---

## Practical Usage and Recommendations

1. **Timely Data Collection**:
    - Run BloodHound after any significant compromise or enumeration.
    - Helps decide next moves when options are unclear.
2. **Advanced Features**:
    - Write and use **custom queries** to tailor analysis.
    - For most assessments, pre-built queries provide sufficient insight.
3. **Continuous Learning**:
    - Explore the advanced functionality of BloodHound beyond pre-built queries.

---

## Enumeration Process Overview

- Enumeration occurs before and after gaining access.
- Each new machine or account may reveal additional details:
    - Logged-in users.
    - Files containing passwords or sensitive data.
    - Administrator sessions available for impersonation.
- Consistently reevaluate network information to uncover new paths and targets.

---

## Value for Penetration Testing Interviews

- Using BloodHound enhances your skills and confidence in enumeration.
- Showcase specific abilities during interviews:
    - Discuss identifying Domain Admin paths or high-value targets.
    - Explain leveraging PowerView and BloodHound together.
- These insights set you apart from other candidates.

---

## Next Steps

- Proceed to **Post Exploitation Attacks**:
    - Leverage compromised accounts for additional access.
    - Transition from initial enumeration to network domination.

---

Would you like these notes saved as a `.txt` file for your reference?