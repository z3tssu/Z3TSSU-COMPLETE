---
title: Cookie Tampering
updated: 2022-11-24T09:41:50.0000000+04:00
created: 2022-11-24T08:54:25.0000000+04:00
---

Cookie Tampering
Thursday, November 24, 2022
8:54 AM
Examining and altering the cookies that the web server has placed during your online session may result in a variety of negative effects, including unauthenticated access and account access for another user.

**<u>Plain Text Cookies</u>**

![image1](image1-170.png)

**<u>Hashing</u>**

![image2](image2-78.png)

**<u>Encoding</u>**

- Similar to hashing as it creates a random text string
- Encoding is reversible
- Allows the conversion of binary data to human readable text so it can be transmitted
- Encoding types include:
-- **base32: converts binary data to the characters A-Z and 2-7**

-- **base64: converts using the characters a-z, A-Z, 0-9,+, / and the equals sign for padding**

![image3](image3-50.png)

**<u>Decode Hashes</u>**

**<u>Decoding MD5 Hash:</u>**
- You can use [www.crackstation.com](http://www.crackstation.com)
- Or simply, create a text file
- Then use **JohntheRipper** to crack it
- Syntax: john "textfilename.txt"
- DONE!

**<u>Decoding Base64 Hash</u>**

![image4](image4-33.png)

**Or go to: <https://www.base64decode.org/>**
