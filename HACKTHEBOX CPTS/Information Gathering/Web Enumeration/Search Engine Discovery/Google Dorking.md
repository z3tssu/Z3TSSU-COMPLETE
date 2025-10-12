

---

## **1. Finding Login Pages**

```bash
site:example.com inurl:login
site:example.com (inurl:login OR inurl:admin)
```

**Use Case:** Detects login portals, admin panels, or entry points for web applications.

---

## **2. Identifying Exposed Files**

```bash
site:example.com filetype:pdf
site:example.com (filetype:xls OR filetype:docx)
```

**Use Case:** Finds publicly available files such as PDFs, spreadsheets, or Word documents.

---

## **3. Uncovering Configuration Files**

```bash
site:example.com inurl:config.php
site:example.com (ext:conf OR ext:cnf)
```

**Use Case:** Reveals configuration files that might include sensitive data like **database credentials** or **API keys**.

---

## **4. Locating Database Backups**

```bash
site:example.com inurl:backup
site:example.com filetype:sql
```

**Use Case:** Identifies database backups or dump files that could be downloaded and analyzed.