

## Plugins

### What They Are

- **Third-party or built-in tools** that integrate directly with Metasploit.
    
- Extend functionality for:
    
    - Scanning (`Nessus`, `Nexpose`, `OpenVAS`)
        
    - Web testing (`sqlmap`)
        
    - Automation and custom workflows
        
- Interact with the framework via the **Metasploit API**.
    

---

### Plugin Directory

List available plugins:

```
ls /usr/share/metasploit-framework/plugins
```

**Example output:**

```
aggregator.rb      nessus.rb       sqlmap.rb      token_adduser.rb
db_credcollect.rb  openvas.rb      socket_logger.rb  ...
```

---

### Loading a Plugin

**Inside msfconsole:**

```
load nessus
```

**Output:**

```
[*] Nessus Bridge for Metasploit
[*] Type nessus_help for a command listing
[*] Successfully loaded Plugin: Nessus
```

Check plugin help:

```
nessus_help
```

**If plugin doesn’t exist:**

```
load Plugin_That_Does_Not_Exist
[-] Failed to load plugin... cannot load such file...
```

---

### Installing New Plugins

**Download from DarkOperator repo:**

```
git clone https://github.com/darkoperator/Metasploit-Plugins
ls Metasploit-Plugins
```

**Copy plugin to plugins directory:**

```
sudo cp ./Metasploit-Plugins/pentest.rb /usr/share/metasploit-framework/plugins/pentest.rb
```

**Load plugin in msfconsole:**

```
msfconsole -q
load pentest
```

**Output:**

```
Pentest Plugin loaded.
by Carlos Perez
[*] Successfully loaded plugin: pentest
```

---

### Example: pentest Plugin

**Check commands:**

```
help
```

**Command Categories:**

- **Discovery**  
    `network_discover`, `discover_db`, `pivot_network_discover`
    
- **Auto Exploit**  
    `show_client_side`, `vuln_exploit`
    
- **Post Exploitation**  
    `multi_post`, `sys_creds`, `multi_cmd`, `multi_meter_cmd`
    
- **Project Commands**  
    `project`
    
- **Tradecraft**  
    `check_footprint`
    

---

### Common Plugins

- `nessus` – Nessus vulnerability scanner integration
    
- `openvas` – OpenVAS scanning support
    
- `sqlmap` – Automates SQL injection tests
    
- `db_credcollect` – Collects and manages credentials
    
- `socket_logger` – Logs socket interactions
    

---

## Mixins

### What They Are

- **Ruby modules** that add shared methods to multiple classes.
    
- Used for **code reusability** without inheritance.
    

**Syntax:**

```ruby
include ModuleName
```

**Purpose:**

- Avoid rewriting common logic.
    
- Add reusable functionality to exploit, auxiliary, or payload modules easily.