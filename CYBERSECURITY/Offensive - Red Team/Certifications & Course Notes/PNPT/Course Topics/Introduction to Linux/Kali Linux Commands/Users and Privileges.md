- passwd
    - command used to change the linux user password
- su
    
    Command used to “Switch User”
    
- adduser
    - Command used to add a new user
- chmod - Change Mode
    
    In Linux, the `chmod` command changes the file permissions. These permissions are set using three groups: **owner (user)**, **group**, and **others**. Each of these groups can have **read**, **write**, and **execute** permissions. The permissions are represented numerically:
    
    - **Read** = 4
    - **Write** = 2
    - **Execute** = 1
    
    The total permission for each group is the sum of these values. Below is a table that shows different permission combinations using the numbers **4, 2, 1** for each group.
    
    |   |   |   |
    |---|---|---|
    |Permission|Numeric Value|Description|
    |---|0|No permission|
    |--x|1|Execute only|
    |-w-|2|Write only|
    |-wx|3 (2+1)|Write and Execute|
    |r--|4|Read only|
    |r-x|5 (4+1)|Read and Execute|
    |rw-|6 (4+2)|Read and Write|
    |rwx|7 (4+2+1)|Read, Write, Execute|
    
    For example, if you set a file's permission to `755`:
    
    - The **owner** has `7` (read, write, and execute: `rwx`).
    - The **group** has `5` (read and execute: `r-x`).
    - Others have `5` (read and execute: `r-x`).
    
    This table helps you determine how to set different permissions for files using the `chmod` command.
    
- /etc/passwd
    - The location where linux users are stored
- /etc/shadow
    - The location where the users password hash are stored
- grep ‘sudo’ /etc/group
    - Find who is the sudo user in the group
- /etc/sudoers
    - Explanation: Displays the content of the "/etc/sudoers" file, which contains configuration information for the `sudo` command.
    - Example: Running `/etc/sudoers` would display the configuration directives for `sudo` access and permissions.