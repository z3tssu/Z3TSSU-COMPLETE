---
title: Enumerating SMTP
updated: 2023-03-24T09:49:49.0000000+04:00
created: 2023-03-19T20:02:21.0000000+04:00
---

Enumerating SMTP
Sunday, March 19, 2023
8:02 PM
**\# Enumerating Server Details**

1.  fingerprint the server to make our targeting as precise as possible.

2.  We're going to use the "smtp_version" module in MetaSploit to do this. As its name implies, it will scan a range of IP addresses and determine the version of any mail servers it encounters.

