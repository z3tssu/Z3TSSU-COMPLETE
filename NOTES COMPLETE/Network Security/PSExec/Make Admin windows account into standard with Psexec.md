Certainly! Here are the detailed steps to remotely change an admin account to a standard account using PsExec:

1. Download PsExec:
   - Visit the Microsoft Sysinternals website.
   - Download the PsExec tool from the website and save it in an accessible location.

2. Open Command Prompt:
   - Press the Windows key.
   - Type "Command Prompt" and select the appropriate result to open the Command Prompt.

3. Navigate to PsExec's location:
   - Use the `cd` command to navigate to the directory where you saved the PsExec tool.
   - For example: `cd C:\Users\YourUsername\Downloads`

4. Run PsExec:
   - In the Command Prompt, enter the following command:
     ```
     psexec \\RemoteComputerName -u AdminUsername -p AdminPassword cmd.exe
     ```
   - Replace "RemoteComputerName" with the name or IP address of the remote computer.
   - Replace "AdminUsername" and "AdminPassword" with the credentials of the administrator account on the remote computer.

5. Remote Command Prompt:
   - PsExec will open a new Command Prompt window on the remote computer using the provided administrator account credentials.

6. Change Account Type:
   - In the remote Command Prompt window, enter the following command:
     ```
     net localgroup Administrators 
     AdminUsername /delete
     net localgroup Users Username /add
     
     ```
   - Replace "AdminUsername" with the username of the admin account you want to change to a standard account.

7. Confirm and Exit:
   - After running the command, verify the account type change by using the following command:
     ```
     net localgroup Administrators
     ```
   - Ensure that the admin account has been removed from the list of members.

Please ensure that you have the necessary permissions and authorization to make changes on the remote computer before attempting these steps.