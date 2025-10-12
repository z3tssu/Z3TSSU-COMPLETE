---
title: Understanding SMTP
updated: 2023-03-19T19:59:04.0000000+04:00
created: 2023-03-19T19:55:29.0000000+04:00
---

Understanding SMTP
Sunday, March 19, 2023
7:55 PM

SMTP: Simple Mail Transfer Protocol

\# What is SMTP?

SMTP stands for "Simple Mail Transfer Protocol". It is utilised to handle the sending of emails. In order to support email services, a protocol pair is required, comprising of SMTP and POP/IMAP. Together they allow the user to send outgoing mail and retrieve incoming mail, respectively.

The SMTP server performs three basic functions:

- It verifies who is sending emails through the SMTP server.
- It sends the outgoing mail
- If the outgoing mail can't be delivered it sends the message back to the sender

\# POP and IMAP

- POP, or "Post Office Protocol" and IMAP, "Internet Message Access Protocol" are both email protocols who are responsible for the transfer of email between a client and a mail server.
- The main differences is in POP's more simplistic approach of downloading the inbox from the mail server, to the client.
- Where IMAP will synchronize the current inbox, with new mail on the server, downloading anything new. This means that changes to the inbox made on one computer, over IMAP, will persist if you then synchronize the inbox from another computer. The POP/IMAP server is responsible for fulfiling this proce

