---
title: Mounting the NFS Drive to Our Local Machine
updated: 2023-03-24T16:33:08.0000000+04:00
created: 2023-03-24T16:21:19.0000000+04:00
---

Mounting the NFS Drive to Our Local Machine
Friday, March 24, 2023
4:21 PM

1.  Create a mount locate
2.  Mount the NFS Drive to your Kali Linux Machine

![image1](image1-241.png)

![image2](image2-106.png)

3.  Listing the File in the mounted Drive

![image3](image3-67.png)

4.  Remember, we moved the Id_rsa to the /var/tmp folder, we now want to copy that id_rsa file so that we can log into SSH onto our local kali machine

- Command: cp /mount/Location/tmp/id_rsa

![image4](image4-44.png)

5.  Change the mode to provide greater permission

| Command | Chmod 600 id_rsa |
|---------|------------------|

![image5](image5-29.png)

