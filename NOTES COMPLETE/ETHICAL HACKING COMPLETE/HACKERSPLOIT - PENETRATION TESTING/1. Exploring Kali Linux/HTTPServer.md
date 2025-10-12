---
title: HTTPServer
updated: 2023-03-19T09:17:10.0000000+04:00
created: 2023-03-19T09:06:44.0000000+04:00
---

HTTPServer
Sunday, March 19, 2023
9:06 AM
- Ubuntu machines come pre-packaged with python3. Python helpfully provides a lightweight and easy-to-use module called "HTTPServer". This module turns your computer into a quick and easy web server that you can use to serve your own files, where they can then be downloaded by another computing using commands such as curl and wget.

- Python3's "HTTPServer" will serve the files in the directory that you run the command, but this can be changed by providing options that can be found in the manual pages.

- Simply, all we need to do is run python3 -m http.server to start the module! In the screenshot below,

- we are serving from a directory called "webserver", which has a single named "file".

Example:

1.  We initiate the HTTP.SERVER

![image1](image1-1.png)

2.  On the machine that we want to download the file.

![image2](image2-1.png)
