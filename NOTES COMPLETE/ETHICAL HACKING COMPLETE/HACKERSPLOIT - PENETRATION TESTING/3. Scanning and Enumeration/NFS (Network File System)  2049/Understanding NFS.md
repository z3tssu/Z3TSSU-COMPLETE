---
title: Understanding NFS
updated: 2023-01-30T13:11:49.0000000+04:00
created: 2023-01-29T16:59:21.0000000+04:00
---

Understanding NFS
Sunday, January 29, 2023
4:59 PM
NFS stands for Network File System and allows for file sharing over a network. It enables clients to access remote files as if they were local by mounting a portion of a file system from a server. The client requests access to a directory from a remote host, the server checks permission and provides a unique identifier for the files. To access a file using NFS, a request is made to the NFS daemon on the server using parameters such as the file identifier, file name, user ID, and group ID to determine user permission. NFS works on both Windows and non-Windows operating systems like Linux, MacOS, and UNIX. Windows Server can act as an NFS file server for non-Windows clients and access files stored on a non-Windows NFS server.

**More Information:**

Here are some resources that explain the technical implementation, and working of, NFS in more detail than I have covered here.

<https://www.datto.com/library/what-is-nfs-file-share>

<http://nfs.sourceforge.net/>

<https://wiki.archlinux.org/index.php/NFS>
smb
