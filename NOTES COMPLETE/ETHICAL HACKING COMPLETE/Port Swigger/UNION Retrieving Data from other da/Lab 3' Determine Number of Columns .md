---
title: "Lab 3': Determine Number of Columns in SQLi UNION"
updated: 2022-12-01T10:12:54.0000000+04:00
created: 2022-11-29T14:34:03.0000000+04:00
---

Lab 3': Determine Number of Columns in SQLi UNION
Tuesday, November 29, 2022
2:34 PM
There are two effective ways of identifying the column amount:

**<u>Method 1:</u> Use Query ORDER BY --------------------------------------------------------**

- You will use this and keep increasing the value until an error occurs.
- Example shown below:

![image1](image1-186.png)
***Explained how it works:***

- These payloads modify the original query to order the results by different columns
- When the query exceeds the correct amount of columns it is being ordered by, it will produce and error.
- The error can be returned as a database error in its HTTP response (you can check with burpsuite), you may get a generic error also, or either get no errors displayed.
- **The key is to identify some sort of changes in the responces you get**.

**<u>Method 2:</u> Use Query UNION SELECT --------------------------------------------------------**

- The idea is to use a series of **UNION SELECT** payloads, with null values
- As see below:

![image2](image2-83.png)

***Explained:***

- **If a Null value provided does not match the number of columns, an error will be produced, this is when you know you have either exceeded the number of columns or not.**
- the application might actually return this error message, or might just return a generic error or no results.
- When the number of nulls matches the number of columns, the database returns an additional row in the result set, containing null values in each column.
- The effect on the resulting HTTP response depends on the application's code.
- If you are lucky, you will see some additional content within the response, such as an extra row on an HTML table.
- Otherwise, the null values might trigger a different error, such as a **<u>NullPointerException.</u>**
- Worst case, the response might be indistinguishable from that which is caused by an incorrect number of nulls, making this method of determining the column count ineffective

**<u>Example</u>**

**' UNION SELECT NULL,NULL--**

![image3](image3-54.png)

**' UNION SELECT NULL, NULL, NULL--** (Correct Answer)

![image4](image4-37.png)
