
# Overview

Establish and maintain the secure configuration of enterprise assets (end-user devices, including portable and mobile; network devices; non-computing/IoT devices; and servers) and software (operating systems and applications).

# Why it is important

Default configurations for enterprise assets and software are often focused on ease-of-deployment and ease-of-use rather than security. These default settings, such as open services and ports, default accounts or passwords, and unnecessary software, can be exploitable if left unchanged. It is crucial to manage and maintain security configuration updates over the life cycle of assets and software. Configuration updates should be tracked and approved through a configuration management workflow to maintain compliance, support incident response, and facilitate audits. This applies to on-premises, remote devices, network devices, and cloud environments.

Service providers in modern infrastructures may not be configured in the most secure way by default, allowing for flexibility for customers to apply their own security policies. Enterprises using such services are responsible for managing default accounts or passwords, excessive access, and unnecessary services. Even after an initial strong configuration, ongoing management is necessary to avoid security degradation due to software updates, new vulnerabilities, and changing operational requirements.

# Procedures and tools

## Useful Resource

The CIS Benchmarks™ Program – http://www.cisecurity.org/cis-benchmarks/

The National Institute of Standards and Technology (NIST®) National Checklist Program Repository – https://nvd.nist.gov/ncp/repository
## Creating a Baseline Image

1. Determine the risk classification of the data handled/stored on the enterprise asset (e.g., high, moderate, low risk).
2. Create a security configuration script that sets system security settings to meet the requirements to protect the data used on the enterprise asset. Use benchmarks, such as the ones described earlier in this section.
3. Install the base operating system software.
4. Apply appropriate operating system and security patches.
5. Install appropriate application software packages, tool, and utilities.
6. Apply appropriate updates to software installed in Step 4.
7. Install local customization scripts to this image.
8. Run the security script created in Step 2 to set the appropriate security level.
9. Run a SCAP compliant tool to record/score the system setting of the baseline image.
10. Perform a security quality assurance test.
11. Save this base image in a secure location.

## Testing Configurations against CIS Benchmarks

[CIS Configuration Assessment Tool (CIS-CAT®)](https://learn.cisecurity.org/cis-cat-lite)

It can be used to measure the settings of operating systems and applications of managed machines to look for deviations from the standard image configurations



# Safeguards

## 4.1 Establish and Maintain a Secure Configuration Process

## 4.2 Establish and Maintain a Secure Configuration Process for Network Infrastructure

## 4.3 Configure Automatic Session Locking on Enterprise Assets

## 4.4 Implement and Manage a Firewall on Servers

## 4.5 Implement and Manage a Firewall on End-User Devices

## 4.6 Securely Manage Enterprise Assets and Software

## 4.7 Manage Default Accounts on Enterprise Assets and Software

## 4.8 Uninstall or Disable Unnecessary Services on Enterprise Assets and Software

## 4.9 Configure Trusted DNS Servers on Enterprise Assets

## 4.10 Enforce Automatic Device Lockout on Portable End-User Devices

## 4.11 Enforce Remote Wipe Capability on Portable End User Devices

## 4.12 Separate Enterprise Workspace on Mobile End-User Devices

