---
title: Request and Response
updated: 2022-11-26T12:40:00.0000000+04:00
created: 2022-11-22T14:26:07.0000000+04:00
---

Request and Response
Tuesday, November 22, 2022
2:26 PM
**<u>Example Request:</u>**

GET / HTTP/1.1
Host: tryhackme.com
User-Agent: Mozilla/5.0 Firefox/87.0
Referer: <https://tryhackme.com/>

**<u>To breakdown each line of this request:</u>**

**<u>Line 1:</u>** This request is sending the GET method ( more on this in the HTTP Methods task ), request the home page with / and telling the web server we are using HTTP protocol version 1.1.

**<u>Line 2</u>**: We tell the web server we want the website tryhackme.com

**<u>Line 3</u>**: We tell the web server we are using the Firefox version 87 Browser

**<u>Line 4</u>**: We are telling the web server that the web page that referred us to this one is <https://tryhackme.com>

**<u>Line 5</u>**: HTTP requests always end with a blank line to inform the web server that the request has finished.

**<u>Example Response:</u>**

![image1](image1-158.png)

**<u>To breakdown each line of the response:</u>**

**<u>Line 1:</u>** HTTP 1.1 is the version of the HTTP protocol the server is using and then followed by the HTTP Status Code in this case "200 Ok" which tells us the request has completed successfully.

**<u>Line 2:</u>** This tells us the web server software and version number.

**<u>Line 3:</u>** The current date, time and timezone of the web server.

**<u>Line 4:</u>** The Content-Type header tells the client what sort of information is going to be sent, such as HTML, images, videos, pdf, XML.

**<u>Line 5:</u>** Content-Length tells the client how long the response is, this way we can confirm no data is missing.

**<u>Line 6</u>**: HTTP response contains a blank line to confirm the end of the HTTP response.

**<u>Lines 7-14:</u>** The information that has been requested, in this instance the homepage.
