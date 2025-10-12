---
title: What is a Web Server?
updated: 2022-11-23T08:22:03.0000000+04:00
created: 2022-11-23T08:18:50.0000000+04:00
---

What is a Web Server?
Wednesday, November 23, 2022
8:18 AM
A web server is a software that listens for incoming connections and then utilizes the HTTP protocol to deliver web content to its clients.

- The most common web server software you'll come across is **Apache, Nginx, IIS and NodeJS**.

A Web server delivers files from what's called its root directory, which is defined in the software settings.
- For example, Nginx and Apache share the same default location of **/var/www/html** in Linux operating systems,
- IIS uses **C:\inetpub\wwwroot** for the Windows operating systems.
- So, for example, if you requested the file <http://www.example.com/picture.jpg>, it would send the file **/var/www/html/picture.jp**g from its local hard drive.
