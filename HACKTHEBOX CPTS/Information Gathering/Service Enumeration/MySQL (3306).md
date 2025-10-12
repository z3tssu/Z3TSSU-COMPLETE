# Enumerate
## **Footprinting the Service**

MySQL servers often run on `TCP port 3306`. Accessing MySQL externally is bad practice, but sometimes databases are reachable due to temporary or misconfigured settings.

### **Scanning MySQL Server**

```bash
sudo nmap 10.129.14.128 -sV -sC -p3306 --script mysql*
```

**Example Output**

```
PORT     STATE SERVICE     VERSION
3306/tcp open  nagios-nsca Nagios NSCA
| mysql-brute: 
|   Accounts: 
|     root:<empty> - Valid credentials
|_  Statistics: Performed 45010 guesses in 5 seconds, average tps: 9002.0
|_mysql-databases: ERROR: Script execution failed (use -d to debug)
|_mysql-dump-hashes: ERROR: Script execution failed (use -d to debug)
| mysql-empty-password: 
|_  root account has empty password
| mysql-enum: 
|   Valid usernames: 
|     root:<empty> - Valid credentials
|     netadmin:<empty> - Valid credentials
|     guest:<empty> - Valid credentials
|     user:<empty> - Valid credentials
|     web:<empty> - Valid credentials
|     sysadmin:<empty> - Valid credentials
|     administrator:<empty> - Valid credentials
|     webadmin:<empty> - Valid credentials
|     admin:<empty> - Valid credentials
|     test:<empty> - Valid credentials
|_  Statistics: Performed 10 guesses in 1 seconds, average tps: 10.0
| mysql-info: 
|   Protocol: 10
|   Version: 8.0.26-0ubuntu0.20.04.1
|   Thread ID: 13
|   Capabilities flags: 65535
|   Some Capabilities: SupportsLoadDataLocal, SupportsTransactions, Speaks41ProtocolOld, LongPassword, DontAllowDatabaseTableColumn, Support41Auth, IgnoreSigpipes, SwitchToSSLAfterHandshake, FoundRows, InteractiveClient, Speaks41ProtocolNew, ConnectWithDatabase, IgnoreSpaceBeforeParenthesis, LongColumnFlag, SupportsCompression, ODBCClient, SupportsMultipleStatments, SupportsAuthPlugins, SupportsMultipleResults
|   Status: Autocommit
|   Salt: YTSgMfqvx\x0F\x7F\x16\&\x1EAeK>0
|_  Auth Plugin Name: caching_sha2_password
|_mysql-users: ERROR: Script execution failed (use -d to debug)
|_mysql-variables: ERROR: Script execution failed (use -d to debug)
|_mysql-vuln-cve2012-2122: ERROR: Script execution failed (use -d to debug)
```

---

## **Interaction with the MySQL Server**

```bash
mysql -u root -h 10.129.14.132
```

```
ERROR 1045 (28000): Access denied for user 'root'@'10.129.14.1' (using password: NO)
```

If credentials are found:

```bash
mysql -u root -pP4SSw0rd -h 10.129.14.128
```

```
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 150165
Server version: 8.0.27-0ubuntu0.20.04.1 (Ubuntu)                                                         
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.                           
```

---

### **Listing Databases**

```sql
show databases;
```

```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

---

### **Check Version**

```sql
select version();
```

```
+-------------------------+
| version()               |
+-------------------------+
| 8.0.27-0ubuntu0.20.04.1 |
+-------------------------+
```

---

### **Exploring the `mysql` Database**

```sql
use mysql;
show tables;
```

```
| columns_priv  |
| component     |
| db            |
| default_roles |
| engine_cost   |
| func          |
| general_log   |
| global_grants |
| gtid_executed |
| help_category |
...SNIP...
| user          |
```

---

### **Exploring the `sys` Database**

```sql
use sys;
show tables;
```

```
| host_summary                  |
| host_summary_by_file_io       |
| host_summary_by_file_io_type  |
| host_summary_by_stages        |
| host_summary_by_statement_latency |
| host_summary_by_statement_type    |
...SNIP...
| x$waits_global_by_latency     |
```

---

### **Query Example**

```sql
select host, unique_users from host_summary;
```

```
+-------------+--------------+                   
| host        | unique_users |                   
+-------------+--------------+                   
| 10.129.14.1 |            1 |                   
| localhost   |            2 |                   
+-------------+--------------+ 
```

---

## **Useful MySQL Commands**

|Command|Description|
|---|---|
|`mysql -u <user> -p<password> -h <IP>`|Connect to the MySQL server (no space after `-p`).|
|`show databases;`|Show all databases.|
|`use <database>;`|Select an existing database.|
|`show tables;`|Show tables in the selected database.|
|`show columns from <table>;`|Show all columns in a table.|
|`select * from <table>;`|Show all entries in the table.|
|`select * from <table> where <column> = "<string>";`|Search for a string in the table.|

---

## **Default Configuration**

```bash
sudo apt install mysql-server -y
cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep -v "#" | sed -r '/^\s*$/d'
```

```
[client]
port        = 3306
socket      = /var/run/mysqld/mysqld.sock

[mysqld_safe]
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
nice        = 0

[mysqld]
skip-host-cache
skip-name-resolve
user        = mysql
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
port        = 3306
basedir     = /usr
datadir     = /var/lib/mysql
tmpdir      = /tmp
lc-messages-dir = /usr/share/mysql
explicit_defaults_for_timestamp

symbolic-links=0

!includedir /etc/mysql/conf.d/
```

---

## **Dangerous Settings**

|Setting|Description|
|---|---|
|`user`|User account the service runs as.|
|`password`|Plain text password for the MySQL user.|
|`admin_address`|IP for administrative connections.|
|`debug`|Enables verbose debugging output.|
|`sql_warnings`|Displays detailed warnings on operations.|
|`secure_file_priv`|Controls paths for data import/export.|
# AI Notes
## Footprinting

### Quick Scan

```bash
sudo nmap -sV -sC -p3306 --script mysql* <IP>
```

What to look for:

- Version (e.g., MySQL 8.x / MariaDB)
    
- Auth plugin (e.g., `caching_sha2_password`, `mysql_native_password`)
    
- Empty passwords (`mysql-empty-password`)
    
- Valid accounts from scripts (`mysql-brute`, `mysql-enum`)
    
- Server capabilities, thread ID, salt
    

Example highlights from scans:

- `root:<empty>` valid
    
- Multiple users with empty passwords (e.g., `admin`, `test`, `web`, `sysadmin`)
    
- `Auth Plugin Name: caching_sha2_password`
    

### Fingerprinting Without Auth

```bash
mysql -u root -h <IP>                    # try no password (bad practice but common)
mysql -u root -p<guess> -h <IP>          # no space after -p
```

---

## Default/Key Configs

### MySQL server config (Debian/Ubuntu)

```bash
sudo apt install mysql-server -y
cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep -v "#" | sed -r '/^\s*$/d'
```

Important directives (security-relevant):

- `user` → service account
    
- `password` → may appear in plain text in some setups
    
- `admin_address` → bind for admin interface
    
- `secure_file_priv` → restricts `LOAD DATA INFILE` / `SELECT ... INTO OUTFILE`
    
- `skip-name-resolve` → avoids DNS auth confusion
    
- `port = 3306`, `bind-address`, `datadir`
    

Loot the config if you have file read/Shell: creds, bind IPs, file paths.

---

## Dangerous Settings / Misconfig Pitfalls

- Empty or weak passwords for privileged users (`root`, `admin`)
    
- Remote root login allowed
    
- `secure_file_priv` disabled or writable to web dirs
    
- Over-permissive users (e.g., `%` host wildcard)
    
- Verbose error output (`debug`, `sql_warnings`) leaking schema/paths
    
- Backups and `.sql` dumps world-readable
    

---

## Auth & Initial Access

### Common One-Liners

```bash
# No-pass probe
mysql -u root -h <IP>

# Password probe
mysql -u root -pP4SSw0rd -h <IP>

# Specify protocol (TCP), skip local socket fallback
mysql --protocol=TCP -u <user> -p<pass> -h <IP> -P 3306
```

If authenticated, immediately enumerate:

---

## Post-Auth Enumeration

### Core Recon

```sql
-- Server and version
SELECT VERSION();

-- Databases
SHOW DATABASES;

-- Choose DB
USE <db>;

-- Tables in selected DB
SHOW TABLES;

-- Describe table
SHOW COLUMNS FROM <table>;

-- Sample data
SELECT * FROM <table> LIMIT 5;
```

### System Schemas

- `information_schema` → ANSI/ISO metadata view
    
- `mysql` → native user/privs, plugins, grant tables
    
- `sys` → performance/latency summaries
    

Quick checks:

```sql
-- Who am I / from where
SELECT USER(), CURRENT_USER(), @@hostname, @@version_comment;

-- Current DB/files permissions posture
SHOW GRANTS FOR CURRENT_USER();

-- All users (requires privs)
SELECT user, host, plugin FROM mysql.user;

-- Find wide-open hosts
SELECT user, host FROM mysql.user WHERE host='%';

-- Sys summaries (example)
USE sys;
SELECT host, unique_users FROM host_summary;
```

---

## File Read/Write & RCE Primitives (when allowed)

Check `secure_file_priv`:

```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

If NULL or writable:

```sql
-- Read server files (needs FILE privilege)
SELECT LOAD_FILE('/etc/passwd');

-- Write to disk (web shell drop if webroot path is writable)
SELECT '<php code>' INTO OUTFILE '/var/www/html/shell.php';
```

UDF/Plugin abuse is version/OS-specific; modern MySQL 8 with `caching_sha2_password` hardens many paths—still check plugin directories and `INSTALL PLUGIN` privileges.

---

## Useful CLI Operations

### Connect

```bash
mysql -u <user> -p<pass> -h <IP>
```

### Core SQL

```sql
SHOW DATABASES;
USE <database>;
SHOW TABLES;
SHOW COLUMNS FROM <table>;
SELECT * FROM <table> LIMIT 10;
SELECT * FROM <table> WHERE <column>='<string>';
```

---

## Attack Flow (End-to-End)

1. **Discover**
    
    ```bash
    nmap -sV -sC -p3306 --script mysql* <IP>
    ```
    
    Note version, auth plugin, empty/valid accounts.
    
2. **Authenticate**
    
    - Try empty/guessable creds or those revealed by `mysql-brute`/`mysql-enum`.
        
3. **Enumerate**
    
    - `SHOW DATABASES;` → `USE <db>;` → `SHOW TABLES;` → data hunting.
        
    - Inspect `mysql.user`, `SHOW GRANTS`, plugins, and global variables.
        
4. **Escalate/Exploit**
    
    - Abuse FILE/OUTFILE if `secure_file_priv` permits.
        
    - Look for `%` host wildcard users and grant abuse:
        
        ```sql
        GRANT ALL ON *.* TO 'lowuser'@'%' IDENTIFIED BY 'pass';
        FLUSH PRIVILEGES;
        ```
        
        (Requires existing high privileges.)
        
5. **Loot**
    
    - Credentials, PII, API keys, app configs, password hashes.
        
    - Dump target tables:
        
        ```bash
        mysqldump -u <user> -p<pass> -h <IP> <db> > dump.sql
        ```
        

---

## Quick Reference: Nmap MySQL NSE Scripts

Common useful scripts in `--script mysql*`:

- `mysql-info` → banner, version, caps
    
- `mysql-brute` → brute accounts
    
- `mysql-enum` → enumerate users/databases (where possible)
    
- `mysql-empty-password` → detect empty root
    
- `mysql-users`, `mysql-variables`, `mysql-databases`, `mysql-dump-hashes` (when accessible)
    

---

## Fast One-Liners

### Probe version and plugin quickly

```bash
nmap -p3306 --script mysql-info <IP>
```

### Dump a DB (known creds)

```bash
mysqldump -u <user> -p<pass> -h <IP> <db> > <db>.sql
```

### Non-interactive query

```bash
mysql -u <user> -p<pass> -h <IP> -e "SHOW DATABASES;"
```

---

If you want, I can compress this into a printable one-page cheat sheet with only the commands and the minimal outputs.