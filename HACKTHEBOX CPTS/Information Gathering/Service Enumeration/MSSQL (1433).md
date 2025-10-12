

## **Basics**

- **MSSQL** is Microsoft’s SQL-based relational database management system.
    
- Closed source, originally for Windows but now available on Linux and MacOS.
    
- Often used with **.NET applications**.
    
- Commonly managed with **SQL Server Management Studio (SSMS)**, which can store credentials and be used remotely.
    
- Other clients:
    
    - `mssql-cli`
        
    - `SQL Server PowerShell`
        
    - `HeidiSQL`
        
    - `SQLPro`
        
    - `Impacket's mssqlclient.py`
        

### **Default System Databases**

|Database|Description|
|---|---|
|**master**|Tracks all system information for an SQL server instance.|
|**model**|Template for every new database created.|
|**msdb**|Used by SQL Server Agent to schedule jobs and alerts.|
|**tempdb**|Stores temporary objects.|
|**resource**|Read-only database containing system objects included with SQL server.|

[Reference: System Databases Microsoft Doc](https://docs.microsoft.com/en-us/sql/relational-databases/databases/system-databases?view=sql-server-ver15)

---

## **Default Configuration**

- SQL service often runs as `NT SERVICE\MSSQLSERVER`.
    
- Supports **Windows Authentication** by default.
    
- Encryption is **not enforced** unless configured.
    
- Authentication via Windows Authentication can lead to escalation if an account is compromised, especially in AD environments.
    

---

## **Dangerous Settings**

- Clients connecting without encryption.
    
- Use of **self-signed certificates** (vulnerable to spoofing).
    
- Use of **named pipes**.
    
- Weak or default `sa` credentials.
    

---

## **Locate `mssqlclient`**

```bash
locate mssqlclient
```

Output:

```
/usr/bin/impacket-mssqlclient
/usr/share/doc/python3-impacket/examples/mssqlclient.py
```

---

## **Nmap MSSQL Script Scan**

Use Nmap scripts to gather information:

```bash
sudo nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes \
--script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER \
-sV -p 1433 10.129.201.248
```

Example output:

```
PORT     STATE SERVICE  VERSION
1433/tcp open  ms-sql-s Microsoft SQL Server 2019 15.00.2000.00; RTM
| ms-sql-ntlm-info:
|   Target_Name: SQL-01
|   NetBIOS_Domain_Name: SQL-01
|   NetBIOS_Computer_Name: SQL-01
|   DNS_Domain_Name: SQL-01
|   DNS_Computer_Name: SQL-01
|_  Product_Version: 10.0.17763
| ms-sql-dac:
|_  Instance: MSSQLSERVER; DAC port: 1434 (connection failed)
| ms-sql-info:
|   Windows server name: SQL-01
|   10.129.201.248\MSSQLSERVER:
|     Instance name: MSSQLSERVER
|     Version:
|       name: Microsoft SQL Server 2019 RTM
|       number: 15.00.2000.00
|       Product: Microsoft SQL Server 2019
|       Service pack level: RTM
|       Post-SP patches applied: false
|     TCP port: 1433
|     Named pipe: \\10.129.201.248\pipe\sql\query
|_    Clustered: false
```

---

## **MSSQL Ping with Metasploit**

```bash
msf6 auxiliary(scanner/mssql/mssql_ping) > set rhosts 10.129.201.248
msf6 auxiliary(scanner/mssql/mssql_ping) > run
```

Output:

```
[*] 10.129.201.248:       - SQL Server information for 10.129.201.248:
[+] 10.129.201.248:       -    ServerName      = SQL-01
[+] 10.129.201.248:       -    InstanceName    = MSSQLSERVER
[+] 10.129.201.248:       -    IsClustered     = No
[+] 10.129.201.248:       -    Version         = 15.0.2000.5
[+] 10.129.201.248:       -    tcp             = 1433
[+] 10.129.201.248:       -    np              = \\SQL-01\pipe\sql\query
```

---

## **Connecting with `mssqlclient.py`**

When credentials are available:

```bash
python3 mssqlclient.py Administrator@10.129.201.248 -windows-auth
```

Example output:

```
Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

Password:
[*] Encryption required, switching to TLS
[*] ENVCHANGE(DATABASE): Old Value: master, New Value: master
[*] ENVCHANGE(LANGUAGE): Old Value: , New Value: us_english
[*] ENVCHANGE(PACKETSIZE): Old Value: 4096, New Value: 16192
[*] INFO(SQL-01): Line 1: Changed database context to 'master'.
[*] INFO(SQL-01): Line 1: Changed language setting to us_english.
[*] ACK: Result: 1 - Microsoft SQL Server (150 7208) 
[!] Press help for extra shell commands
```

List databases:

```sql
SQL> select name from sys.databases
```

Output:

```
master
tempdb
model
msdb
Transactions
```