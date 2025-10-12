# Overview

> Actively manage (inventory, track, and correct) all software (operating systems and applications) on the network so that only authorized software is installed and can execute, and that unauthorized and unmanaged software is found and prevented from installation or execution.

> Without a complete inventory of software assets, an enterprise cannot determine if they have vulnerable software, or if there are potential licensing violations.

> An enterprise should review its software inventory to identify any enterprise assets running software that is not needed for business purposes. 

# Safeguards

## 2.1 Establish and Maintain a Software Inventory

> ## Establish and maintain a detailed inventory of all licensed software installed on enterprise assets. The software inventory must document the title, publisher, initial install/use date, and business purpose for each entry; where appropriate, include the Uniform Resource Locator (URL), app store(s), version(s), deployment mechanism, and decommission date. Review and update the software inventory bi-annually, or more frequently.

Here's a step-by-step guide for establishing and maintaining a software inventory as per the CIS control:

1. **Identify All Licensed Software:** Begin by identifying all licensed software installed on enterprise assets. This includes operating systems, applications, utilities, and other software components.

2. **Document Software Details:** Create a detailed inventory for each software entry. Document the following information:
   - Title: Name of the software.
   - Publisher: Company or organization that developed the software.
   - Initial Install/Use Date: Date when the software was first installed or used.
   - Business Purpose: Describe the business purpose or function of the software.
   - URL: Uniform Resource Locator (URL) where the software can be downloaded or accessed.
   - App Store(s): If the software is available on app stores, note the store(s) where it can be found.
   - Version(s): Record the version number(s) of the software.
   - Deployment Mechanism: Describe how the software is deployed (e.g., manual installation, automated deployment).
   - Decommission Date: If known, specify the date when the software will be decommissioned or removed from use.

3. **Review and Update Inventory:** Regularly review and update the software inventory at least bi-annually, or more frequently if necessary. During reviews, ensure that the inventory is accurate and up-to-date with the latest software additions, changes, and removals.

4. **Maintain Documentation:** Keep documentation related to the software inventory in a secure location. This includes any licenses, agreements, or contracts associated with the software.

5. **Automate Inventory Management:** Consider using automated tools or software inventory management systems to streamline the process of maintaining and updating the software inventory.

6. **Audit and Compliance:** Conduct regular audits to verify the accuracy of the software inventory and ensure compliance with organizational policies and licensing agreements.

7. **Incident Response:** Use the software inventory as part of incident response procedures to quickly identify and mitigate security incidents related to software vulnerabilities.

## 2.2 Ensure Authorized Software is currently Supported

> Ensure that only currently supported software is designated as authorized in the software inventory for enterprise assets. If software is unsupported, yet necessary for the fulfillment of the enterprise’s mission, document an exception detailing mitigating controls and residual risk acceptance. For any unsupported software without an exception documentation, designate as unauthorized. Review the software list to verify software support at least monthly, or more frequently.


1. **Identify Supported Software:** Review the software inventory to identify currently supported software. This includes operating systems, applications, utilities, and other software components.

2. **Verify Support Status:** Regularly check the support status of each software entry. Determine if the software is still receiving updates, patches, and vendor support.

3. **Document Unsupported Software:** If any software is found to be unsupported, evaluate its necessity for fulfilling the enterprise's mission. If the software is deemed necessary, document an exception detailing mitigating controls and residual risk acceptance.

4. **Exception Documentation:** For each unsupported software deemed necessary, create an exception document that includes:
   - Description of the unsupported software.
   - Justification for its necessity.
   - Mitigating controls implemented to address security risks.
   - Acceptance of residual risk by appropriate stakeholders.
   - Review and approval signatures.

5. **Designate Unauthorized Software:** Any unsupported software without an exception documentation should be designated as unauthorized in the software inventory.

6. **Regular Review:** Review the software inventory at least monthly, or more frequently if required, to verify the support status of software entries. Update the inventory accordingly based on changes in support status or newly identified unsupported software.

7. **Enforce Compliance:** Enforce policies and procedures to ensure that only supported software is authorized for use on enterprise assets. Monitor compliance with these policies through regular audits and assessments.

8. **Incident Response Planning:** Consider the support status of software when developing incident response plans. Unsupported software may pose higher security risks and require specialized response procedures.



## 2.3 Address Unauthorized Software

> Ensure that unauthorized software is either removed from use on enterprise assets or receives a documented exception. Review monthly, or more frequently.

To ensure that unauthorized software is either removed from use on enterprise assets or receives a documented exception, you can follow these steps along with a template for documenting exceptions:

1. **Identify Unauthorized Software:** Review the software inventory to identify any software that has been designated as unauthorized.

2. **Removal or Exception Documentation:** For each unauthorized software, take one of the following actions:
   - **Removal:** If the software is not necessary for the enterprise's mission or does not have an approved exception, remove it from use on enterprise assets.
   - **Exception Documentation:** If the software is deemed necessary despite being unauthorized, document an exception detailing the justification and mitigating controls.

3. **Exception Documentation Template:** Use the following template to document exceptions for unauthorized software:

   ```
   Exception Request for Unauthorized Software

   Software Title: [Title of Unauthorized Software]
   Justification: [Reason for using unauthorized software and its necessity for the enterprise's mission]
   Mitigating Controls: [Description of controls implemented to mitigate risks associated with unauthorized software]
   Residual Risk Acceptance: [Acknowledgment of residual risks by appropriate stakeholders]
   Requested By: [Name of requester]
   Date: [Date of request]

   Approval:
   - [Name and Signature of Approver]
   - [Date of Approval]

   ```

4. **Review and Update:** Regularly review the software inventory at least monthly, or more frequently if required, to ensure that unauthorized software is either removed or has an approved exception. Update the inventory accordingly based on changes in status.

5. **Enforce Compliance:** Enforce policies and procedures to ensure that unauthorized software is not used on enterprise assets without an approved exception. Monitor compliance through regular audits and assessments.

6. **Incident Response:** Consider the presence of unauthorized software when developing incident response plans. Unauthorized software may introduce additional security risks and require specialized response procedures.

## 2.4 Utilize Automated Software Inventory Tools

Utilize software inventory tools, when possible, throughout the enterprise to automate the discovery and documentation of installed software.

## 2.5 Allow list Authorized Software

Use technical controls, such as application allow listing, to ensure that only authorized software can execute or be accessed. Reassess bi-annually, or more frequently.

### Step-by-Step Guide:

1. **Identify Authorized Applications:** Determine which applications are authorized to run or be accessed on your systems. This should include all necessary software for business operations.

2. **Create the Application Allow List:** Develop a list of authorized applications, including details such as the application name, publisher, version, and any other relevant information.

3. **Configure Technical Controls:** Use technical controls, such as Group Policy, AppLocker, or Windows Defender Application Control, to enforce the allow list. These controls can prevent unauthorized applications from running or being accessed.

4. **Testing and Validation:** Test the allow list to ensure that only authorized applications are allowed to run. Validate that necessary applications are not blocked by the allow list.

5. **Documentation:** Document the application allow list, including the rationale for including each application and any exceptions that may apply.

6. **Reassessment:** Regularly reassess the application allow list at least bi-annually, or more frequently if required, to ensure it remains up-to-date and aligned with organizational needs.

### Application Allow List Template:

You can use the following template to create your application allow list:

```
Application Allow List

Application Name: [Name of the application]
Publisher: [Publisher of the application]
Version: [Version number of the application]
Path: [File path or location of the application executable]
Description: [Brief description of the application's purpose]
Rationale: [Reason for including the application in the allow list]

[Add additional applications as needed]

```

### Example:

```
Application Allow List

Application Name: Microsoft Word
Publisher: Microsoft Corporation
Version: 16.0.14326.20404
Path: C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE
Description: Word processing application
Rationale: Necessary for creating and editing documents for business operations

Application Name: Adobe Photoshop
Publisher: Adobe Inc.
Version: 23.0.2
Path: C:\Program Files\Adobe\Adobe Photoshop 2022\Photoshop.exe
Description: Image editing software
Rationale: Required for graphic design and image editing tasks

[Add additional applications as needed]

```

## 2.6 Allow list Authorized Libraries

Use technical controls to ensure that only authorized software libraries, such as specific .dll, .ocx, .so, etc., files are allowed to load into a system process. Block unauthorized libraries from loading into a system process. Reassess bi-annually, or more frequently.

## 2.7 Allowlist Authorized Scripts

Use technical controls, such as digital signatures and version control, to ensure that only authorized scripts, such as specific .ps1, .py, etc., files are allowed to execute. Block unauthorized scripts from executing. Reassess bi-annually, or more frequently.
