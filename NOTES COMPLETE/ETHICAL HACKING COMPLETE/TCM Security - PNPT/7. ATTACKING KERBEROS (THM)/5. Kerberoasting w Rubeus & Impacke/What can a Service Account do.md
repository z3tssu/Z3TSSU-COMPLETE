---
title: What can a Service Account do?
updated: 2023-04-01T21:27:19.0000000+04:00
created: 2023-04-01T21:26:54.0000000+04:00
---

What can a Service Account do?
Saturday, April 1, 2023
9:26 PM

1.  After cracking a service account password, there are different ways to collect data or loot depending on whether the service account is a domain admin or not.
2.  If the service account is a domain admin, you have control similar to that of a golden/silver ticket and can gather loot such as dumping the NTDS.dit.
3.  If the service account is not a domain admin, you can use it to log into other systems and pivot or escalate. Alternatively, you can use the cracked password to spray against other service and domain admin accounts.
4.  Many companies may reuse the same or similar passwords for their service or domain admin users.
5.  In a professional pen test, it's important to be aware of how the company wants you to show risk. Often, they don't want you to exfiltrate data and will set a goal or process for you to follow to show risk within the assessment.

