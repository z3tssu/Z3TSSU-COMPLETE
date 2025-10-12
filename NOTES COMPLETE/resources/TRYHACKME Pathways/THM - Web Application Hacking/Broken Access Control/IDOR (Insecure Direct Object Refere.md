---
title: IDOR (Insecure Direct Object Reference)
updated: 2023-03-19T10:22:42.0000000+04:00
created: 2022-11-24T09:49:04.0000000+04:00
---

IDOR (Insecure Direct Object Reference)
Thursday, November 24, 2022
9:49 AM
**<u>What is an IDOR?</u>**

IDOR stands for **Insecure Direct Object Reference** and is a type of access control vulnerability.

When a web server takes user-supplied input to get objects (files, data, documents), too much faith is placed in the input data, and it is not checked on the server-side to ensure the requested object belongs to the user requesting it, this sort of vulnerability might arise.
