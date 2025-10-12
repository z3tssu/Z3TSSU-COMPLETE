# Overview 

Test the effectiveness and resiliency of enterprise assets through identifying
and exploiting weaknesses in controls (people, processes, and technology), and
simulating the objectives and actions of an attacker.

# Why is this Control critical

### Comprehensive Defensive Posture:
- **Components**: Effective policies, governance, strong technical defenses, and appropriate action from people.
- **Imperfection**: Acknowledge that perfection is rare due to evolving technology and attacker tradecraft.

### Periodic Testing of Controls:
- **Purpose**: Identify gaps and assess resiliency.
- **Scope**: May include external network, internal network, application, system, or device perspective.
- **Methods**: Could involve social engineering of users or bypassing physical access controls.

### Penetration Testing:
- **Purposes**:
  - Dramatic demonstration of attack to decision-makers.
  - Verification of correct operation of defenses.
  - Validation of built defenses.
- **Value**: Provides valuable and objective insights into vulnerabilities in enterprise assets and humans, as well as the efficacy of defenses and mitigating controls.
- **Part of Comprehensive Security Program**: Integral to ongoing security management and improvement, highlighting process weaknesses.

### Penetration Testing vs. Vulnerability Testing:
- **Difference**:
  - Vulnerability testing checks for presence of known, insecure assets.
  - Penetration testing exploits weaknesses to assess potential impact on business processes or data.
- **Automation vs. Human Involvement**:
  - Vulnerability testing is mostly automated scanning with some manual validation.
  - Penetration testing requires more human involvement and analysis, sometimes using custom tools or scripts.

### Red Team Exercises:
- **Focus**: Simulate specific attacker Tactics, Techniques, and Procedures (TTPs) to evaluate an enterprise's environment's resilience against certain attacks.
- **Difference from Penetration Testing**: Focuses on specific adversary or category of adversaries, assessing how the environment would withstand such attacks.

# Procedures and Tools

### Penetration Testing Process:

1. **Reconnaissance**: Gather information about the enterprise and its environment.
2. **Scanning**: Identify vulnerabilities that can be used as entry points.
3. **Asset Discovery**: Ensure all in-scope assets are discovered, not relying on outdated or incomplete lists.
4. **Vulnerability Identification**: Identify vulnerabilities in the targets.
5. **Exploitation**: Execute exploits to demonstrate how an adversary can subvert security goals or achieve specific objectives.
6. **Insight and Risk Demonstration**: Provide deeper insight into business risks associated with vulnerabilities, including physical, network, system, or application layers, often involving social engineering.

### Considerations for Penetration Testing:
- **Expense and Complexity**: Penetration tests are costly and complex.
- **Risks**: Include unexpected system shutdowns, data or configuration deletion/corruption, and protection of the testing report itself.
- **Experienced Testers**: Tests must be conducted by experienced personnel from reputable vendors.

### Scope and Rules of Engagement:
- **Scope**: Define a clear scope, including high-value assets and production processing functionality.
- **Rules of Engagement**: Describe testing times, duration, and approach. Only a few people should know about the test, with a designated point of contact for issues.

### Protection of Testing Reports:
- **Legal Counsel Involvement**: Increasingly, tests are conducted through third-party legal counsel to protect the report from disclosure.

### Recommended Resources:
- **OWASP Penetration Testing Methodologies**: [Link](https://www.owasp.org/index.php/Penetration_testing_methodologies)
- **PCI Security Standards Council Penetration Testing Guidance**: [Link](https://www.pcisecuritystandards.org/documents/Penetration-Testing-Guidance-v1_1.pdf)

### Conclusion:
- CIS Control provides specific steps to improve security and should be part of any penetration testing.
- Recommended resources offer support for security test planning, management, and reporting.

# Safeguards

### 18.1 Establish and Maintain a Penetration Testing Program

- **Objective:** Establish and maintain a penetration testing program suitable for the enterprise's size, complexity, and maturity.
- **Implementation:**
  - Define the scope of the program, including network, web application, API, hosted services, and physical premise controls.
  - Determine the frequency of testing based on program requirements.
  - Establish limitations such as acceptable testing hours and excluded attack types.
  - Provide point of contact information for reporting findings.
  - Define the remediation process for addressing findings internally.
  - Establish retrospective requirements for reviewing and updating the program.

### 18.2 Perform Periodic External Penetration Tests

- **Objective:** Conduct periodic external penetration tests at least annually to detect exploitable information.
- **Implementation:**
  - Conduct enterprise and environmental reconnaissance as part of the testing.
  - Use qualified parties with specialized skills and experience for testing.
  - Perform testing using clear box (white box) or opaque box (black box) approaches.

### 18.3 Remediate Penetration Test Findings

- **Objective:** Remediate penetration test findings based on the enterprise's policy for scope and prioritization.
- **Implementation:**
  - Address identified vulnerabilities promptly according to the severity and impact on the enterprise's security posture.
  - Follow established procedures for remediating findings.

### 18.4 Validate Security Measures

- **Objective:** Validate security measures after each penetration test and adjust rulesets and capabilities as needed.
- **Implementation:**
  - Verify that security measures effectively mitigate the techniques used during testing.
  - Modify security configurations if necessary to enhance security posture based on test results.

### 18.5 Perform Periodic Internal Penetration Tests

- **Objective:** Conduct periodic internal penetration tests, at least annually, to identify vulnerabilities within the internal network.
- **Implementation:**
  - Follow program requirements for internal penetration testing.
  - Use clear box (white box) or opaque box (black box) testing approaches as appropriate.

