---
title: Prepare Mimikatz & Dump Tickets
updated: 2023-04-01T22:13:41.0000000+04:00
created: 2023-04-01T22:08:32.0000000+04:00
---

PM
You will need to run the command prompt as an administrator: use the same credentials as you did to get into the machine. If you don't have an elevated command prompt mimikatz will not work properly.

1.) cd Downloads - navigate to the directory mimikatz is in

2.) mimikatz.exe - run mimikatz

3.) privilege::debug

\- Ensure this outputs \[output '20' OK\] if it does not that means you do not have the administrator privileges to properly run mimikatz

![image1](image1-145.png)

4.  Sekurlsa::tickets /export

this will export all of the .kirbi tickets into the directory that you are currently in

At this step you can also use the base 64 encoded tickets from Rubeus that we harvested earlier

![image2](image2-72.png)

When looking for which ticket to impersonate I would recommend looking for an administrator ticket from the krbtgt just like the one outlined in red above.

