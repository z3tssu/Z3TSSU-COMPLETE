---
title: Maintaining System Logs
updated: 2023-03-19T10:02:22.0000000+04:00
created: 2023-03-19T10:01:24.0000000+04:00
---

AM

We briefly touched upon log files and where they can be found in Linux Fundamentals Part 1. However, let's quickly recap. Located in the /var/log directory, these files and folders contain logging information for applications and services running on your system. The Operating System (OS) has become pretty good at automatically managing these logs in a process that is known as "rotating".

I have highlighted some logs from three services running on a Ubuntu machine:

An Apache2 web server
Logs for the fail2ban service, which is used to monitor attempted brute forces, for example
The UFW service which is used as a firewall

![image1](image1-4.png)

These services and logs are a great way in monitoring the health of your system and protecting it. Not only that, but the logs for services such as a web server contain information about every single request - allowing developers or administrators to diagnose performance issues or investigate an intruder's activity. For example, the two types of log files below that are of interest:

- access log
- error log

![image2](image2-3.png)

