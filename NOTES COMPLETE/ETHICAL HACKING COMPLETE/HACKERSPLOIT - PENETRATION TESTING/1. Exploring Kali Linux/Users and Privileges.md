# Listing Files and Directories in /tmp/

**Purpose:** The `ls -la /tmp/` command is used to list all files and directories in the /tmp/ directory, including hidden files, with detailed information.

## Information about /tmp/ Directory
- The `/tmp/`  directory is commonly used for temporary files in Unix-like operating systems.
- It typically has read/write permissions enabled by default for all users.

## Changing Permissions
- `chmod 777` or `chmod +x`: Gives full read/write accesses to files or directories.

## Adding Users
- Command: `adduser`
- Example: `adduser John`
- This command adds a new user to the system.

## Confirming Users
- The `/etc/passwd` file shows all users on the system.
- Passwords are stored in the `/etc/shadow` file.

## Switching Users
- Command: `su z3tssu`
- This command switches the current user to the specified user (`z3tssu` in this case) after entering the user's password.
