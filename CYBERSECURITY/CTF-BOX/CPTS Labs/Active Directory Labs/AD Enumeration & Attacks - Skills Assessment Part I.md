The complete course is [[Index |here]]
# Background
A team member started an External Penetration Test and was moved to another urgent project before they could finish. The team member was able to find and exploit a file upload vulnerability after performing recon of the externally-facing web server. Before switching projects, our teammate left a password-protected web shell (with the credentials: ***admin:My_W3bsH3ll_P@ssw0rd!)*** in place for us to start from in the /uploads directory. As part of this assessment, our client, Inlanefreight, has authorized us to see how far we can take our foothold and is interested to see what types of high-risk issues exist within the AD environment. Leverage the web shell to gain an initial foothold in the internal network. Enumerate the Active Directory environment looking for flaws and misconfigurations to move laterally and ultimately achieve domain compromise.

# Submit the contents of the flag.txt file on the administrator Desktop of the web server

## Nmap Scan
```
nmap -p- 10.129.202.242 -T4
```

