
### On the machine you are connecting from, test the connection

```Powershell

Test-WSMan IP_Address

```


### Start a remote session

```Powershell
Enter-PSSession -ComputerName Hostname/Ipaddress -Credential username@domain
```

