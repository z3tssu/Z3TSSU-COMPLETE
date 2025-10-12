---
title: Pass the ticket w/ Mimikatz
updated: 2023-04-01T22:17:43.0000000+04:00
created: 2023-04-01T22:14:06.0000000+04:00
---

PM
Now that we have our ticket ready we can now perform a pass the ticket attack to gain domain admin privileges.

1.) kerberos::ptt \<ticket\>

- \- run this command inside of mimikatz with the ticket that you harvested from earlier. It will cache and impersonate the given ticket

![image1](image1-146.png)

2.) klist - Here were just verifying that we successfully impersonated the ticket by listing our cached tickets.

We will not be using mimikatz for the rest of the attack.

![image2](image2-73.png)

3.) You now have impersonated the ticket giving you the same rights as the TGT you're impersonating. To verify this we can look at the admin share.

![image3](image3-48.png)

Note that this is only a POC to understand how to pass the ticket and gain domain admin the way that you approach passing the ticket may be different based on what kind of engagement you're in so do not take this as a definitive guide of how to run this attack.

