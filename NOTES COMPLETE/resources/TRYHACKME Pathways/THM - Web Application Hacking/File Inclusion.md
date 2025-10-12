---
title: File Inclusion
updated: 2023-03-19T10:22:44.0000000+04:00
created: 2022-11-24T14:55:46.0000000+04:00
---

File Inclusion
Thursday, November 24, 2022
2:55 PM
In some cases,

- web applications are developed to use parameters to request access to specific files on a system, such as photos, static text, and so on.
- The **query parameter strings known as parameters** are added to the URL and can be used to retrieve data or carry out activities based on user input.
- The key components of the URL are delineated in the following graph.
  
  ![image1](image1-172.png)
  We'll talk about a situation where a user asks to access files on a web server. The user first sends a file to show via an HTTP request to the website.
- For instance, the request might be as follows: <http://webapp.thm/get.php?file=userCV.pdf>, where the **file is the argument** and **userCV.pdf is the necessary file to access**, if the user wishes to access and show their CV within the web application.