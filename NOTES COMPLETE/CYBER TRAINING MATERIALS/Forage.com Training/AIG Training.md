## What you'll learn

- How to address a vulnerability that may affect Product Development Staging Environment infrastructure
    

## What you'll do

- Review some recent publications from the Cybersecurity & Infrastructure Security Agency (CISA)
    
- Research the reported vulnerability
    
- Draft an email to affected teams to alert them of the vulnerability, and explain how to remediate

# Here is the background information for your task

You are an **Information Security Analyst** in the Cyber & Information Security Team.

A common task and responsibility of information security analysts is to stay on top of emerging vulnerabilities to make sure that the company can remediate them before an attacker can exploit them. 

In this task, you will be asked to review some recent publications from the Cybersecurity & Infrastructure Security Agency (CISA). The Cybersecurity & Infrastructure Security Agency (CISA) is an Agency that has the goal of reducing the nation’s exposure to [cyber](https://www.theforage.com/virtual-experience/2ZFnEGEDKTQMtEv9C/aig/cybersecurity-ku1i/www.google.com) security threats and risks. 

After reviewing the publications, you will then need to draft an email to inform the relevant infrastructure owner at AIG of the seriousness of the vulnerability that has been reported.

# Here are the instructions for your task

The CISA has recently published the following two advisories:

1. The [first advisory (Log4j)](https://www.cisa.gov/uscert/ncas/alerts/aa21-356a), outlines a serious vulnerability in one of the world’s most popular logging software.
2. The [second advisory](https://www.cisa.gov/news/2022/02/09/cisa-fbi-nsa-and-international-partners-issue-advisory-ransomware-trends-2021) explores how ransomware has been increasing and is becoming professionalized - a concern for a large company like AIG.

Your task is to respond to the Apache Log4j zero-day vulnerability that was released to the public by advising affected teams of the vulnerability. 

**First,** conduct your research on the vulnerability using the “CISA Advisory" resources provided above as a starting point.

**Next,** analyze the “Infrastructure List” below to find out which infrastructure may be affected by the vulnerability, and which team has ownership.

|                     |                                         |                                  |                                                                                                                                                        |
| ------------------- | --------------------------------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Product Team**    | **Product Name**                        | **Team Lead**                    | **Services Installed**                                                                                                                                 |
| IT                  | Workstation Management System           | Jane Doe (tech@email.com)        | OpenSSH  <br>dnsmasq  <br>lighttpd                                                                                                                     |
| Product Development | Product Development Staging Environment | John Doe (product@email.com)     | Dovecot pop3d  <br>Apache httpd  <br>Log4j  <br>Dovecot imapd  <br>MiniServ                                                                            |
| Marketing           | Marketing Analytics Server              | Joe Schmoe (marketing@email.com) | Microsoft ftpd  <br>Indy httpd  <br>Microsoft Windows RPC  <br>Microsoft Windows netbios-ssn  <br>Microsoft Windows Server 2008 R2 - 2012 microsoft ds |
| HR                  | Human Resource Information System       | Joe Bloggs (hr@email.com)        | OpenSSH  <br>Apache httpd  <br>rpcbind2-4                                                                                                              |