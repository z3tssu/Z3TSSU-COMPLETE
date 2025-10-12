---
title: Sending a HTTP Request
updated: 2022-11-26T19:49:31.0000000+04:00
created: 2022-11-26T19:36:59.0000000+04:00
---

Sending a HTTP Request
Saturday, November 26, 2022
7:36 PM
![image1](image1-174.png)

1.  **GET:**
- The browser makes a **GET** request to the path **/HTTP/1.1**
- Which is the website's root
- A website is organized into paths

2.  **Host:**
- The host header holds additional piece of information
- Identifies where the server should send and request the domain/address

3.  **Connection: keep-alive**
- Identifies the request to keep the connection open

4.  **Accept: application/help/, \*/\***
- Identifies the expected response that it is expecting application/html
- There are hundreds of content types
- application/html \| application/json \| application/octet-stream

5.  **User-Agent:**
- Denotes the software that sent the request

