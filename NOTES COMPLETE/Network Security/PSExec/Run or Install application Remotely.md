## Active Directory PSExec below:

1. [[1. PSEXEC  Execute Process Remotely#Psexec |Basic PSExec]]

## Launching Remote Powershell Session 

```c
psexec \\Computer_Name -s powershell
```

## Copy and Execute a File on a Remote Computer

```c
psexec \\Computer_name_OR_IP_address -si -c C:\Location_of_the_Application
```

## Installing Application on Remote Computer

- Note, you can install whatever programs you want, but typically and MSI package is easier.

```c
psexec \\Computer_Name_OR_IP -si -c c:\ApplicationLocation.exe /S
```

## Copying MSI file to Remote Computer and Executing the File

1. Copy the file

```c
copy "C:\Source_File_Location.msi" "\\DestinationPath"
```

```c
copy "C:\RemotingToolSilentInstaller\RemotingTool.msi" "\\10.136.69.37\c$\Program Files\"
```

2. Executing the MSI File

```powershell
psexec \\10.136.69.37 -i -s msiexec.exe /i "c:\Program Files\RemotingTool.msi" /qn /norestart /s
```

### Running with high Priority

```powershell
psexec \\10.136.69.37 cmd /c start /HIGH "msiexec.exe /i \"c:\Program Files\RemotingTool.msi\" /qn /norestart /s"

```

3. Executing an EXE File

```powershell
psexec \\10.136.69.37 "c:\Program Files\RemotingTool.exe" /qn /norestart /silent
```


