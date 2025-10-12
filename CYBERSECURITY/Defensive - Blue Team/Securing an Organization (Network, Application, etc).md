Useful Reddit Resource:

[https://www.reddit.com/r/cybersecurity/comments/15e14ha/how_to_improve_an_organizations_application_and/](https://www.reddit.com/r/cybersecurity/comments/15e14ha/how_to_improve_an_organizations_application_and/)

> [!important] Brain dump.
> 
> Make sure you have a good inventory of all devices that you manage. You can do this with an RMM tool or Intune.
> 
> Get inventory on all services/apps that run and make sure you know if they should be publicly accessible or not.
> 
> Move publicly accessible servers into a DMZ or at least into a network that would not threaten your intranet if it were compromised.
> 
> Set up a hardened baseline on every machine. You can deploy either through Intune or group policy. See CIS And STIG for good baselines. Baselines for servers, user endpoints, and software configs.
> 
> Look into implementing ransomware protection using something like controlled folder access.
> 
> Integrate ublock origin into the browser used by all users. You can do this in gp or intune or rmm.
> 
> Remove admin privileges from all user devices. Set up LAPS in case local admin is needed temporarily on a device.
> 
> Push out a baseline windows firewall configuration that blocks all incoming except for what you use in your network. Just about everything can be blocked now unless you do SNMP or something else for network configuration. Most things can fall back to using just a cloud connection, and blocking everything can help reduce the surface area.
> 
> For web apps, you can run various scans against them. If you have code level access, you could run some code analysis to see if it can auto detect some common faulty pattern in the code. Look for unparametetized queries, etc. Nessus/Tenable can do some of this. Owasp has a scanner as well. There's quite a few open source ones out there.
> 
> You should track your vulnerabilities and have a remediation schedule where your policy is to remediate in x number of days. You need persons responsible for the remediation if its not yourself.
> 
> I would set up periodic network scanning on the network to inventory all ports that are open on machines. Document the ports and their use. Investigate anything unusual. Easy to script something in Nmap or use a Tenable scanner job or whatever vendor you go with.
> 
> Definitely need to make sure you have backups of all of your servers data. The backups should be immutable, preferably. Otherwise, make sure they are well protected and you have a local and a cloud version. You should scan your backup servers as well and also restrict access to them. They are your fallback. In addition, make sure you test the backups to ensure they work and you can actually restore from them. Make sure you backup encryption keys for the servers if they are encrypted or if using hyperv, they may require a hiatus guardian key backup or you won't be able to restore.
> 
> Setup a user security training program. Check Infosechq or some other service and require users to complete the training before they receive access. Require completion during onboardinf and annually.
> 
> Perform social engineering tests against users. You can usually do this within the tool you use to handle training. This will help you gage which users need more security awareness training.
> 
> Do a security newsletter every month or adhocly that talks about the most recent threats and how users can avoid them. People will appreciate this advice if it's written well.
> 
> Printers on the network should probably be migrated to universal print which allows you to authenticate print jobs before printing. Usually you probably have other problems if someone is looking at previous print jobs for data., though.
> 
> Check all servers and network switches and firewalls for firmware updates and install them on a regular basis. Scanners often won't show these in findings.
> 
> Disable RDP or ssh access to devices on the network and require accessing the server through rmm tunnel or VPN. Or make sure you have your server and network gear on their own managment network. Whatever solution you choose, try to make sure it uses MFA before granting access.
> 
> Make sure wifi has a guest network and secure network. Block access to servers from guest network.
> 
> Set recurring controls where you go in and assessed that your security procedures are being followed. Ie: user access is disabled when they leave the company. Firewall settings are still modern. Refer to CIS And other frameworks for commonly used controls.
> 
> Schedule a pentester to come in after implementing these things and have them (in)validate it all.

# Breakdown

1. Good inventory of Devices
    1. Use RMM Tool or Intune