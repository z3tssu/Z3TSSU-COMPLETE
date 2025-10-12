---
title: SCP - Secure Copy
updated: 2023-03-19T09:06:32.0000000+04:00
created: 2023-03-19T09:03:01.0000000+04:00
---
# SCP (Secure Copy)

**Date:** [Date]  
**Time:** [Time]

## Overview
- `scp` is a command-line tool for securely copying files and directories between hosts.

## Basic Usage
- Copy a file from local to remote:

```
  scp /path/to/local/file username@remote_host:/path/to/remote/location
  ```

- Copy a file from remote to local

```bash
scp username@remote_host:/path/to/remote/file /path/to/local/location

```

