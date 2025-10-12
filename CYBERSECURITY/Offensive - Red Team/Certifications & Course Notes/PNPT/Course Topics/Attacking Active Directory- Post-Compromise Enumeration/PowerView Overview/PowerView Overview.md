# Setting Up PowerView for Enumeration

## Overview

- **PowerView** is a PowerShell script used for in-depth domain enumeration.
- Ideal for attackers to gather information on the target environment.

---

## Steps to Install PowerView

1. **Download PowerView**:
    - Go to **GitHub** and search for "PowerView GitHub".
    - Choose between:
        - Deprecated `PowerTools` repository.
        - `PowerSploit` repository.
    - Download options:
        - Download all the tools (recommended for broader testing).
        - Download only the `PowerView` file:
            - Click the "Raw" option to copy the path.
            - Save the file locally.
                
                ![[PowerView(1).ps1]]
                
2. **Transfer to Target Environment**:
    - Move the `PowerView` script to a Windows 10 machine in your testing environment.
    - Place the file in a directory of your choice (e.g., Downloads).

---

## Usage Scenarios

- **Local Setup**:
    - Test PowerView locally for convenience:
        - Allows features like auto-tab completion.
        - Simplifies execution for learning.
- **Real-World Attack**:
    - Upload the script to the compromised machine.
    - Run the script from a PowerShell session initiated through an attacker’s shell.

---

## Execution Considerations

1. **Running PowerView**:
    - PowerView is run via PowerShell.
    - Designed for both local enumeration and use in attack scenarios.
2. **Remote Desktop Protocol (RDP)**:
    - Rarely will you use RDP in real attack scenarios:
        - Exceptions: Unused servers or machines where the user isn’t active.
    - Primary focus: Deploy and execute via command-line access.

---

## Next Steps

1. Transfer PowerView to your target Windows machine.
2. Load PowerShell and prepare to run the script.
3. Meet in the next session to begin enumerating the domain using PowerView.