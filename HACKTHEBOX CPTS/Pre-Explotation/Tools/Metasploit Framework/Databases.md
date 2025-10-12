
## Purpose

- Tracks **scan results, credentials, and vulnerabilities**
    
- Integrates with **third-party tools** like Nmap and Nessus
    
- Allows **reuse of saved data** for configuring exploits
    

---

## Setting Up the Database

**1. Check PostgreSQL status**

```
sudo service postgresql status
```

**2. Start PostgreSQL**

```
sudo systemctl start postgresql
```

**3. Initialize Metasploit DB**

```
sudo msfdb init
```

If errors (e.g., `NoMethodError`):

```
sudo apt update && sudo apt upgrade
sudo msfdb init
```

**4. Check database status**

```
sudo msfdb status
```

**5. Start Metasploit with DB**

```
sudo msfdb run
```

---

## Inside msfconsole

**Check DB Connection**

```
db_status
```

**Reinitialize DB**

```
msfdb reinit
cp /usr/share/metasploit-framework/config/database.yml ~/.msf4/
sudo service postgresql restart
msfconsole -q
```

---

## Workspaces

**Commands**

```
workspace            # List all
workspace -a NAME    # Add workspace
workspace NAME       # Switch to workspace
workspace -d NAME    # Delete workspace
workspace -h         # Help
```

---

## Importing Nmap Scans

**Preferred format:** `.xml`

**Import results**

```
db_import Target.xml
hosts
services
```

**Run Nmap directly**

```
db_nmap -sV -sS 10.10.10.8
```

---

## Exporting Data

```
db_export -f xml backup.xml
```

---

## Key Commands

|Command|Description|
|---|---|
|`hosts`|Manage discovered hosts|
|`hosts -h`|Help for hosts command|
|`services`|View open services|
|`services -h`|Help for services command|
|`creds`|Manage credentials|
|`creds -h`|Help for creds command|
|`creds add user:admin password:pass123`|Add credentials manually|
|`loot`|View captured data|