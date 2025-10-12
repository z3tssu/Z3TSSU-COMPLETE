---
title: Virtual Host
updated: 2022-11-23T08:29:33.0000000+04:00
created: 2022-11-23T08:27:55.0000000+04:00
---

Virtual Host
Wednesday, November 23, 2022
8:27 AM
Web servers can host multiple websites with different domain names;

**to achieve this, they use virtual hosts**.
- The web server software checks the hostname being requested from the HTTP headers and matches that against its virtual hosts (virtual hosts are just text-based configuration files). If it finds a match, the correct website will be provided. If no match is found, the default website will be provided instead.

- Virtual Hosts can have their root directory mapped to different locations on the hard drive. For example, one.com being mapped to /var/www/website_one, and two.com being mapped to /var/www/website_two

There's no limit to the number of different websites you can host on a web server.
