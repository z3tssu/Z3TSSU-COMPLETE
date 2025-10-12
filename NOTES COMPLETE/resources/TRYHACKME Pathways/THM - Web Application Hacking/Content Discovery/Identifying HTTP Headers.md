---
title: Identifying HTTP Headers
updated: 2022-11-23T11:00:58.0000000+04:00
created: 2022-11-23T09:53:49.0000000+04:00
---

Identifying HTTP Headers
Wednesday, November 23, 2022
9:53 AM
**<u>HTTP Headers</u>**

When we make requests to the web server, the server returns various HTTP headers.

- contain useful information such as the webserver software and possibly the programming/scripting language in use.
- Using this information, we could find vulnerable versions of software being used. Try running the below curl command against the web server, where the **-v switch** enables verbose mode, which will output the headers (there might be something interesting!).

- **curl <http://10.10.237.147> -v**

![image1](image1-167.png)
