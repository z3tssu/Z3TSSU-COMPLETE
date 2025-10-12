---
title: OSINT - SSL/TLS Certificates
updated: 2022-11-23T11:33:56.0000000+04:00
created: 2022-11-23T11:31:03.0000000+04:00
---

AM
**<u>SSL/TLS Certificates</u>**

When an SSL/TLS (Secure Sockets Layer/Transport Layer Security) certificate is created for a domain by a CA (Certificate Authority), CA's take part in what's called "Certificate Transparency (CT) logs".

These are publicly accessible logs of every SSL/TLS certificate created for a domain name. The purpose of Certificate Transparency logs is to stop malicious and accidentally made certificates from being used.

We can use this service to our advantage to discover subdomains belonging to a domain, sites like
- <https://crt.sh> and
- <https://ui.ctsearch.entrust.com/ui/ctsearchui>

offer a searchable database of certificates that shows current and historical results.

.
