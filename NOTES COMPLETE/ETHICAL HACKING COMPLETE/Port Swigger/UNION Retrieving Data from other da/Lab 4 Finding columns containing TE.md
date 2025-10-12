---
title: 'Lab 4: Finding columns containing TEXT | SQLi Unio...'
updated: 2022-12-01T10:14:56.0000000+04:00
created: 2022-11-29T15:20:15.0000000+04:00
---

Lab 4: Finding columns containing TEXT \| SQLi Union Attacks
Tuesday, November 29, 2022
3:20 PM
**Once you have identified the number of columns using the previous Union attack chapter.**

You can proceed to identify the exact names or at least one character of the table using the below method.

1.  Having already determined the number of required columns, you can **probe each column to test whether it can hold string data by submitting a series of UNION SELECT payloads** that place a string value into each column in turn.
2.  For example, if the query returns four columns, you would submit:

- ' UNION SELECT 'a',NULL,NULL,NULL--
- ' UNION SELECT NULL,'a',NULL,NULL--
- ' UNION SELECT NULL,NULL,'a',NULL--
- ' UNION SELECT NULL,NULL,NULL,'a'--

3.  If the data type of a column is not compatible with string data, the injected query will cause a database error, such as: Conversion failed when converting the varchar value 'a' to data type int.
4.  If an error does not occur, and the application's response contains some additional content including the injected string value, then the relevant column is suitable for retrieving string data.

**<u>From the LAB</u>**

1.  Finding the Amount of Columns
2.  Used ' UNION SELECT NULL,NULL,NULL--
3.  We got no Error Response,
4.  So it confirms that there is 3 columns

![image1](image1-187.png)

**<u>Finding what column supports a data type:</u>**

1.  Following the methods above, query used was: ' UNION SELECT NULL, 'a', NULL--
2.  No Error, which means that Column 2 can take string data.

![image2](image2-84.png)
