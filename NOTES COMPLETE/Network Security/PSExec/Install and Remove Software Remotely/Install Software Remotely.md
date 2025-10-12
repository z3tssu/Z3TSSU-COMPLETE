
```bash
psexec -is \\PMC-IT-Nelson msiexec /i "\\10.136.69.10\Volume_1\IT Support\PROGRAMS\INTERNET BROWSERS\ChromeMSI.msi" /qn

```

- This will install software on **PMC-IT-Nelson** machine
- The application needs to be **MSI package**
- The application is stored on the shared drive (**10.136.69.10**)