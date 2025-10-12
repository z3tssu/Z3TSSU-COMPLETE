
## SSH-Audit

Check client and server configuration, including supported encryption algorithms.

```bash
git clone https://github.com/jtesta/ssh-audit.git && cd ssh-audit
./ssh-audit.py 10.129.14.132
```

---

## Change Authentication Method

View available authentication methods:

```bash
ssh -v cry0l1t3@10.129.14.132
```

Example output:

```
debug1: Authentications that can continue: publickey,password,keyboard-interactive
```

Force password authentication:

```bash
ssh -v cry0l1t3@10.129.14.132 -o PreferredAuthentications=password
```

Example output:

```
debug1: Authentications that can continue: publickey,password,keyboard-interactive
debug1: Next authentication method: password
cry0l1t3@10.129.14.132's password:
```