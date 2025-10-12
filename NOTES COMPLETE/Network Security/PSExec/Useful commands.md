
1. **Remote Command Execution:**
   You can execute commands on remote systems without needing to physically access them.

   Command:
   ```bash
   psexec \\RemoteComputerName -u Username -p Password CommandToRun
   ```
   Example:
   ```bash
   psexec \\Server01 -u Administrator -p Pass123 ipconfig /all
   ```

2. **Installing/Updating Software:**
   You can remotely install or update software across multiple computers.

   Command:
   ```bash
   psexec \\RemoteComputerName -u Username -p Password msiexec /i "Path\to\Installer.msi" /qn
   ```
   Example:
   ```bash
   psexec \\Workstation01 -u AdminUser -p AdminPass msiexec /i "C:\Installers\app.msi" /qn
   ```

3. **Running Scripts:**
   You can execute scripts on remote systems to automate tasks.

   Command:
   ```bash
   psexec \\RemoteComputerName -u Username -p Password "Path\to\Script.bat"
   ```
   Example:
   ```bash
   psexec \\ClientPC -u SupportAdmin -p Pass123 "C:\Scripts\backup_script.bat"
   ```

4. **Retrieving System Information:**
   You can gather system information remotely.

   Command:
   ```bash
   psexec \\RemoteComputerName -u Username -p Password systeminfo
   ```
   Example:
   ```bash
   psexec \\Server02 -u AdminUser -p AdminPass systeminfo
   ```

5. **Restarting/Shutdown:**
   You can initiate remote system restarts or shutdowns.

   Command (Restart):
   ```bash
   psexec \\RemoteComputerName -u Username -p Password shutdown /r /t 0
   ```
   Command (Shutdown):
   ```bash
   psexec \\RemoteComputerName -u Username -p Password shutdown /s /t 0
   ```
   Example (Restart):
   ```bash
   psexec \\Workstation03 -u AdminUser -p AdminPass shutdown /r /t 0
   ```

6. **Checking Services:**
   You can remotely check the status of services.

   Command:
   ```bash
   psexec \\RemoteComputerName -u Username -p Password sc query "ServiceName"
   ```
   Example:
   ```bash
   psexec \\Server04 -u AdminUser -p AdminPass sc query "Print Spooler"
   ```

7. **To remotely restart the Printer Spooler service** 

   ```bash
   psexec \\RemoteComputerName -u Username -p Password net stop spooler && net start spooler
   ```


   ```bash
   psexec \\Server123 -u AdminUser -p AdminPass net stop spooler && net start spooler
   ```

8. **Clear Event Logs:**
   You can remotely clear event logs on a target computer.

   ```bash
   psexec \\RemoteComputerName -u Username -p Password wevtutil cl Application
   ```

9. **Manage Remote Processes:**
   You can start, stop, or query processes on remote computers.

   ```bash
   # Start a process
   psexec \\RemoteComputerName -u Username -p Password "C:\Path\to\Executable.exe"

   # Stop a process
   psexec \\RemoteComputerName -u Username -p Password taskkill /IM "ProcessName.exe" /F

   # List processes
   psexec \\RemoteComputerName -u Username -p Password tasklist
   ```

10. **Remote Registry Manipulation:**
   You can remotely modify the Windows Registry.

   ```bash
   # Export a registry key
   psexec \\RemoteComputerName -u Username -p Password reg export "HKEY_LOCAL_MACHINE\Software\Key" "C:\ExportedKey.reg"

   # Import a registry key
   psexec \\RemoteComputerName -u Username -p Password reg import "C:\ImportedKey.reg"
   ```

11. **File Operations:**
   You can copy files to/from remote computers.

   ```bash
   # Copy files to remote computer
   psexec \\RemoteComputerName -u Username -p Password copy "C:\SourceFile.txt" "\\RemoteComputerName\C$\DestinationPath"

   # Copy files from remote computer
   psexec \\RemoteComputerName -u Username -p Password copy "\\RemoteComputerName\C$\SourceFile.txt" "C:\DestinationPath"
   ```

12. **Remote System Shutdown/Reboot:**
   You can remotely shut down or restart a computer.

   ```bash
   # Remote shutdown
   psexec \\RemoteComputerName -u Username -p Password shutdown /s /f /t 0

   # Remote restart
   psexec \\RemoteComputerName -u Username -p Password shutdown /r /f /t 0
   ```

12. **Running Batch Scripts Remotely:**
   You can execute batch scripts on remote computers.

   ```bash
   psexec \\RemoteComputerName -u Username -p Password "C:\Path\to\Script.bat"
   ```

13. **Remote Software Inventory:**
   You can gather information about installed software.

   ```bash
   psexec \\RemoteComputerName -u Username -p Password wmic product get name,version
   ```

14. **Remote Disk Space Check:**
   You can check available disk space on remote computers.

   ```bash
   psexec \\RemoteComputerName -u Username -p Password fsutil volume diskfree C:
   ```

15. **Remote User Sessions:**
   You can query user sessions on remote computers.

   ```bash
   psexec \\RemoteComputerName -u Username -p Password qwinsta
   ```

16. **Remote Command Prompt:**
    You can open a remote command prompt session.

    ```bash
    psexec \\RemoteComputerName -u Username -p Password cmd
    ```

