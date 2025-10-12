# Policies, Standards, Procedures and Guidelines

## Define Policies

> A security policy is the first level of formalized documentation for your organization's security program and is mandatory.

- **==Examples of Policies==** #policies #policy 
	- Acceptable use policy
	- Change management policy
	- Disaster recovery policy
	- Privacy policy
	- Information security program policy
## Setting Standards

> Standards follow policies as they define the specifics of each policy and are mandatory.

- **Examples of Standards** 
		![[Pasted image 20240215211943.png]]

## Creating Procedures

> Procedures are the step-by-step instructions used to accomplish a repeatable task or process.

- Useful tool for creating and managing procedures
	- [Nintex Promapp](https://www.promapp.com/)
- Example of a procedure 
	- Deploy a new device with Windows 10
	- Ensure the device is connected to the internet 
	- Validate the device configurations, that applications have been installed, and so on
	- Check that the device is compliant

## Recommending Guidelines

> Guidelines provide useful advice and best practices, but are not mandatory. 

- Ideas to help communicate your guidelines
	- Build a theme around your guideline communications—for example, smart tech guidelines.
	- Insert a section of the guidelines in the company newsletters and/or communications.
	- Link your guidelines back to a central repository for users to come back to and access.
	- Keep your guidelines short and to-the-point.
	- Make your guidelines relevant to both professional and personal usage.

# Incorporating Change Management

> Step by step process for implementing and performing changes

![[Pasted image 20240215213100.png]]

- Framework to help with change management 
	- [Information Technology Infrastructure Library (ITIL)](https://www.axelos.com/best-practice-solutions/itil/what-is-itil)
# Implementing a Security Framework

> An information security framework is designed to build a well-defined basis for your organization's security program. . It will help cover the foundation of everything you need to be aware of within your security program and help to identify any gaps within the organization.

- Most Common Frameworks
	- [Control Objectives for Information and Related Technology (COBIT)](http://www.isaca.org/cobit/pages/default.aspx)
	- [International Standards Organization (ISO 27000 Family)](https://www.iso.org/isoiec-27001-information-security.html)
	- [National Institute of Standards and Technology (NIST)](https://www.nist.gov/cyberframework)
	- [NIST SP 800-53. Security and Privacy Controls for Federal Information Systems](https://csrc.nist.gov/publications/detail/sp/800-53/rev-4/final)
	- [HITRUST](https://hitrustalliance.net/hitrust-csf/) 

# Building baseline controls

## CIS - Center for Internet Security (CIS)

- [CIS Controls](https://www.cisecurity.org/)
## Windows Security Baselines

- Microsoft tools to implement baselines
	- Microsoft Intune
	- GPOs
	- Microsoft Endpoint or System Center Configuration Manager
- [Additional information on Windows Security Baselines](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)

# Implementing a Baseline

1. Center for Information Security Method
	- Go to https://www.cisecurity.org/
	- Click on Cybersecurity Tools
	- Click on Download under CIS Benchmarks
	- Enter the required information
	- Check your email
	- Open your email and click on "Access PDFs" you will then be provided with a list of available CIS benchmarks in PDF format
	- Scroll down until your desired benchmark
	- Once you have downloaded them, follow and implement the recommendations on them to strengthen your systems
1. Microsoft Security Compliance Toolkit (SCT)
	- Go to [here](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-compliance-toolkit-10)
	- Scroll down and click on download the tools
	- Click Download
	- Select desired options
	- Click next. You will receive all the toolkits in .zip format

# Incorporating best practices

To finish off this chapter, we wanted to provide a checklist of the most important items
that will help enforce your security baselines. The following list is ranked in order of
importance as you look to build and enforce your baselines:

1. Select and deploy a framework to build a foundation.
2. Select a baseline foundation. We covered CIS and Windows security baselines in this chapter.
3. For your Windows devices, use the policy analyzer from the Microsoft SCT to review your baselines. #policies #policy 
4. Create or use a Golden Image template for each use case that you can reuse and always keep up to date with the latest updates.
5. Build well-documented and easy-to-follow procedures that others can use and follow.
6. Use the automation of controls and tools to re-enforce the baseline—for example, MDM with Intune or Active Directory Group Policy.
7. Use compliance policies to validate whether controls are in place. This will also help with auditing devices that are non-compliant.
8. Implement a quarantine or risk access policy with non-compliant devices.
9. Implement efficient monitoring and reporting for device compliance. Power BI is a great way to visually provide reports.
10. Always keep up to date with both the Windows versions and the technology used to manage the devices. The modern world is very dynamic and moves at an extremely fast pace.




