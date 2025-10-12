---
title: How Open Redirect Works?
updated: 2022-11-27T12:40:45.0000000+04:00
created: 2022-11-27T12:16:46.0000000+04:00
---

PM
Occurs when a developer mistrusts attacker-controlled input to redirect to another site
- Usually via the Uniform Resource Locator (URL)
- Using the **HTML \<meta\>** refresh tags

**<u>Example of a Redirect Request:</u>**

![image1](image1-176.png)

1.  Google receives a GET request
2.  Uses the redirect_to parameter to identify the redirection location
3.  Google Returns the HTTP response with the status code 3XX instructing the browser to redirect the user
4.  These codes tell your browser that the page has been found.
5.  Also informs your browser to make a GET request to the parameters value

**<u>Example of Attacker Open Redirect Attack:</u>**

![image2](image2-79.png)

1.  If Google is not validating the redirect_to parameter to its own legit site where it intends to send its users.
2.  An attacker can maliciously change these parameter location with their own website
3.  A HTTP response will then instruct your browser to make a GET request to their malicious website

**<u>How to Identify Open Redirect Vulnerability:</u>**

1.  Look for URL Parameters including certain names such as: **url=, redirect=, next=** and so on.
2.  Also sometimes can be denoted as; **r= or u=**.

3.  HTML \<meta\> and JavaScript can redirect browsers.

- HTML \<meta\> can instruct a browser to request a page and make a GET request to the tags attributes as seen below.

![image3](image3-51.png)

1.  Content="0
- Defines how long the browser will wait before making the HTTP request.
2.  URL=
- Defines the specified website the request will be sent to.

3.  Modifying the Windows location property:

![image4](image4-34.png)

- Occurs only when an attacker can execute JavaScript via, XSS or where there is an Open Redirect Vulnerability.

