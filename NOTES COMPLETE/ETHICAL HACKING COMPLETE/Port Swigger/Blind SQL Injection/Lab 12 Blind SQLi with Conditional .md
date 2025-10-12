---
title: 'Lab 12: Blind SQLi with Conditional Errors'
updated: 2022-12-16T17:19:56.0000000+04:00
created: 2022-12-07T08:17:39.0000000+04:00
---

Lab 12: Blind SQLi with Conditional Errors
Wednesday, December 7, 2022
8:17 AM
**Inducing conditional responses by triggering SQL errors**

In this situation, it is often possible to induce the application to return conditional responses by triggering SQL errors conditionally, depending on an injected condition.

To see how this works, suppose that two requests are sent containing the following TrackingId cookie values in turn:

xyz' AND (SELECT CASE WHEN (1=2) THEN 1/0 ELSE 'a' END)='a
xyz' AND (SELECT CASE WHEN (1=1) THEN 1/0 ELSE 'a' END)='a
These inputs use the CASE keyword to test a condition and return a different expression depending on whether the expression is true. With the first input, the CASE expression evaluates to 'a', which does not cause any error. With the second input, it evaluates to 1/0, which causes a divide-by-zero error. Assuming the error causes some difference in the application's HTTP response, we can use this difference to infer whether the injected condition is true.

Using this technique, we can retrieve data in the way already described, by systematically testing one character at a time:

xyz' AND (SELECT CASE WHEN (Username = 'Administrator' AND SUBSTRING(Password, 1, 1) \> 'm') THEN 1/0 ELSE 'a' END FROM Users)='a

**<u>(Lab-12)</u>** - **<u>Blind SQL Injection with Conditional Responses</u> ------------------------------**

**Vulnerable Parameter** - Tracking Cookie

**End Goal:**

1.  Output the administrator password
2.  Log in as the administrator User

**<u>Analysis:</u>**

