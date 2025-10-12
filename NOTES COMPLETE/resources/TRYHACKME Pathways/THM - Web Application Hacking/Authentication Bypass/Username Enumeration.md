---
title: Username Enumeration
updated: 2022-11-23T15:01:44.0000000+04:00
created: 2022-11-23T12:59:05.0000000+04:00
---

PM
<u>Inside a website, if there is a type of form,</u>

- If you try entering a used **username admin/other usernames** and fill in the other form fields with fake information, you'll see we get the error, that the **username is taken or something**.
- We can use the existence of this error message to produce a list of valid usernames already signed up on the system by using the ffuf tool below.
- The ffuf tool uses a list of commonly used usernames to check against for any matches.
  
  **Example:**
- ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt -X POST -d **"username=FUZZ&email=x&password=x&cpassword=x"** -H "Content-Type: application/x-www-form-urlencoded" -u <http://10.10.158.45/customers/signup> -mr **"username already exists"**
  
  **<u>Argument meanings:</u>**
  
  | **Name** | **Meaning**                                                                                                                                                                                                                                       |
  |----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | -w       | Wordlist of usernames to be used for the enumeration                                                                                                                                                                                              |
  | -x       | Specifies the request method                                                                                                                                                                                                                      |
  | -d       | Specifies the data that we are going to send \| fields **username, email, password and cpassword** \| set the value of the **username to FUZZ**. The FUZZ keyword signifies where the contents from our wordlist will be inserted in the request. |
  | -H       | used for adding additional headers to the request. Content-Type to the webserver knows we are sending form data.                                                                                                                                  |
  | -u       | specifies the URL we are making the request t                                                                                                                                                                                                     |
  | -mr      | argument is the text on the page we are looking for to validate we've found a valid username                                                                                                                                                      |