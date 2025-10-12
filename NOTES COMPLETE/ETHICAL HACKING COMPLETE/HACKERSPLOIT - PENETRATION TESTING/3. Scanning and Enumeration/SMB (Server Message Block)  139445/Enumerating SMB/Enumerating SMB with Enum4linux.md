---
title: Enumerating SMB with Enum4linux
updated: 2023-03-24T15:42:51.0000000+04:00
created: 2023-03-24T15:42:36.0000000+04:00
---

Enumerating SMB with Enum4linux
Friday, March 24, 2023
3:42 PM

1.  **Enum4linux**

- Enum4linux is a tool used to enumerate SMB shares on both Windows and Linux systems.
- It is basically a wrapper around the tools in the Samba package and makes it easy to quickly extract information from the target pertaining to SMB.
- It's installed by default on Parrot and Kali, however if you need to install it, you can do so from the official github.

| **Command** | enum4linux \[options\] ip |
|-------------|---------------------------|

**Additional tags can be used below:**

- -U get userlist
- -M get machine list
- -N get namelist dump (different from -U and-M)
- -S get sharelist
- -P get password policy information
- -G get group and member list

- -a all of the above (full basic enumeration)

Typically you would use the -a for a complete scan:

- Sudo enum4linux -a (Ip_Address)
