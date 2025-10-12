---
title: Logic Flaw
updated: 2022-11-23T14:44:26.0000000+04:00
created: 2022-11-23T14:40:24.0000000+04:00
---

Logic Flaw
Wednesday, November 23, 2022
2:40 PM
**<u>Sometimes authentication processes contain logic flaws.</u>**

- A logic flaw is when the typical logical path of an application is either bypassed, circumvented or manipulated by a hacker.
- Logic flaws can exist in any area of a website, but we're going to concentrate on examples relating to authentication in this instance.

**<u>Logic Flaw Example</u>**

The below mock code example checks to see whether the start of the path the client is visiting begins with **/admin** and if so, then further checks are made to see whether the client is, in fact, an admin. If the page doesn't begin with **/admin**, the page is shown to the client.

![image1](image1-169.png)

Because the above PHP code example uses three equals signs (**===**), it's looking for an exact match on the string, including the same letter casing. The code presents a logic flaw because an unauthenticated user requesting /adMin will not have their privileges checked and have the page displayed to them, totally bypassing the authentication checks.
