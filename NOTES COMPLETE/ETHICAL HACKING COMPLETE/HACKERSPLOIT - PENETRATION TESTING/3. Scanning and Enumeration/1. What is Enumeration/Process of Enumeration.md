# Penetration Test Example: Web Application on Internal Network

**Purpose:** Perform a penetration test on a company's internal network targeting a web application.

## Reconnaissance
- Use Google to gather information about the company and its employees.
- Use nslookup to gather information about the domain name and IP address of the web application.

## Scanning
- Use Nmap to scan the internal network for open ports, services, and vulnerabilities.
- Identify that the web application is running on port 80 and other open ports.

## OS Fingerprinting
- Use Nmap to identify the operating system and version running on the internal network.
- Determine that the internal network is running Windows Server 2008.

## Service Identification
- Use Nmap to identify the services running on the internal network.
- Determine that the web application is running on IIS 7.0 and other services such as SMB and RDP.

## Version Detection
- Use Nmap to identify the version of the software running on the internal network.
- Determine that the web application is running on ASP.NET 4.0.

## Vulnerability Identification
- Use Nessus to identify known vulnerabilities in the internal network.
- Determine that the internal network has several vulnerabilities in the web application and the operating system.

## Exploitation
- Attempt to exploit the identified vulnerabilities to gain access to the internal network.

## Post-Exploitation
- After gaining access, perform further enumeration to gather sensitive information, escalate privileges, and maintain access to the internal network.
