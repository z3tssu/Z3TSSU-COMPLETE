# Nikto

`Nikto` is a powerful open-source web server scanner. In addition to its primary function as a vulnerability assessment tool, `Nikto's` fingerprinting capabilities provide insights into a website's technology stack.

#### Install Nikto

```bash
z3tssu@htb[/htb]$ sudo apt update && sudo apt install -y perl
z3tssu@htb[/htb]$ git clone https://github.com/sullo/nikto
z3tssu@htb[/htb]$ cd nikto/program
z3tssu@htb[/htb]$ chmod +x ./nikto.p
```

#### Scan a target with Nikto

```bash
nikto -h inlanefreight.com -Tuning b
```
