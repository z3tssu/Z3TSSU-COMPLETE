
## **1. Anonymous Login**

Connect to the FTP server:

```bash
ftp <IP>
```

Example:

```bash
ftp 10.129.14.136
```

Login with:

```
Name: anonymous
Password: [hit Enter]
```

Successful login message:

```
230 Login successful.
```

---

## **2. Checking Directories & Status**

### **List Files**

```bash
ftp> ls
```

### **View Connection Status**

```bash
ftp> status
```

Shows connection info, mode, and interface details.

---

## **3. Recursive Listing**

List all directories and files recursively:

```bash
ftp> ls -R
```

Example output:

```
./Clients/HackTheBox:
appointments.xlsx
contract.docx
contract.pdf
meetings.txt
```

---

## **4. Download Files**

### **Single File**

Use `get`:

```bash
ftp> get Important\ Notes.txt
```

Check transfer:

```
226 Transfer complete.
```

---

### **Mirror Entire FTP Server**

Download everything with `wget`:

```bash
wget -m --no-passive ftp://anonymous:anonymous@<IP>
```

Example:

```bash
wget -m --no-passive ftp://anonymous:anonymous@10.129.14.136
```

Directory structure after download:

```bash
tree .
.
└── 10.129.14.136
    ├── Calendar.pptx
    ├── Clients
    │   └── Inlanefreight
    │       ├── appointments.xlsx
    │       ├── contract.docx
    │       ├── meetings.txt
    │       └── proposal.pptx
    ├── Documents
    │   ├── appointments-template.xlsx
    │   ├── contract-template.docx
    │   └── contract-template.pdf
    ├── Employees
    └── Important Notes.txt
```

---

## **5. Upload a File**

### **Create a Test File**

```bash
touch testupload.txt
```

### **Upload to Server**

```bash
ftp> put testupload.txt
```

Confirm upload:

```
226 Transfer complete.
```

Check with:

```bash
ftp> ls
```

Shows `testupload.txt` now on server.

---

## **6. Key Tips**

- Always check for **write permissions** (upload allowed = potential exploit path).
    
- Use `binary` mode for non-text files to avoid corruption:
    

```bash
ftp> binary
```

- Combine `wget` mirroring for full recon and `tree` for local file mapping.
    
- Anonymous login often means **misconfigured FTP** — good entry point for lateral movement or data exfiltration.
    
