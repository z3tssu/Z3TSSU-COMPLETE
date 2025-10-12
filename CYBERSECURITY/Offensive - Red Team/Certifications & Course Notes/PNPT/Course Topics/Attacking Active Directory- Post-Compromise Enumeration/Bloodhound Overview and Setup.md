Here’s the markdown summary without code blocks except for commands or source code:

# Installing and Setting Up BloodHound

## What is BloodHound?

- **BloodHound** is a tool for **Active Directory (AD) enumeration**.
    - Automates collection and visualization of AD data.
    - Displays relationships in the domain as graphs.
    - Quickly identifies paths to privilege escalation, such as Domain Admin.
- **Developers**: Created by SpecterOps (Waldo, HarmJoy, CaptainJesus).

---

## Installation Process (New)

[https://support.bloodhoundenterprise.io/hc/en-us/articles/17468450058267-Install-BloodHound-Community-Edition-with-Docker-Compose](https://support.bloodhoundenterprise.io/hc/en-us/articles/17468450058267-Install-BloodHound-Community-Edition-with-Docker-Compose)

### **Command to Run the Docker Container**

```Shell
docker run -it --rm -p 7474:7474 -p 7687:7687 bloodhoundcommunity/bloodhound
```

**Explanation:**

- `it`: Runs the container interactively so you can see logs in the terminal.
- `-rm`: Automatically removes the container once it stops.
- `p 7474:7474`: Exposes the Neo4j web interface port on the host machine.
- `p 7687:7687`: Exposes the Neo4j Bolt protocol port on the host machine.
- `bloodhoundcommunity/bloodhound`: Specifies the BloodHound Docker image.

---

### **Persistent Data (Optional)**

If you want data stored in the container to persist, use the `-v` option to bind-mount a directory on your host for Neo4j data:

```Shell
docker run -it -p 7474:7474 -p 7687:7687 -v ~/bloodhound-data:/data bloodhoundcommunity/bloodhound
```

**Explanation:**

- `v ~/bloodhound-data:/data`: Saves data in the `~/bloodhound-data` directory on your host machine.

---

### **Stopping the Container**

- To stop the container, press `**Ctrl+C**` if it's running interactively.
- If the container was started in detached mode (using `d`), find it with:
    
    ```Shell
    docker ps
    ```
    
    Stop it with:
    
    ```Shell
    docker stop <container_id>
    ```
    

That's it! Let me know if you need help setting it up further.

## Installation Process (Old)

### Step 1: Install BloodHound

1. Run the following command on Kali Linux:
    
    ```Plain
    sudo apt install bloodhound
    ```
    
2. Note:
    - Requires ~353 MB of disk space.
    - Installation may take time based on system speed and internet connection.

---

### Step 2: Install Neo4j (Database Backend)

- **Neo4j**: A graph database BloodHound uses to process and display data.

1. Start the Neo4j service:
    
    ```Plain
    neo4j console
    ```
    
2. Access Neo4j’s local web interface:
    - Open a browser and navigate to:
        
        ```Plain
        http://localhost:7474
        ```
        
3. Log in with the default credentials:
    - **Username**: neo4j
    - **Password**: neo4j
4. Change the default password:
    - You will be prompted to set a new password for security.
    - Example: Use `password` (weak, but sufficient for demo setups).

---

## Step 3: Launch BloodHound

1. Start BloodHound:
    
    ```Plain
    bloodhound
    ```
    
2. In the BloodHound GUI:
    - **Login Credentials**:
        - **Username**: neo4j
        - **Password**: (password you set earlier).
    - Green checkmark confirms a successful database connection.
3. Initial state:
    - The interface will display: _"No data returned from the query"_.
    - This is expected until data is ingested.

---

## Next Steps

1. Use the **BloodHound ingestor** to collect AD data.
2. Analyze the ingested data to identify escalation paths and AD relationships.

---