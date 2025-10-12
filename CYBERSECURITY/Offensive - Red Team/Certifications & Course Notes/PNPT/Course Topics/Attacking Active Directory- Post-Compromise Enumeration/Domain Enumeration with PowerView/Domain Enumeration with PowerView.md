# PowerView Usage for Domain Enumeration

  

[PowerView Cheat-sheet](https://gist.github.com/HarmJ0y/184f9822b195c52dd50c379ed3117993)

## Key Setup

1. **Preparation**:
    - Load a Command Prompt.
    - Navigate to the directory containing `PowerView.ps1` (e.g., Downloads).
2. **Execution Policy Bypass**:
    - Run PowerShell with execution policy bypass:
        
        ```Plain
        powershell -ep bypass
        ```
        
    - **Note**: The execution policy is bypassed to allow scripts to execute. This is not a security measure but a safeguard to prevent accidental script execution.
3. **Running PowerView**:
    - Use the following command:
        
        ```Plain
        . .\PowerView.ps1
        ```
        
    - No output indicates the script has loaded successfully.

---

## Key Commands

### 1. **Domain Information**

- Retrieve basic domain information:
    
    ```Plain
    Get-NetDomain
    ```
    
    ![[/image 69.png|image 69.png]]
    
- Get information about domain controllers:
    
    ```Plain
    Get-NetDomainController
    ```
    

### 2. **Domain Policies**

- Fetch domain policies:
    
    ```Plain
    Get-DomainPolicy
    ```
    
- Example: Retrieve system access policies:
    
    ```Plain
    (Get-DomainPolicy)."system access"
    ```
    

### 3. **Users**

- List all users in the domain:
    
    ```Plain
    Get-NetUser
    ```
    
    - Tip: Filter for relevant details, e.g.:
        
        ```Plain
        Get-NetUser | Select Name, Description
        ```
        
    - Filter for only usernames
        
        ```Bash
        Get-NetUser | Select cn
        ```
        
- Extract user properties:
    
    ```Plain
    Get-UserProperty
    ```
    
    - Example: Retrieve `PasswordLastSet`:
        
        ```Plain
        Get-UserProperty -Properties pwdlastset
        ```
        

### 4. **Computers**

- List computers in the domain:
    
    ```PowerShell
    Get-NetComputer
    
    PS C:\controlled> Get-NetComputer
    Hydra-DC.marvel.local
    Punisher.marvel.local
    IronMan.marvel.local
    ```
    
- Fetch detailed data for computers: 
    
    ```PowerShell
    Get-NetComputer -FullData
    ```
    
- Fetch detailed data for computers based on Operating System:
    
    ```PowerShell
    PS C:\controlled> Get-NetComputer -FullData | select OperatingSystem
    
    operatingsystem
    ---------------
    Windows Server 2019 Standard
    Windows 10 Education
    Windows 10 Education
    ```
    

### 5. **Groups**

- List all groups in the domain:
    
    ```Plain
    Get-NetGroup
    ```
    
- Fetch members of a specific group:
    
    ```Plain
    Get-NetGroupMember -GroupName "Domain Admins"
    ```
    

### 6. **Group Policy Objects (GPOs)**

- Retrieve all GPOs in the domain:
    
    ```Plain
    Get-NetGPO
    ```
    
- Example: Show display names and last modification times:
    
    ```Plain
    Get-NetGPO | Select DisplayName, WhenChanged
    ```
    

### 7. **Shares**

- Identify network shares:
    
    ```Plain
    Invoke-ShareFinder
    ```
    

---

## Tips and Use Cases

1. **Practical Uses**:
    - Extract domain details for attack planning.
    - Identify weak policies (e.g., short password lengths).
    - Locate domain controllers, sensitive accounts, or group memberships.
    - Spot potential attack targets (e.g., users, groups, shares).
    - Detect stale or honeypot accounts by analyzing login activity.
2. **Efficient Filtering**:
    - Use `Select` to extract relevant data fields.
    - Narrow down large outputs in enterprise environments to actionable insights.

---

## Recommendations

- Experiment with **PowerView** commands in your lab to practice enumeration.
- Reference guides and cheat sheets to explore advanced features.
- Take detailed notes on command outputs for analysis.

---

## Next Steps

- Transition to **BloodHound** for graphical domain mapping and privilege escalation pathways.