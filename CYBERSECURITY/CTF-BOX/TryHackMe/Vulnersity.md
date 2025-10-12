# Enumeration

```bash
nmap -sv ip_address
```

![image.png](attachment:699bbc0f-803f-4f2e-bd31-ebd956717515:image.png)

## Directory Bruteforce

```bash
gobuster dir -u <http://10.10.120.83:3333> -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt
```

Identified the directory with an upload page

```bash
/internal/
```

# Exploitation

## Compromising the webserver