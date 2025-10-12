---
title: Enumerating NFS
updated: 2023-03-24T08:53:48.0000000+04:00
created: 2023-01-29T16:58:41.0000000+04:00
---

Enumerating NFS
Sunday, January 29, 2023
4:58 PM
## What is enumeration?

- a process which establishes an active connection to the target hosts to discover potential attack vectors in the system, and the same can be used for further exploitation of the system

## Tools Required:

- nfs-common

### Mounting NFS shares

- Basically like creating a shared drive, but on Linux.

Your client’s system needs a directory where all the content shared by the host server in the export folder can be accessed. You can create
this folder anywhere on your system. Once you've created this mount point, you can use the "mount" command to connect the NFS share to the mount point on your machine like so:

sudo mount -t nfs IP:share /tmp/mount/ -nolock

### Let's break this down

| Tag      | Function                                                                     |
|----------|--------------------------------------------------------------------------------------|
| Sudo     | Run as root                                                                  |
| Mount    | Execute the mount command                                                    |
| -t nfs   | Type of device to mount, then specifying that it's NFS                       |
| IP:share | The IP Address of the NFS server, and the name of the share we wish to mount |
| -nolock  | Specifies not to use NLM locking                                             |

## <u>Enumerating NFS from TryHackMe</u>

1.  Open Port Enumeration:

![image1](image1-32.png)

### Result:

![image2](image2-15.png)

2.  List the NFS shares
### 
- Use /usr/sbin/showmount -e \[IP\] , what is the name of the visible share?

![image3](image3-8.png)

3.  Mounting the Discovered share to our local machine:

1.  First, use "mkdir /tmp/mount" to create a directory on your machine to mount the share to

![image4](image4-7.png)
1.  This is in the /tmp directory- so be aware that it will be removed on restart
2.  Use this command sudo mount -t nfs IP:share /tmp/mount/ -nolock, to mount the NFS share to your local machine.
3.  Change directory to the newly mounted drive.
4.  Example: sudo mount -t nfs 10.10.56.153:home /tmp/mount/ -nolock

![image5](image5-5.png)

4.  Look through the shared drive

![image6](image6-2.png)

5.  Follow the steps to find the ssh keys

![image7](image7-2.png)

8.  Copy the id_rsa and id_rsa.pub to any directory of your choosing
9.  Change the mode for these to file using: chmod 666 \[File_name\]
10. This will be used to log into the SSH server
11. To Log into SSH using the found keys

| Command | ssh -i id_rsa username@ip_address |
|---------|-----------------------------------|

