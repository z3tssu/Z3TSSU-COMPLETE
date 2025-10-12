Got it. Here are the hacker notes split cleanly by protocol.

# POP3 Notes

## Ports

- 110 (POP3, plain)
    
- 995 (POP3S, TLS)
    

## Nmap

```bash
sudo nmap -sV -sC -p110,995 10.129.14.128
# Look for: Dovecot pop3d, STLS/SSL cert CN/mail1.inlanefreight.htb, capabilities
```

## TLS Enumeration (OpenSSL)

```bash
openssl s_client -connect 10.129.14.128:pop3s
# Expect: +OK banner, TLSv1.3, self-signed cert, CN=mail1.inlanefreight.htb
```

## curl (POP3S)

```bash
curl -k 'pop3s://10.129.14.128' --user robin:robin
# With POP3, curl typically retrieves/list messages when combined with -X or URL paths.
# Examples:
curl -k --user robin:robin 'pop3s://10.129.14.128/1'   # fetch message 1
curl -k --user robin:robin 'pop3s://10.129.14.128/;STAT'  # stats (messages/count)
```

## Plain-Text Upgrade (STARTTLS) with ncat (if supported)

```bash
ncat 10.129.14.128 110
# STLS to upgrade, then POP3 commands
```

## Useful POP3 Commands (manual session)

```
USER robin
PASS robin
STAT
LIST
RETR 1
TOP 1 20
DELE 1
QUIT
```

## Attack Flow (POP3)

1. Enumerate ports/services and SSL cert details.
    
2. Try weak creds (e.g., robin:robin).
    
3. List/preview messages (TOP) for credentials, reset links, tokens.
    
4. Retrieve full messages (RETR) and exfiltrate artifacts.
    

---

# IMAP Notes

## Ports

- 143 (IMAP, plain; supports STARTTLS)
    
- 993 (IMAPS, TLS)
    

## Nmap

```bash
sudo nmap -sV -sC -p143,993 10.129.14.128
# Look for: Dovecot imapd, STARTTLS/SSL, capabilities (IMAP4rev1, IDLE, LITERAL+, AUTH=PLAIN)
# SSL cert CN: mail1.inlanefreight.htb (self-signed)
```

## TLS Enumeration (OpenSSL)

```bash
openssl s_client -connect 10.129.14.128:imaps
# Expect: * OK banner, TLSv1.3, self-signed cert details
```

## curl (IMAPS)

```bash
curl -k 'imaps://10.129.14.128' --user robin:robin
# Typical output includes mailbox list entries (e.g., INBOX, Important)
# Verbose to view TLS and server capabilities:
curl -k -v 'imaps://10.129.14.128' --user robin:robin
```

## STARTTLS on 143 (optional)

```bash
openssl s_client -starttls imap -connect 10.129.14.128:143
```

## Useful IMAP Commands (manual session via OpenSSL)

```
tag0 LOGIN robin robin
tag1 LIST "" "*"
tag2 SELECT "DEV.DEPARTMENT.INT"
tag3 FETCH 1 (BODY[])
tag4 FETCH 1 BODY[HEADER]
tag5 SEARCH ALL
tag6 LOGOUT
```

### Example Outputs (key points)

- LIST shows folders such as:
    
    - DEV
        
    - DEV.DEPARTMENT
        
    - DEV.DEPARTMENT.INT
        
    - INBOX
        
- FETCH reveals full message body/headers (e.g., sender [devadmin@inlanefreight.htb](mailto:devadmin@inlanefreight.htb) and sensitive content/flags).
    

## Attack Flow (IMAP)

1. Enumerate service, capture SSL cert metadata (CN/org), and capabilities.
    
2. Attempt weak creds (robin:robin).
    
3. LIST all mailboxes, SELECT interesting ones (DEV.*).
    
4. FETCH messages to extract flags, creds, internal addresses, reset links.
    
5. Pivot: use discovered identities to access other services or perform authenticated phishing.
    

---

## Quick One-Liners

- Full POP3S handshake and read:
    

```bash
openssl s_client -connect 10.129.14.128:pop3s <<< $'USER robin\r\nPASS robin\r\nSTAT\r\nLIST\r\nRETR 1\r\nQUIT\r\n'
```

- Full IMAPS login and read mailbox:
    

```bash
{ printf "tag0 LOGIN robin robin\r\n"; \
  printf "tag1 LIST \"\" \"*\"\r\n"; \
  printf "tag2 SELECT \"DEV.DEPARTMENT.INT\"\r\n"; \
  printf "tag3 FETCH 1 (BODY[])\r\n"; \
  printf "tag4 LOGOUT\r\n"; } \
| openssl s_client -quiet -connect 10.129.14.128:imaps
```

If you want, I can compress this into a single printable cheat sheet.