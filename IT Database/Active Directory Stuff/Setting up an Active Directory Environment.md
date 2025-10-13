# Setting up an Active Directory Environment

> **Back to:** [[Active Directory Stuff|AD Hub]] | [[📍 INDEX - IT Database|Index]]  
> Tags: #active-directory #setup #lab-environment #windows-server #tutorial

---

## 🎯 Overview

This guide covers how to create a test Active Directory environment for learning and practice. Perfect for IT professionals wanting to build hands-on skills.

**Time Required:** 2-4 hours  
**Difficulty:** Beginner-Intermediate  
**Prerequisites:** Basic Windows knowledge

---

## 📋 What You'll Need

### Hardware/Virtual Machine
- **CPU:** 2 cores minimum
- **RAM:** 4GB minimum (8GB recommended)
- **Storage:** 60GB minimum
- **Network:** Internet connection

### Software
- Windows Server 2016/2019/2022 ISO
- Virtualization software (VMware/VirtualBox/Hyper-V)
- Valid Windows Server license (trial available)

---

## 🔗 Complete Guide

**Official Tutorial:**  
[Create Active Directory Test Environment - Active Directory Pro](https://activedirectorypro.com/create-active-directory-test-environment/)

This comprehensive guide walks you through:
1. Installing Windows Server
2. Configuring network settings
3. Installing Active Directory Domain Services
4. Promoting server to Domain Controller
5. Creating organizational units (OUs)
6. Adding test users and groups
7. Configuring basic group policies

---

## 📚 Step-by-Step Overview

### Phase 1: Server Installation
1. **Create Virtual Machine**
   - Configure VM settings
   - Attach Windows Server ISO
   - Start installation

2. **Install Windows Server**
   - Choose edition (Standard/Datacenter)
   - Complete setup wizard
   - Set administrator password

**Related:** [[Setup Clean Windows Desktop|Clean Installation Guide]]

---

### Phase 2: Network Configuration
1. **Set Static IP Address**
   ```
   Example:
   IP: 192.168.1.10
   Subnet: 255.255.255.0
   Gateway: 192.168.1.1
   DNS: 127.0.0.1 (localhost)
   ```

2. **Configure Computer Name**
   - Use descriptive name (e.g., DC01)
   - Restart server

**Related:** [[Set Cloudflare DNS on Windows|DNS Configuration]]

---

### Phase 3: Active Directory Installation
1. **Add AD DS Role**
   - Open Server Manager
   - Add Roles and Features
   - Select Active Directory Domain Services
   - Install prerequisites

2. **Promote to Domain Controller**
   - Run promotion wizard
   - Choose "Add a new forest"
   - Set domain name (e.g., test.local)
   - Set DSRM password
   - Review and install

3. **Post-Installation Reboot**
   - Server restarts automatically
   - Login with domain\administrator

---

### Phase 4: Initial Configuration
1. **Create Organizational Units (OUs)**
   - Open Active Directory Users and Computers
   - Create structure:
     ```
     Domain.local/
     ├── Users
     ├── Computers
     ├── Groups
     └── Servers
     ```

2. **Create Test Users**
   - Add sample user accounts
   - Assign to appropriate OUs
   - Configure user properties

3. **Create Security Groups**
   - Department groups
   - Role-based groups
   - Administrative groups

**Related:** [[Putting Users on Domain Windows|User Management Guide]]

---

## 🖥️ Testing Your Environment

### Join a Test Computer
1. Configure client DNS to point to DC
2. Join computer to domain
3. Test user login
4. Verify group policy application

**Guide:** [[Putting Users on Domain Windows]]

### Verify AD Services
- Check DNS is working
- Verify replication (if multiple DCs)
- Test user authentication
- Review event logs

---

## 🎓 Learning Exercises

### Beginner Tasks
- [ ] Create 5 user accounts
- [ ] Create 3 security groups
- [ ] Organize users into OUs
- [ ] Join one computer to domain
- [ ] Reset a user password

### Intermediate Tasks
- [ ] Create and apply a group policy
- [ ] Set up a shared folder with permissions
- [ ] Configure password policy
- [ ] Create a login script
- [ ] Set up printer deployment

### Advanced Tasks
- [ ] Configure AD backup
- [ ] Set up Read-Only Domain Controller (RODC)
- [ ] Implement fine-grained password policies
- [ ] Configure AD Certificate Services
- [ ] Set up AD replication monitoring

---

## 🔧 Troubleshooting

### Common Issues

**DNS Not Working**
- Verify DNS is pointing to DC (127.0.0.1 on DC)
- Check DNS service is running
- Verify forward lookup zones

**Cannot Join Domain**
- Check network connectivity
- Verify DNS settings on client
- Ensure firewall allows domain traffic
- Check domain name spelling

**Group Policy Not Applying**
- Run `gpupdate /force` on client
- Check group policy inheritance
- Verify user/computer in correct OU
- Review event logs

---

## 🛠️ Essential Commands

### PowerShell Commands
```powershell
# Check AD installation
Get-ADDomain

# List all users
Get-ADUser -Filter *

# Create new user
New-ADUser -Name "John Doe" -SamAccountName "jdoe"

# Add user to group
Add-ADGroupMember -Identity "GroupName" -Members "jdoe"

# Force group policy update
Invoke-GPUpdate -Force

# Check domain controller health
Get-ADDomainController -Discover
```

### Command Prompt Commands
```cmd
# Join computer to domain
netdom join %computername% /domain:yourdomain.local /userd:administrator /passwordd:*

# Test domain connectivity
nltest /dsgetdc:yourdomain.local

# Force group policy update
gpupdate /force

# Check replication status
repadmin /replsummary
```

---

## 💡 Best Practices

### Security
- Use strong DSRM password
- Don't use .com or real domain names
- Implement proper OU structure from start
- Regular backups of AD
- Document all configurations

### Performance
- Adequate RAM for domain controller
- Fast storage (SSD recommended)
- Proper DNS configuration
- Regular maintenance

### Organization
- Plan OU structure before creating
- Use descriptive names
- Document naming conventions
- Keep test environment separate from production

---

## 🔗 Related Resources

### Active Directory Topics
- [[Active Directory Stuff|AD Main Hub]]
- [[Windows Server 2016 - Active Directory Build|Production Build]]
- [[Putting Users on Domain Windows|User Management]]

### Windows Guides
- [[WINDOWS Tutorials|All Windows Tutorials]]
- [[Setup Clean Windows Desktop|Desktop Setup]]
- [[Set Cloudflare DNS on Windows|DNS Configuration]]

### Projects & Learning
- [[IT PROJECTS|View Projects]]
- [[COURSES & TRAINING|Training Resources]]
- [[How to study effectively|Study Methods]]

---

## 📍 Next Steps

After completing this setup:
1. ✅ Practice user management with [[Putting Users on Domain Windows]]
2. ✅ Build production environment with [[Windows Server 2016 - Active Directory Build]]
3. ✅ Learn advanced topics through [[COURSES & TRAINING]]
4. ✅ Explore [[IT PROJECTS|other IT projects]]

---

## 🌐 External Resources

**Tutorials:**
- [Active Directory Pro - Complete Guide](https://activedirectorypro.com/create-active-directory-test-environment/)
- Microsoft Learn - Active Directory
- Windows Server Documentation

**Tools:**
- Active Directory Users and Computers
- Group Policy Management Console
- DNS Manager
- Event Viewer

**Community:**
- [[Useful IT Websites|More Resources]]
- Microsoft Tech Community
- Active Directory forums

---

**Status:** 🧪 Lab Setup Guide  
**Time Required:** 2-4 hours  
**Difficulty:** ⭐⭐⭐ (Intermediate)  
**Last Updated:** {{date}}