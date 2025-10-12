---
title: 'Lab 11: Blind SQLi with Conditional Responses'
updated: 2022-12-07T08:08:26.0000000+04:00
created: 2022-12-02T08:20:45.0000000+04:00
---

Lab 11: Blind SQLi with Conditional Responses
Friday, December 2, 2022
8:20 AM
**<u>Theory behind it:</u>**

- Consider an application using tracking cookies to gather analytics about usage.
- Requests made to the application contains cookie header like the below.

| Header | Cookie: TrackingId=u5YD3PapBcR4lN3e7Tj4 |
|--------|-----------------------------------------|

- If a request is made containing a TrackingId, that means the application determines whether this is a known user using an SQL query like below.

| Query | SELECT TrackingId FROM TrackedUsers WHERE TrackingId = 'u5YD3PapBcR4lN3e7Tj4' |
|-------|-------------------------------------------------------------------------------|

- The query is vulnerable, because if the trackingid is recognized by the application, it will return some sort of success, in this case a Welcome Back
- This behavior is enough to exploit the blind SQL injection vulnerability and retrieve information
- It can be done by triggering different responses conditionally, depending on an injected condition.
- To see how this works, suppose that two requests are sent containing the following TrackingId cookie values in turn:

| Query that will equal to true  | …xyz' AND '1'='1 |
|--------------------------------|------------------|
| Query that will equal to false | …xyz' AND '1'='2 |

**<u>Testing the password of a User:</u>**

1.  We have the table name "Users"
2.  We have two columns; "Username" and "Password"
3.  And a User called "Administrator"

We use the below query to test the password of the user.

1.  We test if the password is greater than m, meaning if it begins with m

| Query to use | xyz' AND SUBSTRING((SELECT Password FROM Users WHERE Username = 'Administrator'), 1, 1) \> 'm |
|--------------|-----------------------------------------------------------------------------------------------|

2.  We Test if the password is greater than t

| Query to use | xyz' AND SUBSTRING((SELECT Password FROM Users WHERE Username = 'Administrator'), 1, 1) \> 't |
|--------------|-----------------------------------------------------------------------------------------------|

- This doesn't return the Welcome back message, so it means that the condition is false.

3.  We test if the password begins with s, since it does not begin with t, you will get the successful Welcome Back message.

| Query to use | xyz' AND SUBSTRING((SELECT Password FROM Users WHERE Username = 'Administrator'), 1, 1) = 's |
|--------------|----------------------------------------------------------------------------------------------|

4.  We can use this method to determine the full password, but it may take some time.

**<u>Note:</u>** The SUBSTRING function is called SUBSTR on some types of database. For more details, see the SQL injection cheat sheet.

**<u>(Lab-11)</u>** - **<u>Blind SQL Injection with Conditional Responses</u> ------------------------------**

**Vulnerable Parameter** - Tracking Cookie

**End Goal:**

1.  Enumerate the password of the administrator
2.  Log in as the administrator user

**<u>Analysis:</u>**

1.  **Confirm that the parameter is vulnerable to Blind SQLi**

| Original Query | Select tracking-id from tracking-table where tracking-id = 'asas1e21easdas' |
|----------------|-----------------------------------------------------------------------------|

- If this tracking id exist \> query will return "Welcome Back" message
- If the tracking id doesn’t exist \>query will return nothing

| Query used to check parameters | Select tracking-id from tracking-table where tracking-id = 'asas1e21easdas' and 1=1--' |
|--------------------------------|----------------------------------------------------------------------------------------|

Below is the true Query used:

![image1](image1-193.png)

2.  **Confirm that we have a user's table**

| Query to use | ' and (select 'x' from users LIMIT 1)='x'--' |
|--------------|----------------------------------------------|

![image2](image2-89.png)

- This answers that the users table exist in the database.

3.  **Confirm that the username "administrator" exists in the users table.**

| Query to use | ' and (select username from users where username='administrator')='administrator'--' |
|--------------|--------------------------------------------------------------------------------------|

![image3](image3-58.png)

- Confirms that the administrator user exists

4.  **Enumerate the password of the administrator user**

- The below query will identify if the length of the password is greater than the input value.
- Since the username administrator has been identified as existing we can use that to identify the password

The below query will identify the length of the password.

| **Query to use** | ' and (select username from users where username='administrator' and LENGTH(password)\>1)='administrator'--' |
|------------------|--------------------------------------------------------------------------------------------------------------|

- For this usually, you will need to individually keep incrementing the LENGTH value each time you get a true response.

![image4](image4-40.png)

5.  **Bruteforce the password Length using Intruder**

![image5](image5-27.png)

<u>Clear Positions in Intruder</u>

![image6](image6-19.png)

<u>Selecting the new position, in this case it will be the LENGTH value you are incrementing</u>

![image7](image7-15.png)

- Highlight the number and press "Add" on the right hand side

<u>Set the Payload</u>

![image8](image8-13.png)

**<u>Start the Attack</u>**

- Once you start the attack, you will get the below:

![image9](image9-8.png)

- If you view carefully the LENGH values,
- You will see that they are the same when the attack query is true
- However they change when it is false.
- In this case, it refers to if the password is bigger than 20 and it returned a false
- So it means that the password is 20 characters.

6.  **Enumerate First Character of the Password using Substring Method:**

| Query to use: | ' and (select substring(password,1,1) from users where username='administrator')='a'--' |
|---------------|-----------------------------------------------------------------------------------------|

- Substring(password,1,1) \| Means to select the first character of the password and only the first

![image10](image10-5.png)

7.  **Intruder to Bruteforce**

- Right click request, send to intruder
- Clear Positions
- Add Positions, in this case the variable we are testing is the first letter so it 'a'

![image11](image11-4.png)

- Inside Payload tab
- Set as follows:

![image12](image12-3.png)

- Start the Attack and you will see the following once it finishes.

![image13](image13-1.png)

7.  **Different Type of Attack (Clusterbomb)**

- Add the following Payloads (in positions tab)

![image14](image14-1.png)

**<u>Set Payload Options</u>**

Set Payload 1 as followed:

![image15](image15-1.png)

Set Payload 2 as followed:
![image16](image16-1.png)

7.  **Arrange Completed Password:**

![image17](image17.png)

- Once Attack is completed
- Filter by the keyword "welcome"
- Simple match the Payload 1, to Payload 2
- Example: Payload 1 (Password first letter) = 5
Right click inside the request form

And click on send to Intruder

- Inside the payload tab
- Set payload type to "Numbers"
- Set from and to as seen in image
- Set the Step count to 1

- In the length section, look for different matches
- In this case 5071 returned the true statement
- We can search for "Welcome back" in the response tab
- We can see that it indeed got the true response,
- So it means that the first letter is "u"

