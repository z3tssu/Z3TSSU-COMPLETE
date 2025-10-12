# [Inveigh](https://github.com/Kevin-Robertson/Inveigh) - Overview

If we end up with a Windows host as our attack box, our client provides us with a Windows box to test from, or we land on a Windows host as a local admin via another attack method and would like to look to further our access, the tool Inveigh works similar to Responder, but is written in PowerShell and C#. Inveigh can listen to IPv4 and IPv6 and several other protocols, including LLMNR, DNS, mDNS, NBNS, DHCPv6, ICMPv6, HTTP, HTTPS, SMB, LDAP, WebDAV, and Proxy Auth. The tool is available in the C:\Tools directory on the provided Windows attack host.

## Using Inveigh (Powershell)

```Shell
PS C:\htb> Import-Module .\Inveigh.ps1
PS C:\htb> (Get-Command Invoke-Inveigh).Parameters

Key                     Value
---                     -----
ADIDNSHostsIgnore       System.Management.Automation.ParameterMetadata
KerberosHostHeader      System.Management.Automation.ParameterMetadata
ProxyIgnore             System.Management.Automation.ParameterMetadata
PcapTCP                 System.Management.Automation.ParameterMetadata
PcapUDP                 System.Management.Automation.ParameterMetadata
SpooferHostsReply       System.Management.Automation.ParameterMetadata
SpooferHostsIgnore      System.Management.Automation.ParameterMetadata
SpooferIPsReply         System.Management.Automation.ParameterMetadata
SpooferIPsIgnore        System.Management.Automation.ParameterMetadata
WPADDirectHosts         System.Management.Automation.ParameterMetadata
WPADAuthIgnore          System.Management.Automation.ParameterMetadata
ConsoleQueueLimit       System.Management.Automation.ParameterMetadata
ConsoleStatus           System.Management.Automation.ParameterMetadata
ADIDNSThreshold         System.Management.Automation.ParameterMetadata
ADIDNSTTL               System.Management.Automation.ParameterMetadata
DNSTTL                  System.Management.Automation.ParameterMetadata
HTTPPort                System.Management.Automation.ParameterMetadata
HTTPSPort               System.Management.Automation.ParameterMetadata
KerberosCount           System.Management.Automation.ParameterMetadata
LLMNRTTL                System.Management.Automation.ParameterMetadata

<SNIP>
```

Let's start Inveigh with LLMNR and NBNS spoofing, and output to the console and write to a file. We will leave the rest of the defaults, which can be seen here.

```Shell
PS C:\htb> Invoke-Inveigh Y -NBNS Y -ConsoleOutput Y -FileOutput Y
```

---

# C# Inveigh (InveighZero)

> [!important] The PowerShell version of Inveigh is the original version and is no longer updated. The tool author maintains the C# version

## Running Inveigh C#

- Need to compile the code in Visual Studio

```Shell
.\Inveigh.exe
```

- ==Press ESC to enter/exit interactive console==, which is very useful while running the tool. The console gives us access to captured credentials/hashes, allows us to stop Inveigh, and more.

![[Notion/CPTS/RESOURCES/image 15.png|image 15.png]]

- Type ==HELP== to access more options

![[Notion/CPTS/RESOURCES/image 1 9.png|image 1 9.png]]

### View unique captured hashes

- Type: ==GET NTLMV2UNIQUE==

![[Notion/CPTS/RESOURCES/image 2 7.png|image 2 7.png]]

### GET NTLMV2USERNAMES

- see which usernames we have collected. This is helpful if we want a listing of users to perform additional enumeration against and see which are worth attempting to crack offline using Hashcat.

![[Notion/CPTS/RESOURCES/image 3 5.png|image 3 5.png]]

---

# Remediation of LLMNR/NBT-NS Poisoning

- MITRE ATT & CK list this attack as [ID: T1557.001](https://attack.mitre.org/techniques/T1557/001), Adversary-in-the-Middle: LLMNR/NBT-NS Poisoning and SMB Relay

  

## Remediation 1: ==Disable LLMNR== in Group Policy

1. Go to GP, then Computer Configuration --> Administrative Templates --> Network --> DNS Client and enabling "Turn OFF Multicast Name Resolution.”

![[Notion/CPTS/RESOURCES/image 4 4.png|image 4 4.png]]

==NBT-NS cannot be disabled via Group Policy==

## Disabled ==NBT-NS== locally on each host.

1. We can do this by opening Network and Sharing Center under Control Panel,
2. clicking on Change adapter settings,
3. right-clicking on the adapter to view its properties,
4. selecting Internet Protocol Version 4 (TCP/IPv4)
5. Clicking the Properties button, then clicking on Advanced and selecting the WINS tab and finally selecting Disable NetBIOS over TCP/IP.

![[Notion/CPTS/RESOURCES/image 5 4.png|image 5 4.png]]

## Disable NBT-NS through a GPO Script

While it is not possible to disable NBT-NS directly via GPO, we can create a PowerShell script under Computer Configuration --> Windows Settings --> Script (Startup/Shutdown) --> Startup with something like the following:

```Shell

$regkey = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
Get-ChildItem $regkey |foreach { Set-ItemProperty -Path "$regkey\$($_.pschildname)" -Name NetbiosOptions -Value 2 -Verbose}
```

In the Local Group Policy Editor, we will need to double click on Startup, choose the PowerShell Scripts tab, and select "For this GPO, run scripts in the following order" to Run Windows PowerShell scripts first, and then click on Add and choose the script. For these changes to occur, we would have to either reboot the target system or restart the network adapter.

![[Notion/CPTS/RESOURCES/image 6 3.png|image 6 3.png]]

## Push the script to all hosts in a Domain

1. Create a GPO using ==Group Policy Management== on the Domain Controller and host the script on the SYSVOL share in the scripts folder and then call it via its UNC path such as:

==\\inlanefreight.local\SYSVOL\INLANEFREIGHT.LOCAL\scripts==

1. Once the GPO is applied to specific OUs and those hosts are restarted, the script will run at the next reboot and disable NBT-NS, provided that the script still exists on the SYSVOL share and is accessible by the host over the network.

![[Notion/CPTS/RESOURCES/image 7 3.png|image 7 3.png]]

## Detection

It is not always possible to disable LLMNR and NetBIOS, and therefore we need ways to detect this type of attack behavior. One way is to use the attack against the attackers by injecting LLMNR and NBT-NS requests for non-existent hosts across different subnets and alerting if any of the responses receive answers which would be indicative of an attacker spoofing name resolution responses. ==[This blog post](https://www.praetorian.com/blog/a-simple-and-effective-way-to-detect-broadcast-name-resolution-poisoning-bnrp/)== explains this method more in-depth.

Furthermore, hosts can be monitored for traffic on ports UDP 5355 and 137, and event IDs 4697 and 7045 can be monitored for. Finally, we can monitor the registry key ==HKLM\Software\Policies\Microsoft\Windows NT\DNSClient== for changes to the EnableMulticast DWORD value. A value of 0 would mean that LLMNR is disabled.

  

# Moving On

## Post-Hash Capture Actions

### 1. **Hash Evaluation and Enumeration**

- After capturing account hashes, the next logical step is to evaluate their usefulness.
- Use **BloodHound** for enumeration:
    - Identify if any of the hashed accounts have **privileged access** (e.g., Admin rights, lateral movement potential).
    - Determine paths to escalate privileges within the domain.

### 2. **Hash Cracking Goals**

- Attempt to **crack the captured hashes**:
    - If successful, assess the **level of access** the cracked credentials provide.
    - **Best-case scenario:** Crack a **Domain Admin** account hash.

### 3. **Alternate Plan if Cracking Fails**

- If cracking is unsuccessful or yields **non-privileged accounts**:
    - Move on to **password spraying attacks** (to be covered in upcoming steps).
    - Password spraying might provide valid **cleartext credentials** for accounts with higher privileges.

---