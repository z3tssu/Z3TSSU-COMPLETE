1. First Enable the Remote services on the Remote Machines

```powershell
Enable-PSRemoting -Force
```

2. Enable PowerShell Remoting on the remote machine (if not already enabled). Run the following command on the remote machine:

```powershell
  Enable-PSRemoting -Force
```
  
2. Test the connection to the remote machine using the `Test-WSMan` cmdlet:

```powershell
 Test-WSMan -ComputerName "REMOTE_MACHINE_NAME"
```

3. Once the connection is verified, you can use PowerShell Remoting to remove the user from the Administrators group and add them to the Users group. Run the following commands: