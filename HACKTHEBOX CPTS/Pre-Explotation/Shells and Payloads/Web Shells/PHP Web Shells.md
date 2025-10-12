https://app.gitbook.com/o/yaG9lrNlT0UmTITUeBmb/s/K3YP1U2Fck03eUZ2XijJ/cybersecurity-certifications-and-notes/certifications-and-courses/hackthebox-cpts/shells-and-payloads/web-shells/php-web-shells
## 1. Overview

- **PHP (Hypertext Preprocessor)** is the most widely used server-side scripting language, running on about **78.6% of web servers**.
    
- It processes dynamic content, such as login forms (e.g., `login.php` in platforms like rConfig).
    
- PHP web shells are typically used to:
    
    - Exploit **file upload vulnerabilities**.
        
    - Achieve **remote command execution (RCE)**.
        
    - Launch **reverse shells** for interactive access.
        

---

## 2. Objective

Exploit an **upload vulnerability** in **rConfig v3.9.6** to upload a **malicious PHP script disguised as an image**, then use it to gain a browser-accessible shell.

---

## 3. Exploitation Steps

### **Step 1: Access rConfig and Open the Vendor Upload Form**

1. Log in to rConfig:
    
    - Username: `admin`
        
    - Password: `admin`
        
2. Navigate to:
    
    ```
    Devices > Vendors > Add Vendor
    ```
    
3. Locate the **File Upload** option for the **Vendor Logo**.
    

---

### **Step 2: Prepare the PHP Web Shell**

**Tool Used:** [WhiteWinterWolf’s PHP Web Shell](https://github.com/WhiteWinterWolf/php-webshell)

1. Create the file:
    
    ```bash
    nano connect.php
    ```
    
2. Paste the shell code into the file.
    
3. **Best Practice:** Remove any author comments, ASCII art, or suspicious headers to reduce detection by AV or WAF.
    

---

### **Step 3: Intercept the Upload with Burp Suite**

1. Open **Burp Suite**.
    
2. Configure browser proxy:
    
    - **IP:** `127.0.0.1`
        
    - **Port:** `8080`
        
3. Go to the upload form in rConfig.
    
4. Select your PHP shell (`connect.php`) and click **Save** to trigger the upload.
    

---

### **Step 4: Modify the POST Request**

When Burp intercepts the upload request:

1. Find this header:
    
    ```
    Content-Type: application/x-php
    ```
    
2. Change it to:
    
    ```
    Content-Type: image/gif
    ```
    
3. Forward the request **twice** to submit it successfully.
    

---

### **Step 5: Confirm the Upload**

Look for the confirmation message:

```
Message: Added new vendor NetVen to Database
```

- If the upload succeeded but the icon looks like a generic image, that’s fine. The PHP script is still in place.
    

---

### **Step 6: Access the Web Shell**

Open the uploaded file in your browser:

```
http://<rConfig-IP>/images/vendor/connect.php
```

- You now have a **web interface** for command execution.
    

---

## 4. Usage

- Any command you enter in the web interface runs on the **underlying Linux operating system**.
    
- Examples:
    
    ```bash
    whoami
    id
    uname -a
    ```
    

---

## 5. Additional Notes

- Consider using a **reverse shell payload** through the PHP shell for a more interactive session.
    
- Always clean and obfuscate your uploaded PHP file to avoid detection.
    
- After exploitation, enumerate system information and escalate privileges if possible.
    

---

Would you like me to add a **cheat sheet of common PHP reverse shell commands** for quick reference?