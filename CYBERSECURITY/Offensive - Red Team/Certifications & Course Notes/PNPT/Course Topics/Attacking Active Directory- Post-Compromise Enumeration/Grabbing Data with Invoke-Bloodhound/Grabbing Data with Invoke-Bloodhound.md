Here’s a detailed markdown summary of the video on **Downloading and Setting Up a BloodHound Ingestor**:

# Setting Up a BloodHound Ingestor

## What is the Ingestor?

- A **BloodHound ingestor** collects Active Directory data for analysis in BloodHound.
- Several options for ingestors:
    - **Invoke-BloodHound**: PowerShell-based.
    - **SharpHound**: Written in C#.
    - **Python** based ingestors.

### This Guide:

- Focuses on **Invoke-BloodHound** for ease of use and flexibility.

---

## Step 1: Download the Ingestor

1. **Search for** `**Invoke-BloodHound**`:
    - Open GitHub and locate the file (e.g., `SharpHound.ps1`).
    - [https://github.com/SpecterOps/SharpHound](https://github.com/SpecterOps/SharpHound)
2. **Download the File**:
    - Save the script locally to use on your **Windows 10** machine.
3. **Prepare the Environment**:
    - Ensure the following machines are running:
        - Windows 10 client(s).
        - Windows Server 2016 with Active Directory.

---

## Step 2: Transfer the Ingestor Script

1. Move the `SharpHound.ps1` script to your **Windows 10 machine**.
2. Log into the machine to begin execution.

---

## Step 3: Execute the Ingestor

1. Open **PowerShell**:
    
    ```Plain
    powershell -ep bypass
    ```
    
2. Import the script:
    
    ```Plain
    . .\SharpHound.ps1
    ```
    
3. Run the `Invoke-BloodHound` command with the following parameters:
    
    ```Plain
    Invoke-BloodHound -CollectionMethod All -Domain marvel.local -ZipFileName file.zip
    ```
    
    - **Parameters**:
        
        - `CollectionMethod All`: Collects comprehensive domain information.
        - `Domain`: Specify your domain (e.g., `marvel.local`).
        - `ZipFileName`: Specify an output file name for the data (e.g., `file.zip`).
        
        ![[/image 70.png|image 70.png]]
        

---

## Step 4: Transfer the Collected Data

1. Locate the generated `.zip` file in the **Downloads folder** on the Windows machine.
    
    ![[/image 1 17.png|image 1 17.png]]
    
2. Transfer the file to your **Kali Linux** machine:
    - Move the file from the Windows desktop to your Kali machine.
    - I did this by sharing the Downloads folder on the Windows VM
        
        ![[/image 2 14.png|image 2 14.png]]
        
    - Then accessing and downloading the zip file via smbclient on the Linux VM
        
        ```PowerShell
        ┌─[✗]─[z3tssu@parrot]─[~]
        └──╼ $smbclient //192.168.213.130/Downloads -U MARVEL\\superuser
        Password for [MARVEL\superuser]:
        Try "help" to get a list of possible commands.
        smb: \> dir
          .                                  DR        0  Tue Dec 31 16:53:29 2024
          ..                                 DR        0  Tue Dec 31 16:53:29 2024
          desktop.ini                       AHS      282  Mon Dec 30 19:08:46 2024
          SharpHound-v2.0.0                   D        0  Tue Dec 31 17:08:57 2024
          SharpHound-v2.0.0.zip               A  2254452  Tue Dec 31 16:53:17 2024
          SharpHound-v2.5.9                   D        0  Tue Dec 31 17:06:48 2024
        
        		7779839 blocks of size 4096. 395032 blocks available
        smb: \> cd SharpHound-v2.0.0
        smb: \SharpHound-v2.0.0\> ls
          .                                   D        0  Tue Dec 31 17:08:57 2024
          ..                                  D        0  Tue Dec 31 17:08:57 2024
          20241231155346_BloodHound.zip       A    13591  Tue Dec 31 16:54:34 2024
          20241231160809_file.zip             A    13773  Tue Dec 31 17:08:57 2024
          SharpHound.exe                      A  1113600  Tue Dec 31 16:53:29 2024
          SharpHound.exe.config               A     1886  Tue Dec 31 16:53:29 2024
          SharpHound.pdb                      A   181760  Tue Dec 31 16:53:29 2024
          SharpHound.ps1                      A  1391826  Tue Dec 31 16:53:29 2024
          System.Console.dll                  A    34496  Tue Dec 31 16:53:29 2024
          System.Diagnostics.Tracing.dll      A    37096  Tue Dec 31 16:53:29 2024
          System.Net.Http.dll                 A   265048  Tue Dec 31 16:53:29 2024
          ZTRmYjljY2ItN2NiMC00NjNiLThlMTEtMDdhZWI5ZDQxZmZm.bin      A    10135  Tue Dec 31 17:08:57 2024
        
        		7779839 blocks of size 4096. 395032 blocks available
        smb: \SharpHound-v2.0.0\> get 20241231155346_BloodHound.zip 
        getting file \SharpHound-v2.0.0\20241231155346_BloodHound.zip of size 13591 as 20241231155346_BloodHound.zip (1474.7 KiloBytes/sec) (average 1474.7 KiloBytes/sec)
        smb: \SharpHound-v2.0.0\>
        ```
        

---

## Next Steps

- **Import the Data** into BloodHound.
- Review and analyze the imported details to identify privilege escalation paths.

---