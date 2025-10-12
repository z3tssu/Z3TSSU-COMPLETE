---
title: HTTP Request Methods
updated: 2022-11-27T12:10:49.0000000+04:00
created: 2022-11-27T11:52:41.0000000+04:00
---

AM

**URL: Uniform Resource Locator**
- It is used to locate the resource on the network

**GET Request:**
- Shouldn’t alter data
- Only retrieve data form the server and return it
- Example: a GET request should return your profile name but not update your profile.
- It is a **critical vulnerability for the Cross-Site Request Forgery (CSRF)**
- Any Request to a server will invoke a GET request

**HEAD Request:**
- Identical to the GET request, but the server doesn’t send a message body.

**POST Request:**
- Invokes some function on the receiving server, either to write some sort of data on the backend.
- Example: creating a comment, registering a user, deleting an account.

**PUT Request:**
- Invokes a function to an existing record on the server
- Might be used for updating an account, blog post, etc that already exists.

**DELETE Request:**
- Invokes the server to delete a remote resource identified with a URI

**TRACE Method:**
- Used to reflect request message back to the requester
- Allows the requester to see what is being received by the server.

**CONNECT Method:**
- Reserved for use with a proxy
- Can access websites that use HTTPS via a proxy

**OPTIONS Methods:**
- Request information from the server about what methods the server allows.

