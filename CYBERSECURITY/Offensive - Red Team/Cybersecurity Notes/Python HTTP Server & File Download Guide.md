> Useful for file transfer between attacker and target in CTFs, red teaming, or lab environments.

---

## Setup a Simple Python HTTP Server

### On Attacker or Target (serving files)

```Shell
python3 -m http.server 8080
```

- Serves files from the current directory
- Accessible via `http://<IP>:8080`

---

## Download Files Using `wget`

### Download a Single File

```Shell
wget http://<ip_address>:<port>/<filename>
```

### Download Entire Directory (Recursively)

```Shell
wget -m --no-parent http://<target-ip-or-domain>/
```

- `m` = mirror
- `-no-parent` = don’t follow links to parent directories

---