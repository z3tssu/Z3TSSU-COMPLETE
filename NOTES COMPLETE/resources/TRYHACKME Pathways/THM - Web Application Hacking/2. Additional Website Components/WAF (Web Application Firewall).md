---
title: WAF (Web Application Firewall)
updated: 2022-11-23T08:18:09.0000000+04:00
created: 2022-11-23T08:16:43.0000000+04:00
---

WAF (Web Application Firewall)
Wednesday, November 23, 2022
8:16 AM
- A WAF sits between your web request and the web server;
- its primary purpose is to protect the webserver from hacking or denial of service attacks.
- It analyses the web requests for common attack techniques, whether the request is from a real browser rather than a bot.
- checks if an excessive amount of web requests are being sent by utilizing something called rate limiting, which will only allow a certain amount of requests from an IP per second.
- If a request is deemed a potential attack, it will be dropped and never sent to the webserver.
