
## 1. What is Laudanum

**Laudanum** is a collection of **pre-built, injectable web shells** designed for multiple web technologies.  
It supports:

- **ASP**
    
- **ASPX**
    
- **PHP**
    
- **JSP**
    

**Use Cases:**

- Uploading reverse shells
    
- Executing OS commands from a browser
    
- Achieving Remote Code Execution (RCE)
    

**Preinstalled On:**

- **Kali Linux**
    
- **Parrot OS**
    

---

## 2. Location

On Kali or Parrot OS:

```bash
/usr/share/laudanum
```

---

## 3. Usage Considerations

- Most shells **work out-of-the-box**.
    
- Some require:
    
    - Editing to set the attacker’s **IP address** (especially for reverse shells).
        
    - Removing ASCII art or comments to reduce antivirus detection.
        
- Always **read the file comments** before use to understand its behavior.
    

---

## 4. Steps to Use Laudanum

### **Step 1: Add Target Entry to `/etc/hosts`**

Edit `/etc/hosts` to map the target hostname:

```bash
sudo nano /etc/hosts
```

Example entry:

```
<target-ip> status.inlanefreight.local
```

---

### **Step 2: Copy and Modify the Web Shell**

Choose a web shell and copy it to your working directory:

```bash
cp /usr/share/laudanum/aspx/shell.aspx /home/tester/demo.aspx
```

Edit the shell file (for example, at line 59) and set your attacker's IP:

```csharp
string[] allowedIps = { "10.10.14.12" };
```

Optional: Remove comments or ASCII art to avoid detection by security tools.

---

### **Step 3: Upload the Shell**

Use the web application’s upload functionality:

- Navigate to the **upload section** of the site.
    
- Upload your edited `demo.aspx` shell.
    

Successful uploads will typically display the upload path:

```
\\files\demo.aspx
```

---

### **Step 4: Access the Web Shell**

Use your browser to navigate to the uploaded shell:

```
http://status.inlanefreight.local/files/demo.aspx
```

**Notes:**

- Double backslashes (`\\`) in paths are converted to slashes (`/`) in browsers.
    
- Some servers:
    
    - Keep the original filename.
        
    - Rename files (obfuscate).
        
    - Restrict direct access.
        

---

### **Step 5: Use the Shell**

Laudanum provides a simple **web form** interface to execute commands.

**Example:**

```
systeminfo
```

Click **Submit Query** to execute the command and view the output.

---

## 5. Summary of Features

- Built-in HTTP interface for command execution
    
- Preconfigured for common testing scenarios
    
- Works with minimal configuration
    
- Can be detected by antivirus or EDR → **strip signatures for stealth**
    

---

## 6. Next Steps

Once the shell is operational:

1. Perform basic reconnaissance:
    
    - `whoami`
        
    - `ipconfig`
        
    - `systeminfo`
        
2. Upload a reverse shell payload for persistent access.
    
3. Enumerate running services and local users.
    
4. Prepare for privilege escalation or lateral movement.
    

---

Would you like me to create a **quick-reference checklist** for setting up and using Laudanum shells during engagements?