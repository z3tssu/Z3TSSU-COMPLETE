# Web Application Firewall (Wafw00f)

Before proceeding with further fingerprinting, it's crucial to determine if `inlanefreight.com` employs a WAF, as it could interfere with our probes or potentially block our requests.

#### Install Wafw00f

```bash
pip3 install git+https://github.com/EnableSecurity/wafw00f
```

#### Testing a Website for a Waf

```bash
wafw00f inlanefreight.com
```
