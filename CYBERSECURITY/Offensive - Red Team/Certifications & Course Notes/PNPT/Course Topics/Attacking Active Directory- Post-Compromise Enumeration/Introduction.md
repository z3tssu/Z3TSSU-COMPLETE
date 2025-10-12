# Post-Compromise Enumeration: Tools and Overview

## Initial Context

- Successfully compromised a user account, "Frank Castle," during the **Initial Attack Vectors** section:
    - Captured Frank Castle's hash with **Responder**:
        - Found the password: `password1`.
    - Used **SMB Relay** to access machines without directly capturing a hash:
        - Dumped the **SAM file** to collect hashes.
    - Created an account using **MITM6**, gaining full domain control.

## Goals of Post-Compromise Enumeration

- Leverage existing compromises to:
    - Enumerate network details.
    - Gather further intelligence for privilege escalation and domain dominance.

## Tools for Post-Compromise Enumeration

1. **PowerView**:
    - A powerful tool for deep domain enumeration.
    - Capabilities:
        - Enumerates:
            - Domain Controller.
            - Domain Policies.
            - Domain Users.
            - Groups.
        - Provides comprehensive visibility into network entities and configurations.
    - Significance:
        - Essential for assessing internal infrastructure.
        - Key in identifying escalation opportunities.
2. **BloodHound**:
    - A visualization tool for domain graphing.
    - Features:
        - Maps relationships and paths within the domain.
        - Identifies:
            - Sensitive users currently logged in.
            - Shortest paths to escalate privileges or gain domain admin.
    - Benefits:
        - Ideal for pinpointing high-value targets.
        - Adds a professional touch to internal assessments.

## Strategic Importance

- Mastery of **PowerView** and **BloodHound**:
    - Essential for post-compromise analysis.
    - Demonstrates expertise during interviews and assessments.
- Recommendations:
    - Incorporate **BloodHound** in every internal assessment.
    - Familiarize yourself with both tools for practical application and discussions.

## Next Steps

1. Explore **PowerView**:
    - Installation and usage.
2. Move to **BloodHound**:
    - Setup and graphing techniques.
3. Transition to post-compromise attacks:
    - Utilize gathered intelligence for privilege escalation and domain control.

---

## Additional Notes

- These tools form the backbone of post-compromise enumeration and attack planning.
- Understanding their capabilities will enhance both assessment quality and professional competency.