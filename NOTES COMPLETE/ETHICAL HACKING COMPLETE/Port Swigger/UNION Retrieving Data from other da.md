---
title: 'UNION: Retrieving Data from other database Tables'
updated: 2022-12-02T08:34:52.0000000+04:00
created: 2022-11-29T14:08:02.0000000+04:00
---

<u>UNION: Retrieving Data from other database Tables</u>
Tuesday, November 29, 2022
2:08 PM
You can apply this where the results of an SQL query are returned within the application's responses,

1.  When the SQL vulnerability is identified, an attacker can leverage it to retrieve data from other tables
2.  This is done using the **UNION** keyword.
3.  Union lets you execute an additional **SELECT** query and append it to the original.
4.  Basically, UNION lets you merge multiple columns from different tables into the single SQL query.

**<u>Example 1:</u>**

- SELECT a, b FROM table1 UNION SELECT c, d FROM table2

- This SQL query will return a single result set with two columns, containing values from columns a and b in table1 and columns c and d in table2.

**<u>Example 2 :</u>**

SELECT name, description FROM products WHERE category = 'Gifts'

**<u>Example attacker query:</u>**

' UNION SELECT username, password from Users--

