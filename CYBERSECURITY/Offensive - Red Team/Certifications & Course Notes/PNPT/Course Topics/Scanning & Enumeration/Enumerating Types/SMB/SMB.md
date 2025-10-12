> SMB is a file share protocol

  

# Metasploit Framework to enumerate SMB

- Open terminal and Type:
    
    ```JavaScript
    msfconsole
    ```
    
    ![[/image 67.png|image 67.png]]
    

1. search for ==smb==

- Once you have identified a module you want to use
    1. Copy the module string or
    2. The module number
- Enter the command ==use (module path string/number)==
    
    ```JavaScript
    use auxiliary/scanner/smb/smb_version
    ```
    
- Type ==info/options==
    1. It will list the info that is available
        
        ![[/image 1 15.png|image 1 15.png]]
        
- Enter the ==RHOSTS== option
    
    ```JavaScript
    set RHOSTS ip_address
    ```
    
- Type ==run==
    - This will run the script
        
        ![[/image 2 13.png|image 2 13.png]]
        
- Results
    - It will find the ==smb version==
        
        ![[/image 3 11.png|image 3 11.png]]
        
          
        

# smbclient - Connect to file share

- This tool will allow us to connect to a file share

- List out file shares
    
    ```JavaScript
    smbclient -L \\\\ip_address\\
    ```
    
    ![[/image 4 8.png|image 4 8.png]]
    
- Connect to File shares
    
    ```JavaScript
    smbclient \\\\Ip_address\\Share_Name
    ```
    
      
    
- Kioptrix Lab SMB File share access (IPC Share)
    
    ```JavaScript
    smbclient \\\\ipaddress\\IPC
    ```
    
    ![[/image 5 8.png|image 5 8.png]]
    
- Navigating smb
    
    ```JavaScript
    help 
    ```
    

## smbclient - Connect to a share file via a Domain User

```PowerShell
┌─[✗]─[z3tssu@parrot]─[~]
└──╼ $smbclient //PUNISHER/Downloads -U MARVEL\\superuser
Password for [MARVEL\superuser]:
Try "help" to get a list of possible commands.
smb: \> ls
  .                                  DR        0  Mon Dec 30 21:03:09 2024
  ..                                 DR        0  Mon Dec 30 21:03:09 2024
  desktop.ini                       AHS      282  Mon Dec 30 19:08:46 2024
  SharpHound-v2.5.9                   D        0  Tue Dec 31 14:52:07 2024

		7779839 blocks of size 4096. 437384 blocks available
smb: \> cd SharpHound-v2.5.9\
smb: \SharpHound-v2.5.9\> ls
  .                                   D        0  Tue Dec 31 14:52:07 2024
  ..                                  D        0  Tue Dec 31 14:52:07 2024
  20241231135207_extract.zip          A    36292  Tue Dec 31 14:52:07 2024
  SharpHound.exe                      A  1557504  Mon Dec 30 20:36:23 2024
  SharpHound.exe.config               A     1886  Mon Dec 30 20:36:23 2024
  SharpHound.pdb                      A   212480  Mon Dec 30 20:36:23 2024
  SharpHound.ps1                      A  1942029  Mon Dec 30 20:36:23 2024
  System.Console.dll                  A    34496  Mon Dec 30 20:36:23 2024
  System.Diagnostics.Tracing.dll      A    37096  Mon Dec 30 20:36:23 2024
  System.Net.Http.dll                 A   265048  Mon Dec 30 20:36:23 2024
  ZTRmYjljY2ItN2NiMC00NjNiLThlMTEtMDdhZWI5ZDQxZmZm.bin      A     2151  Tue Dec 31 14:52:07 2024

		7779839 blocks of size 4096. 437384 blocks available
smb: \SharpHound-v2.5.9\>
```

## Copy a file from an SMB Share

```PowerShell
smb: \> cd SharpHound-v2.5.9\
smb: \SharpHound-v2.5.9\> ls
  .                                   D        0  Tue Dec 31 14:52:07 2024
  ..                                  D        0  Tue Dec 31 14:52:07 2024
  20241231135207_extract.zip          A    36292  Tue Dec 31 14:52:07 2024
  SharpHound.exe                      A  1557504  Mon Dec 30 20:36:23 2024
  SharpHound.exe.config               A     1886  Mon Dec 30 20:36:23 2024
  SharpHound.pdb                      A   212480  Mon Dec 30 20:36:23 2024
  SharpHound.ps1                      A  1942029  Mon Dec 30 20:36:23 2024
  System.Console.dll                  A    34496  Mon Dec 30 20:36:23 2024
  System.Diagnostics.Tracing.dll      A    37096  Mon Dec 30 20:36:23 2024
  System.Net.Http.dll                 A   265048  Mon Dec 30 20:36:23 2024
  ZTRmYjljY2ItN2NiMC00NjNiLThlMTEtMDdhZWI5ZDQxZmZm.bin      A     2151  Tue Dec 31 14:52:07 2024

		7779839 blocks of size 4096. 444352 blocks available
smb: \SharpHound-v2.5.9\> get 20241231135207_extract.zip 
getting file \SharpHound-v2.5.9\20241231135207_extract.zip of size 36292 as 20241231135207_extract.zip (7088.1 KiloBytes/sec) (average 7088.3 KiloBytes/sec)
smb: \SharpHound-v2.5.9\>
```