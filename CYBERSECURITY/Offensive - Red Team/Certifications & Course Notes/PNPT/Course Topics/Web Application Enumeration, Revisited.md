---
Status: Done
---
# Introduction

---

## Web Application Enumeration (Revisited)

### Overview

- **Revisiting Web Enumeration**:
    - Builds on previously covered tools (e.g., **Nmap**, **Nikto**, **DirBuster**, and **Burp Suite**).
    - Focus on additional tools and automation techniques.

### Goals of This Section

- **Go Language Tools**:
    - Focus on tools written in **Go**.
    - These tools will be integrated into a mini-script for automation.
- **Full Automation**:
    - Guide to creating a custom enumeration script.
    - Final script will be shared for users to modify and use for:
        - **Bug Bounties**
        - **Client Projects**
        - **Daily Enumeration Tasks**

### Enumeration Process Outline

1. **Subdomain Discovery**:
    - Utilizing Go-based tools instead of previously covered ones like **Sublist3r**.
2. **Subdomain Validation**:
    - Ensure discovered subdomains are active.
3. **Automated Screenshots**:
    - Capture screenshots of discovered subdomains for visual enumeration.
    - Allows quicker analysis without manually visiting each URL.
4. **Combining Tools & Scripts**:
    - Develop a comprehensive enumeration script.
    - Final script will be demonstrated and shared for customization.

### Next Steps

- **First Video**:
    - Covers the installation of **Go Language** as a prerequisite for upcoming tools.

---

# Installing Go

---

## Installing Go for Web Enumeration

### Step 1: Download Go

- Go to [GoLang's official download page](https://go.dev/dl/).
- Search for **Go Language** download.
- Download the **Linux version** (`amd64`).
- Save it to your **Downloads** folder.

### Step 2: Extracting Go Package

1. Open a terminal:
    
    ```Shell
    cd ~/Downloads
    ```
    
2. Extract the downloaded file:
    
    ```Shell
    sudo tar -xvf go<version>.tar.gz -C /usr/local
    ```
    
    - Replace `<version>` with your downloaded Go version (e.g., `go1.13.5`).

### Step 3: Change Ownership

- Set the correct permissions:
    
    ```Shell
    sudo chown -R root:root /usr/local/go
    ```
    

### Step 4: Update Environment Variables

1. Open `.profile` file using `gedit` or any text editor:
    
    ```Shell
    gedit ~/.profile
    ```
    
2. Add the following lines to the bottom:
    
    ```Shell
    export GOPATH=$HOME/go
    export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
    ```
    
3. Save and close the file.

### Step 5: Apply Changes

- Update the profile:
    
    ```Shell
    source ~/.profile
    ```
    

### Step 6: Verify Installation

1. Check if Go is available:
    
    ```Shell
    go version
    ```
    
    - Expected output: `go version go1.13.5 linux/amd64`
2. Confirm the `GOPATH` and `PATH`:
    
    ```Shell
    echo $PATH
    ```
    

  

---

# Finding Subdomains with AssetFinder

Here's the summarized notes from the provided video transcript on installing and using **Asset Finder**:

---

## Installing and Using Asset Finder for Subdomain Enumeration

### Overview

- Transitioning from **Sublist3r** to more efficient tools like **Asset Finder**.
- **Asset Finder** is a Go-based tool developed by **TomNomNom**, a prominent bug bounty hunter.

### Step 1: Installing Asset Finder

1. Open a terminal.
2. Install Asset Finder using the following command:
    
    ```Shell
    go install github.com/tomnomnom/assetfinder@latest
    ```
    
    - Ensure Go is set up correctly before running this command.
3. Verify installation:
    
    ```Shell
    assetfinder -h
    ```
    

### Step 2: Using Asset Finder

- To find subdomains for a target (e.g., `tesla.com`):
    
    ```Shell
    assetfinder tesla.com
    ```
    
- Save results to a file:
    
    ```Shell
    assetfinder tesla.com > tesla_subs.txt
    ```
    
- Count the number of subdomains found:
    
    ```Shell
    wc -l tesla_subs.txt
    ```
    

### Step 3: Filtering Subdomains

- By default, Asset Finder may return results beyond the specified domain (related assets).
- Use the `-subs-only` flag for more specific results:
    
    ```Shell
    assetfinder --subs-only tesla.com
    ```
    
- Alternatively, filter results with `grep`:
    
    ```Shell
    assetfinder tesla.com | grep 'tesla.com' > filtered_subs.txt
    ```
    

---

## Automating Asset Finder with a Bash Script

### Step 4: Creating an Automation Script

1. Create a new Bash script:
    
    ```Shell
    nano run.sh
    ```
    
2. Add the following code to automate subdomain discovery:
    
    ```Shell
    #!/bin/bash
    # Check if domain is provided
    if [ -z "$1" ]; then
      echo "Usage: ./run.sh <domain>"
      exit 1
    fi
    
    # Variables
    domain=$1
    mkdir -p $domain/recon
    
    # Run Asset Finder
    echo "Harvesting subdomains with Asset Finder..."
    assetfinder $domain > $domain/recon/assets.txt
    
    # Filter subdomains
    grep "$domain" $domain/recon/assets.txt > $domain/recon/final.txt
    rm $domain/recon/assets.txt
    
    # Output results
    echo "Subdomains found:"
    cat $domain/recon/final.txt
    ```
    
3. Make the script executable:
    
    ```Shell
    chmod +x run.sh
    ```
    
4. Run the script for a specific domain:
    
    ```Shell
    ./run.sh tesla.com
    ```
    

### Step 5: Script Explanation

- **Variables**:
    - `$domain`: Takes the first argument as the target domain.
    - Creates a `recon` folder to store output.
- **Commands**:
    - Uses `assetfinder` to gather subdomains.
    - Filters subdomains using `grep`.
    - Saves clean results to `final.txt`.

### Step 6: Verify the Output

- Check the output directory:
    
    ```Shell
    ls tesla.com/recon
    ```
    
- View the final list of subdomains:
    
    ```Shell
    cat tesla.com/recon/final.txt
    ```
    

# Finding Subdomains with Amass

---

## Installing and Using Amass for Subdomain Enumeration

### Overview

- **Amass** is another powerful tool for **subdomain discovery**, developed by **OWASP**.
- Using multiple tools (e.g., **Asset Finder** and **Amass**) can help discover more subdomains, increasing the effectiveness of web app assessments, bug bounties, and penetration tests.

### Why Use Multiple Subdomain Tools?

- Each tool uses different techniques for finding subdomains.
- Combining results from various tools ensures more comprehensive coverage.
- Helps in finding development or lesser-known subdomains that could be critical for assessments.

---

## Step 1: Installing Amass

1. **Download and Install Amass**:
    - Amass is another **Go-based tool**.
    - Installation commands:
        
        ```Shell
        go install -v github.com/owasp-amass/amass/v3/...@master
        ```
        
2. **Set Go Environment Variable** (if not already set):
    
    ```Shell
    export GO111MODULE=on
    ```
    
3. **Verify Installation**:
    
    ```Shell
    amass -h
    ```
    

---

## Step 2: Using Amass for Subdomain Discovery

- Basic usage to find subdomains for a target (e.g., `tesla.com`):
    
    ```Shell
    amass enum -d tesla.com
    ```
    
- This command can take some time as it performs extensive enumeration.

---

## Step 3: Integrating Amass into the Automation Script

### Adding Amass to the Existing Bash Script

1. Open the existing script (e.g., `run.sh`):
    
    ```Shell
    nano run.sh
    ```
    
2. Add Amass command to the script:
    
    ```Shell
    echo "Harvesting subdomains with Amass..."
    amass enum -d $domain > $domain/recon/amass.txt
    ```
    
3. Update the script to filter and combine results:
    
    ```Shell
    # Combine Amass results with Asset Finder
    cat $domain/recon/amass.txt >> $domain/recon/final.txt
    sort -u $domain/recon/final.txt -o $domain/recon/final.txt
    ```
    
4. Clean up intermediate files:
    
    ```Shell
    rm $domain/recon/amass.txt
    ```
    

### Updated Automation Script

```Shell
#!/bin/bash

# Check if domain is provided
if [ -z "$1" ]; then
  echo "Usage: ./run.sh <domain>"
  exit 1
fi

# Variables
domain=$1
mkdir -p $domain/recon

# Asset Finder
echo "Harvesting subdomains with Asset Finder..."
assetfinder $domain > $domain/recon/assets.txt
grep "$domain" $domain/recon/assets.txt > $domain/recon/final.txt
rm $domain/recon/assets.txt

# Amass
echo "Harvesting subdomains with Amass..."
amass enum -d $domain > $domain/recon/amass.txt

# Combine results
cat $domain/recon/amass.txt >> $domain/recon/final.txt
sort -u $domain/recon/final.txt -o $domain/recon/final.txt
rm $domain/recon/amass.txt

# Output results
echo "Final list of subdomains:"
cat $domain/recon/final.txt
```

1. **Make the script executable**:
    
    ```Shell
    chmod +x run.sh
    ```
    
2. **Run the updated script**:
    
    ```Shell
    ./run.sh tesla.com
    ```
    

---

# Finding Alive Domains with Httprobe

Here's the summarized notes from the provided video transcript on installing and using **httprobe** for identifying live hosts:

---

## Installing and Using httprobe for Subdomain Validation

### Overview

- **httprobe** is a tool developed by **TomNomNom** for checking if subdomains are alive.
- It sends **HTTP** and **HTTPS** requests to identified subdomains and reports back if they respond.
- This helps filter out inactive subdomains, focusing on only those that are live.

---

## Step 1: Installing httprobe

1. Open a terminal.
2. Install httprobe using the following command:
    
    ```Shell
    go install github.com/tomnomnom/httprobe@latest
    ```
    
3. Verify installation:
    
    ```Shell
    httprobe -h
    ```
    

---

## Step 2: Using httprobe to Validate Live Subdomains

- Assuming you have a list of subdomains saved in `final.txt` (e.g., from **Asset Finder** or **Amass**):
    
    ```Shell
    cat tesla.com/recon/final.txt | httprobe
    ```
    
- Save the results to a file:
    
    ```Shell
    cat tesla.com/recon/final.txt | httprobe > tesla.com/recon/alive.txt
    ```
    

### Optional: Restrict Ports

- By default, httprobe checks common ports (80, 443). You can limit it to only HTTPS (443) if needed:
    
    ```Shell
    cat tesla.com/recon/final.txt | httprobe -p https:443
    ```
    

---

## Step 3: Automating with a Bash Script

### Enhancing the Existing Automation Script

1. Open your script (e.g., `run.sh`):
    
    ```Shell
    nano run.sh
    ```
    
2. Add **httprobe** command to validate live subdomains:
    
    ```Shell
    echo "Probing for alive domains..."
    cat $domain/recon/final.txt | sort -u | httprobe | sed 's/https\\?:\\/\\///' | sed 's/:443//' > $domain/recon/alive.txt
    ```
    
3. Updated Script Section:
    
    ```Shell
    #!/bin/bash
    
    # Check if domain is provided
    if [ -z "$1" ]; then
      echo "Usage: ./run.sh <domain>"
      exit 1
    fi
    
    # Variables
    domain=$1
    mkdir -p $domain/recon
    
    # Asset Finder
    echo "Harvesting subdomains with Asset Finder..."
    assetfinder $domain > $domain/recon/assets.txt
    grep "$domain" $domain/recon/assets.txt > $domain/recon/final.txt
    rm $domain/recon/assets.txt
    
    # Amass
    echo "Harvesting subdomains with Amass..."
    amass enum -d $domain >> $domain/recon/final.txt
    
    # Sort and get unique subdomains
    sort -u $domain/recon/final.txt -o $domain/recon/final.txt
    
    # httprobe to find live domains
    echo "Probing for alive domains..."
    cat $domain/recon/final.txt | httprobe | sed 's/https\\?:\\/\\///' | sed 's/:443//' > $domain/recon/alive.txt
    
    # Output results
    echo "Alive subdomains:"
    cat $domain/recon/alive.txt
    ```
    
4. **Make the script executable**:
    
    ```Shell
    chmod +x run.sh
    ```
    
5. **Run the updated script**:
    
    ```Shell
    ./run.sh tesla.com
    ```
    

---

## Step 4: Reviewing Results

- Check the output file for live subdomains:
    
    ```Shell
    cat tesla.com/recon/alive.txt
    ```
    
- Use `grep` to find specific types of subdomains (e.g., dev, test, staging):
    
    ```Shell
    grep 'dev' tesla.com/recon/alive.txt
    ```
    

### Example Searches:

- `grep 'admin' tesla.com/recon/alive.txt`
- `grep 'staging' tesla.com/recon/alive.txt`

---

# Screenshotting Websites with GoWitness

Here's the summarized notes from the provided video transcript on installing and using **gowitness** for visual enumeration:

---

## Installing and Using gowitness for Subdomain Screenshots

### Overview

- **gowitness** is a Go-based tool for taking screenshots of websites.
- It is a modern alternative to the older **Eyewitness** tool.
- Useful for quickly identifying interesting targets, such as login pages or admin panels, without manually visiting each URL.

---

## Step 1: Installing gowitness

1. Open a terminal.
2. Install gowitness using the following command:
    
    ```Shell
    go install github.com/sensepost/gowitness@latest
    ```
    
3. Verify installation:
    
    ```Shell
    gowitness -h
    ```
    

---

## Step 2: Using gowitness for Screenshots

- Take a screenshot of a single domain (e.g., `tesla.com`):
    
    ```Shell
    gowitness single --url <https://tesla.com>
    ```
    
- By default, the screenshot will be saved in the current directory.

### Example of Directory Listing After Running gowitness:

- The output might look like:
    
    ```Plain
    https_tesla.com.png
    ```
    

### Using gowitness with a List of URLs

- Assuming you have a list of live subdomains saved in `alive.txt`:
    
    ```Shell
    gowitness file -f tesla.com/recon/alive.txt
    ```
    
- This command will take screenshots of all URLs listed in `alive.txt`.

---

## Step 3: Integrating gowitness into the Automation Script

### Enhancing the Existing Automation Script

1. Open your script (e.g., `run.sh`):
    
    ```Shell
    nano run.sh
    ```
    
2. Add **gowitness** command to take screenshots of live domains:
    
    ```Shell
    echo "Taking screenshots of live domains..."
    gowitness file -f $domain/recon/alive.txt
    ```
    
3. Updated Script Section:
    
    ```Shell
    #!/bin/bash
    
    # Check if domain is provided
    if [ -z "$1" ]; then
      echo "Usage: ./run.sh <domain>"
      exit 1
    fi
    
    # Variables
    domain=$1
    mkdir -p $domain/recon
    
    # Asset Finder
    echo "Harvesting subdomains with Asset Finder..."
    assetfinder $domain > $domain/recon/assets.txt
    grep "$domain" $domain/recon/assets.txt > $domain/recon/final.txt
    rm $domain/recon/assets.txt
    
    # Amass
    echo "Harvesting subdomains with Amass..."
    amass enum -d $domain >> $domain/recon/final.txt
    
    # Sort and get unique subdomains
    sort -u $domain/recon/final.txt -o $domain/recon/final.txt
    
    # httprobe to find live domains
    echo "Probing for alive domains..."
    cat $domain/recon/final.txt | httprobe | sed 's/https\\?:\\/\\///' | sed 's/:443//' > $domain/recon/alive.txt
    
    # gowitness for screenshots
    echo "Taking screenshots of live domains..."
    gowitness file -f $domain/recon/alive.txt
    
    # Output results
    echo "Screenshots saved in the current directory."
    ```
    
4. **Make the script executable**:
    
    ```Shell
    chmod +x run.sh
    ```
    
5. **Run the updated script**:
    
    ```Shell
    ./run.sh tesla.com
    ```
    

---

## Step 4: Reviewing Screenshots

- The screenshots will be saved in the current working directory or the specified folder.
- You can open these images to quickly identify interesting targets:
    
    ```Shell
    ls *.png
    ```
    

### Benefits of Using gowitness

- Saves time by providing a visual representation of multiple domains at once.
- Helps in prioritizing targets based on visual inspection, such as login forms, admin panels, or error pages.

---

# Automating the Enumeration Process

---

## Overview of the Automated Enumeration Script

### Author

- The script was originally written by **Karimi**, also known as **that one Tester**.
- The script is highly recommended due to its efficiency and comprehensiveness.
- A link to the script on **Pastebin** will be provided, allowing users to access and modify it.

---

### Key Features of the Script

1. **Subdomain Enumeration**
    - Utilizes multiple tools for finding subdomains:
        - **Asset Finder**
        - **Amass**
    - Collects subdomains and stores them in files.
2. **Live Domain Probing**
    - Uses **httprobe** to check which subdomains are alive.
    - Filters and sorts the results into an `alive.txt` file.
3. **Subdomain Takeover Detection**
    - Scans for potential **subdomain takeovers** using tools like **subjack**.
    - Checks if subdomains can be hijacked due to misconfigured DNS records or expired subdomain ownership.
4. **Port Scanning**
    - Runs **Nmap** to detect open ports on the identified subdomains.
    - Goes beyond standard ports (80, 443) to identify other services (e.g., **3389** for RDP).
5. **Wayback Machine Data Extraction**
    - Scrapes historical data using **Wayback URLs** from **[archive.org](http://archive.org/)**.
    - Searches for old files, parameters, or sensitive data (like **credentials** or **API keys**) that may still be valid.
6. **Automated Screenshots**
    - Uses **gowitness** to take screenshots of all alive subdomains.
    - Saves screenshots for quick visual inspection of websites.
    - Helps in identifying interesting targets like login pages or admin panels.

---

### How the Script Enhances Penetration Testing

- **Automation**: Allows testers to automate repetitive tasks, saving time and increasing efficiency.
- **Comprehensive Enumeration**: Combines various tools to ensure no subdomains, ports, or sensitive data are missed.
- **Hands-Free Operation**: Enables multitasking, allowing testers to focus on other aspects of the assessment while the script runs in the background.

---

## Example Automation Workflow in the Script

1. **Asset Finder** and **Amass** for subdomain discovery:
    
    ```Shell
    assetfinder $domain > $domain/recon/assets.txt
    amass enum -d $domain >> $domain/recon/assets.txt
    ```
    
2. **Check for Live Subdomains**:
    
    ```Shell
    cat $domain/recon/assets.txt | httprobe > $domain/recon/alive.txt
    ```
    
3. **Check for Subdomain Takeover**:
    
    ```Shell
    subjack -w $domain/recon/alive.txt -t 100 -timeout 30 -ssl -c ~/fingerprints.json -v 3
    ```
    
4. **Port Scanning**:
    
    ```Shell
    nmap -iL $domain/recon/alive.txt -T4 -p- --open > $domain/recon/ports.txt
    ```
    
5. **Wayback Data Extraction**:
    
    ```Shell
    waybackurls $domain > $domain/recon/wayback.txt
    ```
    
6. **Screenshots with gowitness**:
    
    ```Shell
    gowitness file -f $domain/recon/alive.txt
    ```
    

---

### Benefits of Using the Script

- **Efficiency**: Saves time by automating the enumeration process.
- **Scalability**: Can be run against large scopes (e.g., bug bounty programs) with minimal manual effort.
- **Customization**: The script is modular, allowing users to modify or extend functionality based on their needs.

---

### Next Steps

- The course will now transition into **Web Application Penetration Testing**.
- Upcoming topics include:
    - **Burp Suite** in-depth usage.
    - Coverage of the **OWASP Top 10** web vulnerabilities.
    - Practical demonstrations of web attack techniques.

---

These notes summarize the complete functionality of the automated script, its benefits, and how it integrates with a penetration testing workflow. I'll save this in a `.txt` file for you if needed.